[Previous](best-practices.md) | [Next](collection-catalogs.md)
# 4 Granule Catalog Best Practices

[//]: # (this is a comment)

## 4.1 Overview


Explain main alternatives :
- static catalog (landing page, ..)
- catalog with search interface

## 4.2 Static catalog without search interface

- rel="item"

EO granules represented as STAC items can be made available as:
- individual STAC items referenced from a STAC collection
- the result of a search interface

| ![Static catalog](./figures/objects-granule-catalog-item.png "Nested catalogs and collections") |
|:--:| 
| *Method 1: Using rel="item"* |

| ![Search result](./figures/objects-granule-catalog-items.png "List of collections") |
|:--:| 
| *Method 2: Via a search interface* |


## 4.3 Catalog with search interface

### 4.3.1 Granule search request

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



> **CEOS-STAC-REQ-410 - Granule search endpoints [Requirement]**<a name="BP-410"></a>
>
> CEOS STAC granule catalogs shall advertise and provide the endpoints for granule search per individual collection in the STAC Collection representation as a Link object with rel="items" and type="application/geo+json".

> **CEOS-STAC-PER-420 - Cross-collection granule search endpoint [Permission]**<a name="BP-420"></a>
>
> CEOS STAC granule catalogs may or may not advertise and provide a cross-collection endpoint for granule search, valid for all the collections in the STAC Catalog (typically the Landing Page) with rel="search" and type="application/geo+json" and may instead only provide individual granule search endpoints per collection via rel="items" in the collection representation. 

The above permission avoids the implementation of multiple endpoints for granule search as a single implementation is sufficient.  CEOS STAC catalog clients should thus not assume the existence of the cross-collection granule search endpoint.

> **CEOS-STAC-REQ-430 - Cross-collection granule search method [Requirement]**<a name="BP-430"></a>
>
> CEOS STAC granule catalogs with cross-collection granule search endpoint shall support searches at the `endpoint` (rel="search") using the HTTP `GET` method.

Support of the `POST` method at the ross-collection granule search endpoint (if available) is not required.


#### Search parameters


> **CEOS-STAC-REQ-440 - Supported granule search parameters [Requirement]**<a name="BP-440"></a>
>
> The STAC-API and OGC API-Features specifications define a list of fundamental search parameters.  From these specifications, a CEOS STAC granule catalog shall support the following minimum set of search parameters for “granule” search at the rel="items" endpoint:
- `limit`  
- `bbox` 
- `datetime`


#### Advertising additional search parameters

> **CEOS-STAC-REQ-450 - Additional granule search queryables [Requirement]**<a name="BP-450"></a>
>
> A CEOS STAC granule catalog supporting additional queryables for a collection shall return the link to the Queryables object with the list of queryables that can be used in a filter expression for that collection via a link object in the collection representation (metadata) with rel="http://www.opengis.net/def/rel/ogc/1.0/queryables" and type="application/schema+json" (typically, but not necessarily, at '/collections/{collectionId}/queryables').


#### Other

- Asset-level search capability (STFC)

### 4.3.2 Granule search response


> **CEOS-STAC-REQ-460 - Item search response representation [Requirement]**<a name="BP-460"></a>
>
> An Item search response shall be represented as a GeoJSON FeatureCollection according to version v1.0.0 of the ["STAC API ItemCollection Specification"](https://github.com/radiantearth/stac-api-spec/blob/master/fragments/itemcollection/README.md).





