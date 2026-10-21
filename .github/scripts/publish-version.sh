#!/usr/bin/env bash
#
# Copy a built Jupyter Book into <SLUG>/ on the gh-pages branch of REMOTE,
# leaving every other version directory untouched, and regenerate the root
# version index.
#
# Env:
#   SLUG             subpath to publish into, e.g. "main" or "v1.0.0"  (required)
#   BUILD_DIR        directory holding the built HTML                  (required)
#   REMOTE           git URL to push to; a local path works in tests   (required)
#   SOURCE_REF       short ref/sha used in the commit message          (optional)
#   GIT_SHA          commit built, shown (shortened) on versions.html  (optional)
#   DEFAULT_VERSION  version the site root redirects to; default main  (optional)
#   DRY_RUN          if "1", do everything except the final push       (optional)
#
set -euo pipefail

: "${SLUG:?SLUG is required}"
: "${BUILD_DIR:?BUILD_DIR is required}"
: "${REMOTE:?REMOTE is required}"
SOURCE_REF="${SOURCE_REF:-unknown}"
short_sha="${GIT_SHA:-}"          # may legitimately be unset outside CI
short_sha="${short_sha:0:7}"
short_sha="${short_sha:-unknown}"
DEFAULT_VERSION="${DEFAULT_VERSION:-main}"
DRY_RUN="${DRY_RUN:-0}"

if [ ! -d "$BUILD_DIR" ]; then
  echo "BUILD_DIR '$BUILD_DIR' does not exist" >&2
  exit 1
fi

# Reject slugs that could escape the site root, collide with git's own dir, or
# need escaping once interpolated into the HTML below.
if ! printf '%s' "$SLUG" | grep -Eq '^[A-Za-z0-9][A-Za-z0-9._-]*$' \
   || [ "$SLUG" = ".git" ] || case "$SLUG" in *..*) true ;; *) false ;; esac; then
  echo "Refusing unsafe SLUG '$SLUG'" >&2
  exit 1
fi

site="$(mktemp -d)"
trap 'rm -rf "$site"' EXIT

# Check out gh-pages, or start it as an empty orphan branch.
if git clone --depth 1 --branch gh-pages "$REMOTE" "$site" 2>/dev/null; then
  echo "Cloned existing gh-pages branch."
else
  echo "No gh-pages branch yet, creating one."
  rm -rf "$site"
  git clone --depth 1 "$REMOTE" "$site"
  git -C "$site" checkout --orphan gh-pages
  git -C "$site" rm -rf --quiet --ignore-unmatch . >/dev/null 2>&1 || true
  # An orphan checkout leaves the old worktree on disk; clear it.
  find "$site" -mindepth 1 -maxdepth 1 ! -name .git -exec rm -rf {} +
fi

git -C "$site" config user.name "github-actions[bot]"
git -C "$site" config user.email "41898282+github-actions[bot]@users.noreply.github.com"

# Replace only this version's directory.
rm -rf "${site:?}/${SLUG:?}"
mkdir -p "$site/$SLUG"
cp -a "$BUILD_DIR/." "$site/$SLUG/"

# Sphinx output contains _static/, _sources/ ... which Jekyll would drop.
touch "$site/.nojekyll"

# Provenance for this version, kept alongside it so versions.html can report
# each version's own build without needing to know anything about the others.
printf '%s\t%s\n' "$(date -u '+%Y-%m-%d %H:%M UTC')" "$short_sha" \
  > "$site/$SLUG/.build-info"

# versions.html always lists whatever versions now exist.
{
  echo '<!doctype html>'
  echo '<html lang="en"><head><meta charset="utf-8">'
  echo '<meta name="viewport" content="width=device-width, initial-scale=1">'
  echo '<title>CEOS Collection and Granule Discovery Best Practices -- versions</title>'
  echo '<style>body{font-family:system-ui,sans-serif;max-width:40rem;margin:4rem auto;padding:0 1rem;line-height:1.6}</style>'
  echo '</head><body>'
  echo '<h1>CEOS Collection and Granule Discovery Best Practices</h1>'
  echo '<p>Published versions:</p><ul>'
  for dir in "$site"/*/; do
    name="$(basename "$dir")"
    # Versions published before .build-info existed simply show no provenance.
    info=""
    if [ -f "$dir/.build-info" ]; then
      IFS=$'\t' read -r built sha < "$dir/.build-info" || true
      info="$(printf ' <small>built %s &middot; <code>%s</code></small>' "$built" "$sha")"
    fi
    printf '<li><a href="%s/">%s</a>%s</li>\n' "$name" "$name" "$info"
  done
  echo '</ul></body></html>'
} > "$site/versions.html"

# The site root redirects to DEFAULT_VERSION -- but only once that version has
# actually been published, otherwise the root would point at a 404. Until then
# the root shows the version list instead.
if [ -d "$site/$DEFAULT_VERSION" ]; then
  echo "Root redirects to /$DEFAULT_VERSION/"
  {
    echo '<!doctype html>'
    echo '<html lang="en"><head><meta charset="utf-8">'
    printf '<title>CEOS Collection and Granule Discovery Best Practices</title>\n'
    printf '<link rel="canonical" href="%s/">\n' "$DEFAULT_VERSION"
    printf '<meta http-equiv="refresh" content="0; url=%s/">\n' "$DEFAULT_VERSION"
    # location.replace keeps the redirect out of the back-button history, and
    # forwards any deep link's query/fragment.
    printf '<script>location.replace("%s/" + location.search + location.hash);</script>\n' "$DEFAULT_VERSION"
    echo '</head><body>'
    printf '<p>Redirecting to <a href="%s/">%s</a> &mdash; or see <a href="versions.html">all versions</a>.</p>\n' \
      "$DEFAULT_VERSION" "$DEFAULT_VERSION"
    echo '</body></html>'
  } > "$site/index.html"
else
  echo "No '$DEFAULT_VERSION' directory yet, root shows the version list."
  cp "$site/versions.html" "$site/index.html"
fi

git -C "$site" add -A
if git -C "$site" diff --cached --quiet; then
  echo "Nothing changed, skipping push."
  exit 0
fi
git -C "$site" commit --quiet -m "Publish $SLUG from $SOURCE_REF"

if [ "$DRY_RUN" = "1" ]; then
  echo "DRY_RUN=1, not pushing. Resulting tree:"
  git -C "$site" ls-tree -r --name-only HEAD | sed 's/^/  /'
  exit 0
fi

git -C "$site" push origin gh-pages
