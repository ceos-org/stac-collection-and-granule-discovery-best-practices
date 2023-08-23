[Previous](objectives-needs.md) | [Next](granule-catalogs.md)
# 3. Best Practices

[//]: # (this is a comment)

## 3.1 Introduction

There are three different levels of obligation for the Best Practices presented in the current document:
- “Requirements” (`REQ`) are mandatory and must be implemented,
- “Recommendations” (`REC`) are optional, but strongly recommended for interoperability.

In addition, "Permissions" (`PER`) indicate allowed deviations from one of more of the underlying specifications in cases where a subset of the original requirements is deemed sufficient in the context of CEOS.




## 3.2 General Best Practices



| :memo: |  Put general requirements here, applicable to multiple chapters (e.g. common for granule/collection to avoid repetition) ?  |
|---------------|:------------------------|

- candidate recommendations covering both granule / collections:
  - no need for /conformance, /api
  - result navigation
  - media types to use
  - common roles / relations
      - metadata
      - documentation
      - ...
      - 


## 3.2.1 Catalog Best Practices

The Best Practices described in this section apply to `CEOS STAC Collection Catalogs` and `CEOS STAC Granule Catalogs`.

> **CEOS-STAC-PER-310 - API Feature paths [Permission]**<a name="BP-310"></a>
>
> A CEOS STAC catalog implementation is allowed to not use fixed paths to navigate from resource to resource, but shall support discovering the actual path via the proper relation (rel="xyz") in the corresponding resource's representation.

For example, the rel="items" path for a collection is not necessarily the path towards the collection with "/items" appended but may be on a different server.

> **CEOS-STAC-PER-320 - API Feature relations [Permission]**<a name="BP-320"></a>
>
> A CEOS STAC catalog implementation is not required to:
  - Support the /api path or provide an OpenAPI description of its interface
  - Support the rel="service-desc" from its landing page (root catalog)
  - Support the /conformance path
  - Support the rel="conformance" from its landing page (root catalog)


### Advertising additional search parameters

- rel="queryables", JSON Schema (optional)
- CQL (optional)

The STAC API and underlying OGC API specifications define the list of search parameters to be supported.  Catalog implementations may however support additional parameters the meaning/intepretation of which is not defined by these specifications.

> **CEOS-STAC-REQ-330 - Additional search parameters [Requirement]**<a name="BP-330"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters shall implement the "STAC API Filter Extension" [[AD06]](./introduction.md#AD06), i.e.:
> - Advertise the additional filter parameters via the corresponding Queryables responses (JSON Schema),
> - Use the additional filter parameters inside the filter expression passed via the `filter` (HTTP) query parameter.

The endpoint to which the above additional parameters apply depends on the context: i.e. collection search, granule search via rel="items" endpoint or granule search via the rel="search" endpoint.  


> **CEOS-STAC-REQ-340 - Additional search parameters [Requirement]**<a name="BP-340"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters via a filter expression shall support the following additional query parameters and advertise the corresponding conformance classes in the landing page (See also "STAC API Filter Extension" [[AD06]](./introduction.md#AD06).:
> - filter
> - filter-lang

> **CEOS-STAC-REQ-350 - CQL subset [Requirement]**<a name="BP-350"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters via a filter expression shall support at least the following conformance classes of CQL2 (See also "STAC API Filter Extension" [[AD06]](./introduction.md#AD06) and "OGC21-065, Common Query Language (CQL2)" [[AD10]](./introduction.md#AD10).:
> - CQL2 Text
> - Basic CQL2

| :memo:        | There is currently no mechanism allowing to advertise different CQL filtering capabilities at different endpoints.    |
|---------------|:------------------------|


| :memo:        | OGC API Features Part 3 allows a [simpler way to add additional search parameters](https://docs.ogc.org/DRAFTS/19-079r1.html#queryables-query-parameters) allowing them to be used as HTTP query parameters directly.  The same approach is not (yet) available in the STAC API Filtering extension.  See See https://github.com/stac-api-extensions/filter/issues/15  |
|---------------|:------------------------|


> **CEOS-STAC-REC-360 - Additional search parameter names [Recommendation]**<a name="BP-360"></a>
>
> A CEOS STAC collection/granule catalog supporting additional search parameters for collection search (e.g. search by platform, instrument, organisation) or granule search (e.g. by polarisation mode, orbit direction, orbit number, cloud cover, etc.) should by preference use names consistent with the names defined in the OpenSearch extension for Earth Observation OGC 13-026r9 [[RD04]](./introduction.md#RD04).


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

### 5earch response

> **CEOS-STAC-REQ-370 - numberMatched [Requirement]**<a name="BP-370"></a>
>
> A CEOS STAC catalog search response shall include the `numberMatched` property providing the number of items meeting the selection parameters, possibly estimated.


> **CEOS-STAC-REC-375 - numberReturned [Recommendation]**<a name="BP-375"></a>
>
> A CEOS STAC catalog search response should include the `numberReturned` property.

Both properties are optional in https://github.com/radiantearth/stac-api-spec/blob/main/fragments/itemcollection/README.md.
The above Best Practices apply to all available search endpoints e.g. at rel="data", rel="items" or rel="search".

> **CEOS-STAC-REQ-380 - Result set navigation [Requirement]**<a name="BP-380"></a>
>
> The $.links array in a search response shall include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='next'.

> **CEOS-STAC-REC-390 - Result set navigation [Recommendation]**<a name="BP-390"></a>
>
> The $.links array in a search response should include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='self', rel='prev', rel='first', rel='last'.


> **CEOS-STAC-REC-395 - Result set navigation [Recommendation]**<a name="BP-395"></a>
>
> The $.links array in a search response should include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='self', rel='prev', rel='next', rel='first', rel='last' per result page as shown below.

| **Use case**   | **first** |  **prev** |  **self** | **next** | **last** |
| --------   | --------- | --------- | --------- | --------- | --------- |
| First page | Optional |  Not allowed |  Mandatory  | Mandatory  |  Optional |
| Middle pages | Optional |  Optional | Mandatory  | Mandatory  | Optional  |
| Last page | Optional |  Optional | Mandatory  |  Not allowed  | Optional  |
| Empty result set | Not allowed  |  Not allowed |  Mandatory  | Not allowed  |  Not allowed |
| Single page | Optional |  Not allowed |  Mandatory  | Not allowed  |  Optional |



## 3.2.2 Metadata Best Practices

The Best Practices described in this section apply to `CEOS STAC Collection Metadata` and `CEOS STAC Granule Metadata`.