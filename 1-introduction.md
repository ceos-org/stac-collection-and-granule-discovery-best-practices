[Next](2-objectives-needs.md)
# 1. Introduction

## 1.1 Purpose of document

The STAC ecosystem comprises both API-related and metadata-related specifications.
This document provides server implementation Best Practices for STAC-based metadata publication and related discovery services allowing for standardized and harmonized access to metadata and data for CEOS agencies.

TBD.


## 1.2 Document overview

The document is organized as follows:

- Chapter 1 is the introduction of the document.
- Chapter 2 gives an overview of objectives and needs.
- Chapter 3 ...
- Chapter 4 ...


## 1.3 Terms, definitions and abbreviated terms

### 1.3.1 Terms and Definitions 

|  |   |  
| -------- | --------- | 
| `Granule` | A granule is the finest granularity of data that can be independently managed. A granule usually matches the individual file of EO satellite data.  | 
| `Collection` | A collection is an aggregation of granules sharing the same product specification. A collection typically corresponds to the series of products derived from data acquired by a sensor on board a satellite and having the same mode of operation.  | 
| `Interface` | Named set of operations that characterize the 16ehavior of an entity.  | 
| `Metadata` | Information about a resource [[RD02]](#RD02).  | 
| `Metadata element` | Discrete unit of metadata [[RD02]](#RD02).  | 


### 1.3.2 Acronyms

|  |   |  
| -------- | --------- | 
| `API` | Application Programming Interface |
| `CEOS` | Committee on Earth Observation Satellites   |  
| `DIF-10` | Directory Interchange Format Version 10   |  
| `GCMD` | Global Change Master Directory   |  
| `HATEOAS` | Hypertext As The Engine Of Application State  |
| `IDN` |  International Directory Network  | 
| `JSON` | JavaScript Object Notation  | 
| `OGC` | Open Geospatial Consortium  | 
| `OSDD` | OpenSearch Description Document  |
| `STAC` | Spatiotemporal Asset Catalog  |
| `WGISS` | Working Group on Information Systems and Services  | 

## 1.4 References

### 1.4.1 Applicable documents


| **ID**  | **Title** | 
| -------- | --------- | 
| `AD01` <a name="AD01"></a> | [STAC Catalog Specification](https://github.com/radiantearth/stac-spec/blob/master/catalog-spec/catalog-spec.md) | 
| `AD02` <a name="AD02"></a> | [STAC Collection Specification](https://github.com/radiantearth/stac-spec/blob/master/collection-spec/collection-spec.md) | 
| `AD03` <a name="AD03"></a> | [STAC Item Specification](https://github.com/radiantearth/stac-spec/tree/master/item-spec)   | 
| `AD04` <a name="AD04"></a>| [STAC API Specification](https://github.com/radiantearth/stac-api-spec)  | 
| `AD05` <a name="AD05"></a> | [STAC API - Item Search](https://github.com/radiantearth/stac-api-spec/tree/main/item-search) |
| `AD06` <a name="AD06"></a> | [STAC API - Filter Extension](https://github.com/stac-api-extensions/filter) |
| `AD07` <a name="AD07"></a>| [STAC API - Collection Search](https://github.com/stac-api-extensions/collection-search) |
| `AD08` <a name="AD08"></a> | [OGC17-069r3, OGC API - Features - Part 1: Core](https://docs.opengeospatial.org/is/17-069r3/17-069r3.html) | 
| `AD09` <a name="AD09"></a> | [OGC17-079r1, OGC API - Features - Part 3: Filtering](https://docs.opengeospatial.org/DRAFTS/19-079r1.html)  | 
| `AD10` <a name="AD10"></a> | [OGC21-065, Common Query Language (CQL2)](https://docs.ogc.org/DRAFTS/21-065.html)  | 
| `AD11` <a name="AD11"></a> | [RFC 7946 - The GeoJSON Format](https://datatracker.ietf.org/doc/html/rfc7946) | 
| `AD12` <a name="AD12"></a>| [JSON Schema: A Media Type for Describing JSON Documents, draft-handrews-json-schema-02](https://datatracker.ietf.org/doc/html/draft-handrews-json-schema-02) |

### 1.4.2 Reference documents

| **ID**  | **Title** | 
| -------- | --------- | 
| `RD01` <a name="RD01"></a> | [CEOS OpenSearch Best Practice Document, Version 1.0, CEOS-OPENSEARCH-BP-V1.3](https://ceos.org/document_management/Working_Groups/WGISS/Documents/WGISS%20Best%20Practices/CEOS%20OpenSearch%20Best%20Practice.pdf)  |
| `RD02` <a name="RD02"></a> | [ISO 19115-1:2014, Geographic Information – Metadata – Part 1: Fundamentals, First Edition 2014-04-01](https://www.iso.org/standard/53798.html)  |


