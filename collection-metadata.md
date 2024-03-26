[Previous](granule-metadata.md) | [Table of contents](README.md) | [Next](federation.md)
***
# 7. Collection Metadata Best Practices

[//]: # (this is a comment)

## 7.1 Overview
Explain main parts

## 7.2 Properties

- ...
- summaries  (platform, instrument, science keywords, GCMD)
- organisation objects with names/URL from GCMD ?


> **CEOS-STAC-REQ-7210 - Collection representation [Requirement]**<a name="BP-7210"></a>
>
> A(n EO) Collection metadata record shall be represented as a STAC Collection according to version v1.0.0 of the "STAC Collection Specification" [[AD02]](./1-introduction.md#AD02).


> **CEOS-STAC-REQ-7220 - Platform information [Requirement]**<a name="BP-7220"></a>
>
> A(n EO) Collection metadata record shall encode the platform name(s) as $..summaries.platform property and use the platform name corresponding to the [GCMD platforms](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/platforms?gtm_scheme=platforms) preferred label.


> **CEOS-STAC-REQ-7230 - Instrument information [Requirement]**<a name="BP-7230"></a>
>
> A(n EO) Collection metadata record shall encode the instrument name(s) as $..summaries.instruments property and use the instrument names corresponding to the [GCMD instruments](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/instruments?gtm_scheme=instruments) preferred label.


> **CEOS-STAC-REQ-7240 - Science keywords [Requirement]**<a name="BP-7240"></a>
>
> A(n EO) Collection metadata record shall encode related science keywords as $.keywords property and use the science keywords corresponding to the [GCMD Earth Science](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/Earth%20Science?gtm_scheme=Earth%20Science)) preferred label.


```json
"keywords": [
    "EARTH SCIENCE>AGRICULTURE",
    "EARTH SCIENCE>BIOSPHERE>ECOSYSTEMS>TERRESTRIAL ECOSYSTEMS>FORESTS",
    "EARTH SCIENCE>LAND SURFACE",
    "EARTH SCIENCE>BIOSPHERE>VEGETATION" ],

"summaries": {
    "instruments": [
      "AVNIR-2",
      "SLIM6",
      "MSC"
    ],
    "platform": [
      "ALOS-1",
      "GEOSAT-1",
      "KOMPSAT-2"
    ]
  }
``` 


> **CEOS-STAC-REQ-7250 - DOI [Requirement]**<a name="BP-7250"></a>
>
> The DOI of a collection, if available, shall be encoded according to the Scientific Citation Extension Specification, i.e. using the `sci:doi` property and a link object with rel="cite-as" [[AD13]](./1-introduction.md#AD13).
> 

> **CEOS-STAC-REQ-7260 - Provider names [Requirement]**<a name="BP-7260"></a>
>
A(n EO) Collection metadata record shall encode provider information as `$.providers[*]` and use the [GCMD Providers](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/providers?gtm_scheme=providers) preferred label (skos:prefLabel) as $.providers[*].name.

```json
  "providers": [
    {
      "roles": [
        "producer"
      ],
      "name": "ESA/ESRIN",
      "url": "https://esa.int"
    }
  ]
``` 

TBD: recommendation to add additional contact information with https://github.com/stac-extensions/contacts ?



## 7.3 Assets and roles

- what names (roles, media types) should be used for ...

> **CEOS-STAC-REQ-7310 - Item assets [Requirement]**<a name="BP-7310"></a>
>
> In the case where all granules of a collection contain the same asset types, these assets should be provided in the collection encoding as `Item asset` as defined in the "STAC Item Assets Definition Extension Specification" [[AD25]](./1-introduction.md#AD25).
> 

The example below indicates that all granules of this collection do have assets, representing a thumbnail of type PNG, a download location as .zip file and are also available as zarr, with an alternative download location on S3 object storage.  Note that the keys used for the assets (e.g. "thumbnail", "enclosure", "data") are meaningless and can have any value.

```json
"item-assets": {
    "thumbnail": {
      "roles": [
        "thumbnail"
      ],
      "type": "image/png",
      "title": "THUMBNAIL"
    },
    "enclosure": {
      "roles": [
        "data"
      ],
      "type": "application/zip",
      "title": "Download"
    },
    "data": {
      "title": "Zarr consolidated metadata",
      "type": "application/json"
      "roles": [
        "data",
        "metadata",
        "zarr-consolidated-metadata"
      ],
      "alternate": {
        "s3": {
          "title": "S3 Access"
        }
      }
    }
}
```



## 7.4 Links and relations

- how to encode "offerings" (i.e. links to OGC or other service endpoints in a STAC collection) ?

> **CEOS-STAC-REC-7410 - Reference to license [Recommendation]**<a name="BP-7410"></a>
>
> CEOS STAC collection metadata should include a Link object with rel="license" to reference an external file describing the license information for the collection, unless the `license` property has a specific [SPDX license identifier](https://spdx.org/licenses/).


TBD: templated links: https://github.com/opengeospatial/ogcapi-common/issues/187


## 7.5 Facilitating catalog federation


## 7.6 CEOS-ARD 

- TBD
***
[Previous](granule-metadata.md) | [Table of contents](README.md) | [Next](federation.md)