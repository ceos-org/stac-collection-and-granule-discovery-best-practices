[Previous](collection-catalogs.md) | [Next](collection-metadata.md)
# 6. Granule Metadata Best Practices

[//]: # (this is a comment)

## 6.1 Overview

Explain main parts

## 6.2 Properties

- mandatory/recommended properties / extensions
- refer to mapping between STAC and OS-EO properties. (DLR)

> **CEOS-STAC-BP-XXX - Granule representation [Requirement]**<a name="BP-TBD"></a>
>
> A(n EO) Granule metadata record shall be represented as a STAC Item according to version v1.0.0 of the "STAC Item Specification" [[AD03]](./introduction.md#AD03).

> **CEOS-STAC-BP-013B - Temporal extents [Recommended]**<a name="BP-013B"></a>
>
> STAC implementations should represent temporal extents in Items with the `start_datetime` and `end_datetime` properties and include the value for `start_datetime` also as `datetime` property.

> **CEOS-STAC-BP-014 - Geographical extents [Requirement]**<a name="BP-014"></a>
>
> STAC implementations shall represent geographical extents of Items with the `geometry` property (GeoJSON Geometry object or null if not available).

Geographical extents of Items are represented using GeoJSON geometry objects [RFC7946](#AD4) in STAC item search responses.  This representation can natively represent multi-point, multi-line and multi-polygon geometries, thus no additional guidance similar to `CEOS-BP-014B`, `CEOS-BP-014C` and `CEOS-BP-014D` is required.


> **CEOS-STAC-BP-014E - Minimum-bounding rectangle [Requirement]**<a name="BP-014E"></a>
>
> CEOS implementations should render spatial extents using a minimum-bounding
rectangle (MBR) with a GeoJSON `bbox` property [RFC7946](#AD4) in addition to the native more accurate
representation of that extent with the `geometry` property. The value of the bbox
element must be an array of length 4 (two long/lat pairs), with the southwesterly point followed by the northeasterly point.

The `bbox` item property is mandatory according to the STAC Item specification unless `geometry` is null.



## 6.3 Assets and roles

- what names (roles, media types) should be used for quicklooks, bands, ...

| :warning:        | For various associations, both Assets and Links can be used.  To avoid redundancy the Best Practice should make a recommendation and not request that both are implemented.  This is future work.   |
|---------------|:------------------------|

> **CEOS-STAC-BP-TBD - Metadata assets [Requirement]**<a name="BP-TBD"></a>
>
> If a resopurce association can be encode as Assets or Link (e.g. rel="icon", rel="alternate"), STAC implementations shall give precedence to the encoding as Asset.


> **CEOS-STAC-BP-012-2 - Metadata assets [Requirement]**<a name="BP-012-2"></a>
>
> STAC implementations shall provide a URL to the granule’s (or collection) metadata encoding in a particular standard representation, via an Asset object with role=`metadata`.


> **CEOS-STAC-BP-012E - Link and Asset type attributes [Recommended]**<a name="BP-012E"></a>
>
> STAC implementations shall specify the media (MIME) type of the artifact
associated with a resource by specifying the "type" attribute of the Link object or Asset object.

The table below list some frequently used formats and the corresponding media type (`type`) to be used for metadata assets.

| **Format**                   | **type** |   
| --------                   | --------- | 
| [ISO19139](https://www.iso.org/standard/32557.html)      | `application/vnd.iso.19139+xml` |  
| [ISO19139-2](https://www.iso.org/standard/57104.html)      | `application/vnd.iso.19139-2+xml` | 
| [ISO19115-3](https://www.iso.org/standard/32579.html)      | `application/vnd.iso.19115-3+xml` | 
| [ISO19157-2](https://www.iso.org/standard/66197.html)      | `application/vnd.iso.19157-2+xml` | 
| [OGC 10-157r4](https://docs.opengeospatial.org/is/10-157r4/10-157r4.html)  | `application/gml+xml;profile=http://www.opengis.net/spec/EOMPOM/1.1`  |
| [OGC 17-003r2](https://docs.opengeospatial.org/is/17-003r2/17-003r2.html)  | `application/geo+json;profile=http://www.opengis.net/spec/eo-geojson/1.0`  |
| [Dublin Core](http://www.loc.gov/standards/sru/recordSchemas/dc-schema.xsd)  | `application/xml`  |
| [Markdown](https://datatracker.ietf.org/doc/html/rfc7763)  | `text/markdown`  |


> **CEOS-STAC-BP-015 - Browse image [Recommended]**<a name="BP-015"></a>
>
> STAC implementations should provide a URL to the granule’s browse image when available, via an Asset object with role=`overview`.

> **CEOS-STAC-BP-TBD - Thumbnail image [Recommended]**<a name="BP-TBD"></a>
>
> STAC implementations should provide a URL to the granule’s thumbnail image when available, via an Asset object with role=`thumbnail`.


> **CEOS-STAC-BP-016 - Data access [Recommended]**<a name="BP-016"></a>
>
> STAC implementations should provide data access URL for the granule via an Asset object with role=`data`.


.Example: Asset object for Cloud Optimized GeoTIFF data
```
"assets": {
        "analytic": {
            "href": "https://storage.googleapis.com/sample-cogs/cog/20210515_145754_03_245c_3B_AnalyticMS.tif",
            "type": "image/tiff; application=geotiff; profile=cloud-optimized",
            "title": "4-Band Analytic",
            "roles": [
                "analytic", "data"
            ]
        }
```

.Example: Asset object for Zarr data
```
 "assets": {
    "zmetadata": {
      "roles": [
        "data",
        "metadata",
        "zarr-consolidated-metadata"
      ],
      "description": "Consolidated metadata file for Zarr store",
      "href": "https://storage.sbg.cloud.ovh.net/v1/AUTH_d40770b0914c46bfb19434ae3e97ae19/hdsa-public/prisma_v2/20200410/.zmetadata",
      "type": "application/json"
    },
```


> **CEOS-STAC-BP-016B - Data access to multiple files [Recommendation]**<a name="BP-016B"></a>
>
> When data access to a granule in a granule search response is to be provided in multiple physical files, each file should be linked to via a separate Asset object with role=`data`.


> **CEOS-STAC-BP-TBD - Common band names [Recommendation]**<a name="BP-TBD"></a>
>
> If access to individual bands is provided via assets, then [Common Band Names](https://github.com/stac-extensions/eo/blob/main/README.md#common-band-names) should be used, preferably according to the forthcoming OGC Best Practice document [[RD03]](./introduction.md#RD03).
>

> **CEOS-STAC-BP-TBD - Asset roles [Recommendation]**<a name="BP-TBD"></a>
>
> If aditional asset roles are required (e.g. for cloud marks, snow masks etc), preference shall be given to the asset role names of the [corresponding Best Practices](https://github.com/radiantearth/stac-spec/blob/master/best-practices.md#list-of-asset-roles).
>

## 6.4 Links and relations

- how to encode "offerings" (i.e. links to OGC or other service endpoints in a STAC item) ?
- how to encode cloud-native access (zarr, COG) in STAC item.
- how to encode different resource access methods e.g. http download link or S3 location url
- how/when to use the asset alternate links extension?
- Recommendation to properly link to all (raster) assets in an EO product. (VITO)


> **CEOS-STAC-BP-012-1 - Reference to metadata [Recommended]**<a name="BP-012-1"></a>
>
> STAC implementations should include Link objects in Items or Collections with rel="alternate" or rel=”via” for detailed representation of the metadata. (The “via” relation should be preferred to convey the authoritative resource or the source of the information from where the Item or Collection is made.)


> **CEOS-STAC-BP-012C - Reference to documentation [Recommended]**<a name="BP-012C"></a>
>
> STAC implementations should use a Link object with rel="describedby" to reference from a collection to its documentation or from an item to its documentation.

Note: although some implementations use rel="about" for the same purpose, rel="describedby" is recommended by https://docs.ogc.org/DRAFTS/20-024.html.

## 6.5 Facilitating catalog federation

> **CEOS-STAC-BP-TBD - Root relation [Recommendation]**<a name="BP-TBD"></a>
>
> It is discouraged to use the rel="root" relation in STAC item encodings as the item's original data provider's catalog/collections maybe included in a federated catalog with a different root.
>


## CEOS-ARD recommendations

- TBD

