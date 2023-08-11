[Previous](granule-catalogs.md) | [Next](granule-metadata.md)
# 4. Collection Catalog Best Practices

[//]: # (this is a comment)
The requirements in the current chapter only apply 

## 4.1 Overview

Explain main alternatives :
- static collection catalog (landing page, rel="child", rel="data", ..)
- collection catalog with search interface

  

## 4.2 Collection catalog without search interface

EO collections represented as STAC collections can be made available as a STAC Catalog in different ways as depicted below:
- Through a hierarchy of catalogs or collections with the rel="child" relation.
- As a list of collections available via the rel="data" relation.

| ![Hierarchy of catalogs and collections](./figures/objects-collection-catalog-child.png "Nested catalogs and collections") |
|:--:| 
| *Hierarchy of catalogs and collections* |

| ![List of collectio](./figures/objects-collection-catalog-data.png "List of collections") |
|:--:| 
| *List of collections* |


#### Endpoint

> **CEOS-STAC-BP-002-1 - Collections endpoint [Requirement]**<a name="BP-002-1"></a>
>
> CEOS implementations shall advertise an endpoint for getting/listing available collections in the landing page rel="data", type="application/json".

The above endpoint is further referred to as the `collections endpoint`. 
Applies when granule searches are supported.

## 4.3 Collection catalog with search interface

> **CEOS-STAC-BP-TBD - API Feature paths [Permission]**<a name="BP-TBD"></a>
>
> A CEOS STAC server implementation is allowed to not use fixed paths to navigate from resource to resource, but shall support discovering the actual path via the proper relation (rel="xyz") in the corresponding resource's representation.

For example, the rel="items" path for a collection is not necessarily the path towards the collection with "/items" appended but may be on a different server.

> **CEOS-STAC-BP-TBD - API Feature relations [Permission]**<a name="BP-TBD"></a>
>
> A CEOS STAC server implementation is not required to:
  - Support the /api path or provide an OpenAPI description of its interface
  - Support the rel="service-desc" from its landing page (root catalog)
  - Support the /conformance path
  - Support the rel="conformance" from its landing page (root catalog)

TBD: explain the "collections endpoint" may be a "search endpoint" if proper conformance classes are declared in landing page.

### 4.3.1 Collection search request

> **CEOS-STAC-BP-TBD - Collection search method [Requirement]**<a name="BP-TBD"></a>
>
> A STAC server shall support collection searches using the HTTP `GET` method.

#### Search parameters

> **CEOS-STAC-BP-005 - Supported search parameters [Requirement]**<a name="BP-005"></a>
>
> The STAC-API and OGC API-Features specifications define a list of fundamental search parameters.  From these specifications, a CEOS STAC implementation shall support the following
minimum set of search parameters for “collection” search at the collection endpoint:
- `limit`  
- `ids`
- `bbox` 
- `datetime`

> **CEOS-STAC-BP-TBD - Intersects search parameter [Permission]**<a name="BP-TBD"></a>
>
> A STAC server implementation may choose to not support the following search parameters for “collection” search at the collection endpoint:
- `intersects`

##### Free Text Keyword

> **CEOS-STAC-BP-003 - Free text search [Recommended]**<a name="BP-003"></a>
>
> For supporting free text searches, the server shall advertise support for the HTTP query parameter `q` as in "STAC API Collection Search" [[AD07]](./introduction.md#AD07).

#### Advertising additional search parameters

- rel="queryables", JSON Schema (optional)
- CQL (optional)

### 4.3.2 Collection search response

- result set navigation
- optional list of collection search parameters (rel="http://www.opengis.net/def/rel/ogc/1.0/queryables", type="application/schema+json"

#### TBD

### 4.3.3 Two-step search

One serious hurdl"e to overcome in searching for data is the great number of data items to account
for in responses, as well as the expected number of successful “hits” for a query. In ordinary web
searches, the searcher is usually looking for a small number of web pages or documents.
Relevance ranking typically does a good job of presenting these successful hits near the top of
the returned list, followed by single point-and-click retrievals. However, when searching for Earth
science data covering large time periods or spatial areas, a user will often specify a set of
constraints to find an appropriate data collection together with space-time criteria for files within
that data collection. Often, the precision of the data collections returned for the search is low, with
many spurious hits. However, the space-time precision of the files is often quite high: that is, the
user truly wants to use all the data files of a desirable data collection set that fall within the spacetime region of interest. Thus, searching for all data satisfying both dataset content and space-time
region at the same time can produce a great many spurious hits, i.e., all the files for data
collections that are not desired.

> **CEOS-STAC-BP-001 - Support of two step search [Recommended]**<a name="BP-001"></a>
> 
> Support for a two-step search consisting of a collection level search followed by a corresponding granule level search is recommended.

The two-step search consists of a collection level search and the subsequent granule level search
(or file-level search).

| ![Two step search](./figures/two-step.png "Two step search") |
|:--:| 
| *Two Step Search* |

In order to provide a well-defined search path from a collection of interest to granules associated
with that collection, we advocate the use of two-step searching leveraging the following:

1. Link elements of relation items (rel=’items’) within collection entries. These links point
to a granule-level endpoint specific to the collection entry.
1. Link elements of relation queryables (rel=’queryables’) within collection entries. These links point
to available granule-level search parameters specific to the collection entry.
2. Granule level interface descriptions (i.e. endpoints and sets of search parameters) that can be tailored to a specific collection.

The advantages of this approach are as follows:

- A client can navigate from collection to granule with only an understanding of the STAC specification.
- A server links between collections and granules exploiting the relation between a STAC Collection and a STAC Item.
- It allows the client to determine what search parameters are available to the user at the
granule level using the /queryables response.




| ❓ | To be clarified what assumptions a STAC client is allowed to make regarding available (granule) search parameters.  Are STAC item-search parameters always all available at /search and /items endpoints, or only at the /search endpoint ?      |
|---------------|:------------------------|



| ❓ | What STAC collection ìdentifiers can be used to perform searches at the /search endpoint ?  All the ones available at the rel=`data` path, all the ones in the hierachical structure starting from the landing page following the rel=`child` links ? ?       |
|---------------|:------------------------|


| ❓ | What is the relation between the collections appearing in the hierarchy rel=`child` and the response from the /collections (rel=`data`) endpoint ?  One is a subset of the other or both can be unrelated ?   /collections to return a flat list ?  and how is it "filtered" when a query is applied ?  Flat list of all matches ?       |
|---------------|:------------------------|

