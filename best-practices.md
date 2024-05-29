[Previous](objectives-needs.md) | [Table of contents](README.md) | [Next](granule-catalogs.md)
***
# 3. Best Practices

[//]: # (this is a comment)

## 3.1 Introduction

There are three different levels of obligation for the Best Practices presented in this document:
- “Requirements” (`REQ`) are mandatory and must be implemented,
- “Conditional requirements” (`CREQ`) are only mandatory in certain contexts or under certain conditions,
- “Recommendations” (`REC`) are optional, but strongly recommended for interoperability.

In addition, "Permissions" (`PER`) indicate allowed deviations from one of more of the underlying specifications in cases where a subset of the original requirements is deemed sufficient in the context of CEOS.


## 3.2 Catalog Best Practices

The Best Practices described in this section apply to both `CEOS STAC Collection Catalogs` and `CEOS STAC Granule Catalogs`.

> **CEOS-STAC-PER-3210 - API Feature paths [Permission]**<a name="BP-3210"></a>
>
> A CEOS STAC catalog implementation is not required to use fixed paths to navigate from resource to resource. It shall support discovering the path via the proper relation (rel="xyz") in the corresponding resource's representation.

For example, the rel="items" path for a collection is not necessarily collection path with "/items" appended but may be the path to a different API at a different location.

> **CEOS-STAC-PER-3220 - API Feature relations [Permission]**<a name="BP-3220"></a>
>
> A CEOS STAC catalog implementation is not required to:
  - Support the /api path or provide an OpenAPI description of its interface
  - Support the rel="service-desc" from its landing page (root catalog)
  - Support the /conformance path
  - Support the rel="conformance" from its landing page (root catalog)

### 3.2.1 Advertising additional search parameters

The STAC API and underlying OGC API specifications define the list of search parameters to be supported.  Catalog implementations may however support additional parameters the meaning/intepretation of which is not defined by these specifications.

> **CEOS-STAC-CREQ-3230 - Additional search parameters [Conditional]**<a name="BP-3230"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters shall implement the "STAC API Filter Extension" [[AD06]](./introduction.md#AD06), i.e.:
> - Advertise the additional filter parameters via the corresponding Queryables responses (JSON Schema),
> - Use the additional filter parameters inside the filter expression passed via the `filter` (HTTP) query parameter.

The endpoint to which the above additional parameters apply depends on the context: i.e. collection search, granule search via rel="items" endpoint or granule search via the rel="search" endpoint.  

> **CEOS-STAC-REQ-3235 - Parameter Descriptions [Requirement]**<a name="BP-3235"></a>
>
> The GET response for the rel=`queryables` endpoint in application/schema+json representation shall provide additional information about search parameters including:
- `type` of the parameter (e.g. array, string, integer, number, ...) 
- `title` of the parameter providing a human readable title.
- `format` of the string parameter (e.g. "uri", "date-time")
- `enum` to enumerate valid (string) values
- `minItems`, `maxItems` to constrain the size of arrays
- `minimum`, `maximum` to constrain the range of a numerical parameter

It is not allowed to constrain the values of temporal search parameters using "minimum" and "maximum" in the JSON schema returned by the rel=`queryables` endpoint of a collection.  STAC client implementations are therefore recommended to constrain the range of the temporal search parameters using the temporal interval information advertised in the STAC collection metadata.

> **CEOS-STAC-CREQ-3240 - Additional search parameters [Conditional]**<a name="BP-3240"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters via a filter expression shall support the following additional query parameters and advertise the corresponding conformance classes in the landing page (See also "STAC API Filter Extension" [[AD06]](./introduction.md#AD06):
> - filter
> - filter-lang

> **CEOS-STAC-CREQ-3250 - CQL subset [Conditional]**<a name="BP-3250"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters via a filter expression shall support at least the following conformance classes of CQL2 (See also "STAC API Filter Extension" [[AD06]](./introduction.md#AD06) and "OGC21-065, Common Query Language (CQL2)" [[AD10]](./introduction.md#AD10):
> - CQL2 Text
> - Basic CQL2


> **CEOS-STAC-REC-3260 - Additional search parameter names [Recommendation]**<a name="BP-3260"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters for collection search (e.g. search by platform, instrument, organisation) or granule search (e.g. by polarisation mode, orbit direction, orbit number, cloud cover, etc.) should, by preference, use names consistent with the names defined in the OpenSearch extension for Earth Observation OGC 13-026r9 [[RD04]](./introduction.md#RD04).


| :question: |  Should a STAC API extension be proposed covering available (OpenSearch) parameters allowing `queryables` responses to refer to these by reference ?  An example is shown below.  It would allow implementations to choose their parameter names and "connect" them to interoperable definitions from the OGC OpenSearch spec (with mappings to ISO, UMM, etc.) via $ref. |
|---------------|:------------------------|

```json
   "doi" : {
       "description" : "{eo:doi}",
       "$ref": "https://github.com/ceos-wgiss/opensearch-eo/v1.1/schema.json#/properties/doi"
    }
```

Extract of a possible STAC extension (YAML) with additional reusable parameter definitions as per OGC13-026r9.

```
"$schema": http://json-schema.org/draft-07/schema#
"$id": https://github.com/ceos-wgiss/opensearch-eo/v1.1/schema.json#
title: OpenSearch parameter declarations
type: object
properties:
  #
  # OGC13-026r9 Table 4
  #
  doi:
    description: "{eo:doi}"
    title: Doi
    type: string
  instrument:
    description: "{eo:instrument}"
    title: Instrument
    type: string
```

### 3.2.2 Search response

> **CEOS-STAC-REQ-3265 - numberMatched [Requirement]**<a name="BP-3265"></a>
>
> A CEOS STAC catalog search response shall include the `numberMatched` property providing the number of items meeting the selection parameters, possibly estimated.


> **CEOS-STAC-REC-3270 - numberReturned [Recommendation]**<a name="BP-3270"></a>
>
> A CEOS STAC catalog search response should include the `numberReturned` property.

Both properties are optional in https://github.com/radiantearth/stac-api-spec/blob/main/fragments/itemcollection/README.md.
The above Best Practices apply to all available search endpoints e.g. at rel="data", rel="items" or rel="search".

> **CEOS-STAC-REQ-3280 - Result set navigation [Requirement]**<a name="BP-3280"></a>
>
> The $.links array in a search response shall include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='next'.

> **CEOS-STAC-REC-3290 - Result set navigation [Recommendation]**<a name="BP-3290"></a>
>
> The $.links array in a search response should include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='self', rel='prev', rel='first', rel='last'.

> **CEOS-STAC-REC-3295 - Result set navigation [Recommendation]**<a name="BP-3295"></a>
>
> Implementations may decide to only implement forward traversal via navigation/paging links. The $.links array in a search response should include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='self', rel='prev', rel='next', rel='first', rel='last' per result page as shown below.

| **Use case**   | **first** |  **prev** |  **self** | **next** | **last** |
| --------   | --------- | --------- | --------- | --------- | --------- |
| First page | Optional |  Not allowed |  Mandatory  | Mandatory  |  Optional |
| Middle pages | Optional |  Optional | Mandatory  | Mandatory  | Optional  |
| Last page | Optional |  Optional | Mandatory  |  Not allowed  | Optional  |
| Empty result set | Not allowed  |  Not allowed |  Mandatory  | Not allowed  |  Not allowed |
| Single page | Optional |  Not allowed |  Mandatory  | Not allowed  |  Optional |

> **CEOS-STAC-REC-3297 - Exceptions [Recommendation]**<a name="BP-3297"></a>
>
> A CEOS STAC catalog search response in case of exception shall return the applicable HTTP status code and a JSON response with the following members:

* "code" (string): mandatory.
* "description" (string): optional.

Although this is only explicitly defined as [exception response structure for the rel="search" endpoint](https://api.stacspec.org/v1.0.0/item-search/#tag/Item-Search/operation/getItemSearch), it is good practice to provide similar (JSON) response bodies at the other endpoints, including rel="items" and rel="data". 

> **CEOS-STAC-REC-3299 - Alternative response formats [Recommendation]**<a name="BP-3299"></a>
>
> A CEOS STAC catalog supporting alternative search response formats shall allow this via content negotiation and use common media types also used for assets and links as referenced in the current Best Practices document (See [Link and Asset type](#BP-3325)).

## 3.3 Metadata Best Practices

The Best Practices described in this section apply to [CEOS STAC Collection Metadata](./collection-metadata.md) and [CEOS STAC Granule Metadata](./granule-metadata.md).

### 3.3.1 Properties

> **CEOS-STAC-REC-3305 - Common metadata [Recommendation]**<a name="BP-3305"></a>
>
> CEOS implementations should encode the following [STAC common metadata properties](https://github.com/radiantearth/stac-spec/blob/master/item-spec/common-metadata.md#instrument) in granule or collection representations with a name corresponding to the preferred label defined in the corresponding GCMD keyword scheme:

| **Field name**                   | **GCMD keyword scheme** |   
| --------                   | --------- | 
|  platform  |    [GCMD platform](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/platforms?gtm_scheme=platforms)   |
|  instruments[]  |  [GCMD instrument](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/instruments?gtm_scheme=instruments)   |
|  constellation  |   [GCMD platform](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/platforms?gtm_scheme=platforms)   |
|  mission  |   [GCMD platform](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/platforms?gtm_scheme=platforms)  |

> **CEOS-STAC-REC-3308 - Controlled keywords [Recommendation]**<a name="BP-3308"></a>
>
> CEOS implementations should encode controlled keywords in granule or collection representations using the STAC Themes Extension Specification [[AD29]](./introduction.md#AD29).


```json
    "themes": [
      {
        "concepts": [
          {
            "id": "35433dcc-ccdd-5b28-a777-52658c74367d",
            "title": "Atmospheric Pressure",
            "url": "https://earth.esa.int/concept/35433dcc-ccdd-5b28-a777-52658c74367d"
          },
          {
            "id": "068e361e-639e-5823-8219-f8ee3e90c4d7",
            "title": "Atmospheric Chemistry",
            "url": "https://earth.esa.int/concept/068e361e-639e-5823-8219-f8ee3e90c4d7"
          }
        ],
        "scheme": "https://earth.esa.int/concepts/concept_scheme/earth-topics"
      },
      {
        "concepts": [
          {
            "id": "b9c56939-c624-467d-b196-e56a5b660334",
            "title": "ATMOSPHERIC CHEMISTRY",
            "url": "https://gcmd.earthdata.nasa.gov/kms/concept/b9c56939-c624-467d-b196-e56a5b660334"
          }
        ],
        "scheme": "https://gcmd.earthdata.nasa.gov/kms/concepts/concept_scheme/sciencekeywords"
      }
  ]
```

### 3.3.2 Assets and roles

> **CEOS-STAC-REQ-3310 - Resource associations [Requirement]**<a name="BP-3310"></a>
>
> If a resource association can be encoded as Assets (e.g. role="metadata") or Link (e.g. rel="icon", rel="alternate"), STAC implementations shall give precedence to the encoding as Asset.

> **CEOS-STAC-REQ-3320 - Metadata assets [Requirement]**<a name="BP-3320"></a>
>
> CEOS STAC implementations shall provide a URL of the collection or granule metadata encoding in a particular standard representation (if available), via an Asset object with role=`metadata`.


> **CEOS-STAC-REQ-3325 - Link and Asset type attributes [Requirement]**<a name="BP-3325"></a>
>
> CEOS STAC implementations shall specify the media (MIME) type of the artifact
associated with a resource by specifying the "type" attribute of the Link object or Asset object.  The media types (`type`) from the table below shall be used for assets/links to the corresponding resources.

The table below lists some frequently used formats and the corresponding media type for metadata assets.

| **Format**                   | **type** |   
| --------                   | --------- | 
| [DIF10](https://www.earthdata.nasa.gov/esdis/esco/standards-and-practices/directory-interchange-format-dif-standard)           | `application/dif10+xml` |  
| [ISO19139](https://www.iso.org/standard/32557.html)      | `application/vnd.iso.19139+xml` |  
| [ISO19139-2](https://www.iso.org/standard/57104.html)      | `application/vnd.iso.19139-2+xml` | 
| [ISO19115-3](https://www.iso.org/standard/32579.html)      | `application/vnd.iso.19115-3+xml` | 
| [ISO19157-2](https://www.iso.org/standard/66197.html)      | `application/vnd.iso.19157-2+xml` | 
| [OGC 10-157r4](https://docs.opengeospatial.org/is/10-157r4/10-157r4.html)  | `application/gml+xml;profile=http://www.opengis.net/spec/EOMPOM/1.1`  |
| [OGC 17-003r2](https://docs.opengeospatial.org/is/17-003r2/17-003r2.html)  | `application/geo+json;profile=http://www.opengis.net/spec/eo-geojson/1.0`  |
| [OGC 17-084r1](https://docs.ogc.org/bp/17-084r1/17-084r1.html)  | `application/geo+json;profile=http://www.opengis.net/spec/eoc-geojson/1.0`  |
| [Dublin Core](http://www.loc.gov/standards/sru/recordSchemas/dc-schema.xsd)  | `application/xml`  |

If additional media types are required, preference shall be given to the media types listed in [Common Media Types Best Practices](https://github.com/radiantearth/stac-spec/blob/master/best-practices.md#common-media-types-in-stac).


> **CEOS-STAC-REC-3330 - Asset roles [Recommendation]**<a name="BP-3330"></a>
>
> If additional asset roles are required (e.g. for cloud masks, snow masks etc), preference shall be given to the asset role names of the general  [Asset Roles Best Practices](https://github.com/radiantearth/stac-spec/blob/master/best-practices.md#list-of-asset-roles).


### 3.3.3 Links and relations


> **CEOS-STAC-REC-3350 - Reference to metadata [Recommendation]**<a name="BP-3350"></a>
>
> Implementations should use Link objects with rel="alternate" or rel=”via” for referencing detailed representation of the metadata for a collection or granule. (The “via” relation should be preferred to convey the authoritative resource or the source of the information from where the Collection/Item is made.)


> **CEOS-STAC-REC-3360 - Reference to documentation [Recommendation]**<a name="BP-3360"></a>
>
> Implementations should use a Link object with rel="describedby" to reference from a collection or granule to its documentation.

The table below list some frequently used formats for documentation and their corresponding media type (`type`).

| **Format**                   | **type** |   
| --------                   | --------- | 
| [Markdown](https://datatracker.ietf.org/doc/html/rfc7763)  | `text/markdown`  |
| [PDF](https://en.wikipedia.org/wiki/PDF)  | `application/pdf`  |


### 3.3.4 Facilitating catalog federation

> **CEOS-STAC-REQ-3410 - Absolute links [Requirement]**<a name="BP-3410"></a>
>
> "href" attributes in links or assets shall use absolute paths and not relative paths in CEOS STAC collection or granule metadata records.

> **CEOS-STAC-REC-3440 - Root relation [Recommendation]**<a name="BP-3440"></a>
>
> Implementations should not use the rel="root" relation in STAC collection and item encodings as the original catalog/collections may be referenced or included in a federated catalog with a different root.
>

| :question: |  should we add a recommendation about (STAC) identifiers to be used for collections that remain unique after federation ?  e.g. multiple agencies with Landsat or Sentinel collections may cause naming clashes... Does such recommendation already exist in other CEOS contexts ? |
|---------------|:------------------------|

***
[Previous](objectives-needs.md) | [Table of contents](README.md) | [Next](granule-catalogs.md)
