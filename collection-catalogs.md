[Previous](granule-catalogs.md) | [Table of contents](README.md) | [Next](granule-metadata.md)
***
# 5. Collection Catalog Best Practices

[//]: # (this is a comment)

## 5.1 Overview

Explain main alternatives :
- static collection catalog (landing page, rel="child", rel="data", ..)
- collection catalog with search interface

The requirements in the current chapter only apply when TBD.

## 5.2 Collection catalog without search interface

EO collections represented as STAC collections can be made available as a STAC Catalog in different ways as depicted below:
- Through a hierarchy of catalogs or collections with the rel="child" relation.
- As a list of collections available via the rel="data" relation.

| ![Hierarchy of catalogs and collections](./figures/objects-collection-catalog-child.png "Nested catalogs and collections") |
|:--:| 
| *Method 1: Using rel="child"* |

| ![List of collectio](./figures/objects-collection-catalog-data.png "List of collections") |
|:--:| 
| *Method 2: Using rel="data"* |

Implementations may combine both mechanisms and allow the same EO collection to be found via the collection hierarchy or the collection list.
Implementations intending to support collection search are to support at least Method 2 and the corresponding endpoint.

> **CEOS-STAC-REQ-5210 - Collection access [Requirement]**<a name="BP-5210"></a>
>
> A CEOS STAC catalog shall support access to collection metadata from the catalog landing page using the rel="child" or rel="data" approach depicted above or both approaches combined.

Note: When publishing a single collection, the collection and the landing page may be combined in a single JSON file.

## 5.3 Collection catalog with search interface



> **CEOS-STAC-REQ-5320 - Collections endpoint [Requirement]**<a name="BP-5320"></a>
>
> A CEOS STAC catalog supporting collection search shall advertise the search endpoint for collections in the landing page with rel="data" (most often `/collections`), type="application/json" and declare the corresponding collection search conformance classes in the landing page.  See "STAC API Collection Search" [[AD07]](./introduction.md#AD07).

The above endpoint is further referred to as the `collections endpoint`. 

Conformance encoding example

```json
"conformsTo": [

    "http://www.opengis.net/spec/ogcapi_common-2/1.0/conf/collections",
    "http://www.opengis.net/spec/ogcapi-common-2/1.0/conf/simple-query",
    "http://www.opengis.net/spec/ogcapi-records-1/1.0/req/cql-filter",
    "https://api.stacspec.org/v1.0.0-rc.2/collection-search",
    "https://api.stacspec.org/v1.0.0-rc.2/collection-search#filter",
    "https://api.stacspec.org/v1.0.0-rc.1/collection-search#free-text",
    "http://www.opengis.net/spec/cql2/1.0/conf/cql2-text",
    "http://www.opengis.net/spec/cql2/1.0/conf/basic-cql2"
  ]
```

  

### 5.3.1 Collection search request

> **CEOS-STAC-REQ-5330 - Collection search method [Requirement]**<a name="BP-5330"></a>
>
> A CEOS STAC collection catalog shall support collection searches at the `collections endpoint` (rel="data") using the HTTP `GET` method.

`/collections` is typically used for the above endpoint, but this is not required.

:question: Make '/collections' a recommendation?

#### Search parameters

> **CEOS-STAC-REQ-5340 - Supported search parameters [Requirement]**<a name="BP-5340"></a>
>
> The STAC-API and OGC API-Features specifications define a list of fundamental search parameters.  From these specifications, a CEOS STAC collection catalog shall support the following minimum set of search parameters for “collection” search at the collections endpoint:
- `limit`  
- `bbox` 
- `datetime`


> **CEOS-STAC-REC-5360 - Free text search [Requirement]**<a name="BP-5360"></a>
>
> For supporting free text searches, a CEOS STAC collection catalog shall advertise support for the HTTP query parameter `q` as in "STAC API Collection Search" [[AD07]](./introduction.md#AD07).


> **CEOS-STAC-REQ-5370 - Collection queryables [Requirement]**<a name="BP-5370"></a>
>
> A CEOS STAC collection catalog supporting additional queryables for collection search shall return the link to the Queryables object with the list of queryables that can be used in a filter expression via a link object in the collection search response with rel="http://www.opengis.net/def/rel/ogc/1.0/queryables" and type="application/schema+json" (See also "STAC API Collection Search" [[AD07]](./introduction.md#AD07).


### 5.3.2 Collection search response

- optional list of collection search parameters (rel="http://www.opengis.net/def/rel/ogc/1.0/queryables", type="application/schema+json"
- search by 'id'  (at /collections), which 'ids' can be used for searching ?  'id' from hierarchy ?
- content negotiation (alternative formats)


> **CEOS-STAC-REQ-5372 - Collection search response representation [Requirement]**<a name="BP-5372"></a>
>
> A collection search response shall be represented as a JSON object according to the "STAC API - Collection Search" [[AD07]](./introduction.md#AD07).


> **CEOS-STAC-REQ-5373 - Allow for collection search-by-id [Requirement]**<a name="BP-5373"></a>
>
> The $.collections[].id property in a collection search response shall allow to navigate to a single collection using the `id` as a path parameter appended to the collection search endpoint (rel='data') e.g. /collections/{id}. 

Search-by-id makes the following use cases possible:

* The ability to provide a link pointing to a single catalog item (using a URL) on a web page that illustrates a particular event (e.g. an earthquake in the Himalayas).
* The ability to bookmark and retrieve a single item.


> **CEOS-STAC-REQ-5374 - Collection search response representation [Requirement]**<a name="BP-5374"></a>
>
> Collections included in a collection search response shall be represented according to the ["CEOS STAC Collection Metadata Best Practices"](collection-metadata.md).



### 5.3.3 Two-step search

Traditionally, we have partitioned data into hierarchies for organizational purposes. The notion of datasets and files or collections and granules allows us to group similar assets to ease the archival and curation of data.

This hierarchy can also be leveraged for discovery purposes. A general use case for discovery is to find a measurement (sea surface temperature, NDVI etc.) associated with a spatial and temporal area of interest. Querying a large archive in such a manner would potentially yield a large number of results with a low precision. This is because the measurement clause of our query can often yield low precision results. 

Generally, these query parameters map successfully to explicit parts of our data's organizational hierarchy. Measurements are generally defined at the collection level and spatial and temporal extents at the granule level.

Furthermore, measurement query precision is low while spatial-temporal querying of files is high.

Example: A sea surface temperature query yields 100 possible collections and each one of those had 500 granules in the area of interest we have 50K results to assess. If only 10 of those collections had the correct form of sea surface temperature then we have 40K invalid results that need to be checked.

If we break up the search into a collection search then a granule search then we have as follows,

A sea surface temperature query yields 100 possible collections. Only 10 of those results are correct so only 90 invalid results nee to be checked. Then a granule search is performed for each of the 10 correct collections. Since spatio-temporal searching of files yields high precision the confidence in those results is also high.

This is why many earth science search engines offer a two-step search mechanism. It decreases the risk of low precision results.

For search federation we exploit the two-step mechanism in another way. Collection searches are resolved at a centralized repository that contains the collection-level metadata of all participating agencies and organizations. The results of such searches embed file-level search endpoints at the agency/organization responsible for the data of that collection.

The collection search occurs at the centralized repository and the granule searches occur at the federated repositories.

> **CEOS-STAC-REC-5380 - Support for two step search [Recommendation]**<a name="BP-5380"></a>
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


> **CEOS-STAC-REQ-5390 - Support for two step search [Requirement]**<a name="BP-5390"></a>
> 
> Collections supporting two-step search shall contain a link with rel="items" in the STAC collection representation returned by the collection search.


> **CEOS-STAC-REC-5392 - Support for two step search [Recommendation]**<a name="BP-5392"></a>
> 
> Collections supporting two-step search shall contain a link with rel="http://www.opengis.net/def/rel/ogc/1.0/queryables" and type="application/schema+json" in the STAC collection representation returned by the collection search.


> **CEOS-STAC-REQ-5393 - Support for two step search [Requirement]**<a name="BP-5393"></a>
> 
> STAC Granule Catalogs shall advertise all "additional" collection specific search/filter parameters applicable for a granule search within a collection in the corresponding queryables object for that collection and not rely on a global set of queryables applicable to all collections made available via a link with rel="http://www.opengis.net/def/rel/ogc/1.0/queryables" from the landing page (typically "/collections/{collectionId}/queryables" instead of "/queryables"), to be combined with a collection-specific set (which may be empty).


> **CEOS-STAC-REQ-5395 - Support for two step search [Requirement]**<a name="BP-5395"></a>
> 
> Collections not supporting two-step search shall not contain a link rel="items" in the STAC collection representation returned by the collection search.
***
[Previous](granule-catalogs.md) | [Table of contents](README.md) | [Next](granule-metadata.md)
