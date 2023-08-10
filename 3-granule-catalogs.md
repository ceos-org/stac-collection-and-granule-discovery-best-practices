[Previous](2-objectives-needs.md) | [Next](4-collection-catalogs.md)
# 3. Granule Catalog Best Practices

[//]: # (this is a comment)

## 3.1 Overview


| :question: | How much information do we want to provide in the document.  Not say anything about things which are explicit in the specifications (which ones?).  Or we repeat certain info for clarity ? |
|---------------|:------------------------|


| :question: | syntax/structure of Best Practice identifiers is to be agreed. Current identifiers are preliminary.  Obligation (requirement, recommendation) of each best practice is to be agreed as well.  Current levels are "copy/paste" and not representative.  |
|---------------|:------------------------|

Explain main alternatives :
- static catalog (landing page, ..)
- catalog with search interface

## 3.2 Static catalog without search interface

## 3.3 Catalog with search interface

### Granule search request

#### Endpoints
- endpoint(s): /search and/or /items ?
- GET and/or POST


| :question: | Do we want to request the existence of 2 different endpoints for search, i.e. at /search and at /items even though just 1 is enough (partial compliance) ? For federation, it would be more scalable to ask for each collection to support search at rel="items". |
|---------------|:------------------------|


| :memo:        | Take note of this       |
|---------------|:------------------------|


| :information_source: | Take note of this       |
|---------------|:------------------------|


| :warning:        | Take note of this       |
|---------------|:------------------------|

> **CEOS-STAC-BP-002-3 - Granule search endpoints [Recommended]**<a name="BP-002-3"></a>
>
> CEOS implementations should advertise an endpoint for granule search which is valid for all the collections in the STAC Catalog (typically the Landing Page) with rel="search" and type="application/geo+json". 


> **CEOS-STAC-BP-002-4 - Granule search endpoints [Recommended]**<a name="BP-002-4"></a>
>
> CEOS implementations should advertise an endpoint for granule search which is valid for a single collection in the STAC Collection representation as a Link object rel="items" and type="application/geo+json".

#### Search parameters



#### Advertising additional search parameters

- filter + CQL (optional)

#### Other

- Asset-level search capability (STFC)

### Granule search response

- result navigation ?

> **CEOS-STAC-BP-10-2 - Item search response representation [Requirement]**<a name="BP-010-2"></a>
>
> An Item search response shall be represented as a GeoJSON FeatureCollection according to version v1.0.0 of the ["STAC API ItemCollection Specification"](https://github.com/radiantearth/stac-api-spec/blob/master/fragments/itemcollection/README.md).

> **CEOS-STAC-BP-011B-2 - Result set navigation granules [Requirement]**<a name="BP-011B-2"></a>
>
> The $.features\[\].links array in an item search response shall include Link objects for navigating the search result set when the result set is too large to fit a single response using hyperlinks rel='self', rel='next', rel='prev', rel='first', rel='last' and type=`application/geo+json`. 


| **Use case**   | **first** |  **prev** |  **self** | **next** | **last** |
| --------   | --------- | --------- | --------- | --------- | --------- |
| First page | Optional |  Not allowed |  Mandatory  | Mandatory  |  Optional |
| Middle pages | Optional |  Optional | Mandatory  | Mandatory  | Optional  |
| Last page | Optional |  Optional | Mandatory  |  Not allowed  | Optional  |
| Empty result set | Not allowed  |  Not allowed |  Mandatory  | Not allowed  |  Not allowed |
| Single page | Optional |  Not allowed |  Mandatory  | Not allowed  |  Optional |

### TBD

- simplifications ?  /conformance, /api not required (even though mandatory) as not-used by clients - redundant ?
