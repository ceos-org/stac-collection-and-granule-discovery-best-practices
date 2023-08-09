[Previous](1-introduction.md) | [Next](3-granule-catalogs.md)
# 2. Objectives and needs

[//]: # (similar as Service Discovery Best Practice chapter )

## Overview

The set of available STAC and STAC API specifications, the underlying OGC specifications and a growing set of related STAC and STAC API extensions can support many different use cases.  However, the multiple implementation options for a given use case may cause organizations to implement different subsets of the specifications causing interoperability issues and preventing federation of catalogs provided by different organisations.  The guidelines and recommendations presented in the current document aim to cover a number of recurrent use cases which are described below.  Not all use cases apply to all organisations, but organisations with the need to cover one of these use cases should consider the corresponding recommendations. 

## Use cases and scenarios

In the current scenario where organisations (i.e. Data Providers) implement the CEOS OpenSearch Best Practices, federation is performed by systems (i.e. Federating Entities) such as IDN, NASA CMR or FedEO. The use cases identified below aim to continue to support such federation, but through the use of STAC (JSON) instead of XML-based OpenSearch with Atom responses. 

| *User Story*  | *As a* | *I want to* | *So that I can* | 
| --------       | ------- | ------- |  ------- | 
|  UC-1   |  Data Provider  |  Publish my granule metadata records, e.g. on the cloud, organised per collection, without implementing search interfaces.  |   provide access to the metadata records to my data users.  |
|  UC-2   |  Data Provider  |  Publish my granule metadata records, organised per collection, and provide granule search interfaces (API).  |   provide access to the metadata records to my data users and offer eearch interfaces (API) they can use via scripts, curl or Notebooks.  |
|  UC-3   |  Data Provider  |  Publish my granule and collection metadata records and provide collection and granule search interfaces (API).  |   provide access to the metadata records to my data users and offer eearch interfaces (API) for collection and granule search they can use via scripts, curl or Notebooks.  |
|  UC-4   |  Data Provider  |  Publish my granule and collection metadata records and provide two-step search interfaces (API) similar to my current OpenSearch two-step-search interfaces.  |   offer my data users a two-step search capability.  |
|  UC-5   |  Data Provider  |  Publish my collection metadata records |  make them available for federation through CEOS IDN or similar federated systems (e.g. GEO) without additional effort.  |
|  UC-6   |  Data Provider  |  Publish my granule metadata records and search interfaces |  make them available for federation through CEOS IDN or GEO without additional effort.  |
|  UC-7   |  Data Provider  |  Publish collection metadata records for my analysis ready datasets |  make them available for my users as per CEOS-ARD guidelines.  |
|  UC-8   |  Data Provider  |  Publish granule metadata records for my analysis ready datasets |  make them available for my users as per CEOS-ARD guidelines.  |
|  UC-9   |  Federating entity  |  Provide federated access to collections from a data partner  |  offer my users access to collections of that data partner (including granule search capabilities/interfaces if available) without requiring additional changes/effort at the data provider side.  |
|  UC-10   |  Data Provider  |  Publish metadata records for granules available in cloud-native format e.g. on cloud storage |  make them available for my users   |
|  UC-11   |  Data Provider  |  Publish metadata records for granules with associated service offerings (e.g OGC WMS, WMTS, WCS, API-Coverages) |  make the metadata records available for my users and advertise the availability of the associated service endpoints |
