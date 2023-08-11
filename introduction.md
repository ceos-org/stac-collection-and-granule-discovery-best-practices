[Previous](README.md) | [Next](objectives-needs.md)
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


There are three different levels of obligation for the Best Practices presented in the current document:
- “Requirements” are mandatory and must be implemented,
- “Recommendations” are optional, but strongly recommended for interoperability,
- “Optional” indicates an additional good practice.

In addition, "Permissions" indicate allowed deviations from one of more of the underlying specifications in cases where a subset of the original requirements is deemed sufficient in the context of CEOS.

## 1.3 Terms, definitions and abbreviated terms

### 1.3.1 Terms and Definitions 

|  |   |  
| -------- | --------- | 
| `Analysis Ready Data` | Satellite data that have been processed to a minimum set of requirements and organized into a form that allows immediate analysis with a minimum of additional user effort and interoperability both through time and with other datasets. |
| `Granule` | A granule is the finest granularity of data that can be independently managed. A granule usually matches the individual file of EO satellite data.  | 
| `Collection` | A collection is an aggregation of granules sharing the same product specification. A collection typically corresponds to the series of products derived from data acquired by a sensor on board a satellite and having the same mode of operation.  | 
| `Interface` | Named set of operations that characterize the behavior of an entity.  | 
| `Metadata` | Information about a resource [[RD02]](#RD02).  | 
| `Metadata element` | Discrete unit of metadata [[RD02]](#RD02).  | 


### 1.3.2 Acronyms

|  |   |  
| -------- | --------- | 
| `API` | Application Programming Interface |
| `ARD` | Analysis Ready Data |
| `CEOS` | Committee on Earth Observation Satellites   |  
| `CQL` | Common Query Language   |  
| `DIF-10` | Directory Interchange Format Version 10   |  
| `EO` | Earth Observation   |  
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
| `AD13` <a name="AD13"></a>| [STAC Scientific Citation Extension Specification, v1.0.0](https://github.com/stac-extensions/scientific) |
| `AD14` <a name="AD14"></a>| [STAC Electro-Optical Extension Specification, v1.1.0](https://github.com/stac-extensions/eo) |
| `AD15` <a name="AD15"></a>| [STAC SAR Extension Specification, v1.0.0](https://github.com/stac-extensions/sar) |
| `AD16` <a name="AD16"></a>| [STAC Satellite Extension Specification, v1.0.0](https://github.com/stac-extensions/sat) |
| `AD17` <a name="AD17"></a>| [STAC Versioning Indicators Extension Specification, v1.2.0](https://github.com/stac-extensions/version) |
| `AD18` <a name="AD18"></a>| [STAC View Geometry Extension Specification, v1.0.0](https://github.com/stac-extensions/view) |
| `AD19` <a name="AD19"></a>| [STAC Projection Extension Specification, v1.0.0](https://github.com/stac-extensions/projectionw) |
| `AD20` <a name="AD20"></a>| [STAC Timestamps Extension Specification, v1.0.0](https://github.com/stac-extensions/timestamps) |
| `AD21` <a name="AD21"></a>| [STAC Processing Extension Specification, v1.1.0](https://github.com/stac-extensions/processing) |
| `AD22` <a name="AD22"></a>| [STAC Hyperspectral Imagery Extension Specification, draft](https://github.com/stac-extensions/hsi) |
| `AD23` <a name="AD23"></a>| [STAC Landsat Extension Specification, v1.1.1](https://landsat.usgs.gov/stac/landsat-extension/v1.1.1/schema.json) |





### 1.4.2 Reference documents

| **ID**  | **Title** | 
| -------- | --------- | 
| `RD01` <a name="RD01"></a> | [CEOS OpenSearch Best Practice Document, Version 1.0, CEOS-OPENSEARCH-BP-V1.3](https://ceos.org/document_management/Working_Groups/WGISS/Documents/WGISS%20Best%20Practices/CEOS%20OpenSearch%20Best%20Practice.pdf)  |
| `RD02` <a name="RD02"></a> | [ISO 19115-1:2014, Geographic Information – Metadata – Part 1: Fundamentals, First Edition 2014-04-01](https://www.iso.org/standard/53798.html)  |
| `RD03` <a name="RD03"></a> | [OGC23-038, Best Practice for Common Band Names of Optical and Radar Sensors](https://portal.ogc.org/files/?artifact_id=104980&version=1) - Expected but no draft available.  |
| `RD04` <a name="RD04"></a> | [OGC13-026r9, OpenSearch Extension for Earth Observation](https://docs.ogc.org/is/13-026r9/13-026r9.html) |





