[Previous](granule-metadata.md) | [Table of contents](README.md) | [Next](federation.md)
***
# 7. Collection Metadata Best Practices

[//]: # (this is a comment)

## 7.1 Overview
This chapter presents the requirements and recommendations that apply to STAC collection metadata representations (returned by a static or searchable catalog, in isolation or included in a search response) in addition to the general metadata requirements presented in [Metadata Best Practices](best-practices.md#33-metadata-best-practices).

The requirements and recommendations provided relate to:

- Properties
- Asset and roles
- Links and relations
- Facilitating federation 

## 7.2 Properties

> **CEOS-STAC-REQ-7210 - Collection representation [Requirement]**<a name="BP-7210"></a>
>
> A(n EO) Collection metadata record shall be represented as a STAC Collection according to version v1.0.0 of the "STAC Collection Specification" [[AD02]](./introduction.md#AD02).

> **CEOS-STAC-REC-7215 - Collection metadata dates [Recommendation]**<a name="BP-7215"></a>
>
> A(n EO) Collection metadata record should encode metadata dates using the `$.created`, `$.updated` and `$.published` properties according to the "STAC Timestamps Extension Specification" [[AD20]](./introduction.md#AD20).

```json
{
    "stac_version": "1.0.0",
    "stac_extensions": [
        "https://stac-extensions.github.io/timestamps/v1.1.0/schema.json" ],
    "id": "Radarsat-2",
    "type": "Collection",
    "title": "RADARSAT-2 ESA Archive",
    "created": "2020-10-26T00:00:00.000Z",
    "updated": "2023-11-10T08:04:18Z",
    "published": "2020-11-01T00:00:00.000Z"
}
``` 

> **CEOS-STAC-REQ-7220 - Platform information [Requirement]**<a name="BP-7220"></a>
>
> A(n EO) Collection metadata record shall encode the platform name(s) as `$.summaries.platform` property and use the platform name corresponding to the [GCMD platforms](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/platforms?gtm_scheme=platforms) preferred label.


> **CEOS-STAC-REQ-7230 - Instrument information [Requirement]**<a name="BP-7230"></a>
>
> A(n EO) Collection metadata record shall encode the instrument name(s) as `$.summaries.instruments` property and use the instrument names corresponding to the [GCMD instruments](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/instruments?gtm_scheme=instruments) preferred label.


> **CEOS-STAC-REQ-7240 - Science keywords [Requirement]**<a name="BP-7240"></a>
>
> A(n EO) Collection metadata record shall encode related science keywords as `$.keywords` property and use the science keywords corresponding to the [GCMD Earth Science](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/Earth%20Science?gtm_scheme=Earth%20Science)) preferred label.


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
> The DOI of a collection, if available, shall be encoded according to the Scientific Citation Extension Specification, i.e. using the `$.sci:doi` property and a link object with rel="cite-as" [[AD13]](./introduction.md#AD13).
> 

> **CEOS-STAC-REQ-7260 - Provider names [Requirement]**<a name="BP-7260"></a>
>
A(n EO) Collection metadata record shall encode provider information as `$.providers[*]` and use the [GCMD Providers](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/providers?gtm_scheme=providers) preferred label (skos:prefLabel) as `$.providers[*].name`.

```json
  "id": "TropForest",
  "stac_extensions": [
    "https://stac-extensions.github.io/scientific/v1.0.0/schema.json",
  ],
  "providers": [
    {
      "roles": [
        "producer"
      ],
      "name": "ESA/ESRIN",
      "url": "https://esa.int"
    }
  ],
  "sci:doi": "10.5270/esa-qoe849q",
  "links": [
    {
      "rel": "cite-as",
      "href": "https://doi.org/10.5270/esa-qoe849q",
      "type": "text/html",
      "title": "Landing page"
    }
  ]
``` 

## 7.3 Assets and roles

> **CEOS-STAC-REQ-7310 - Item assets [Recommendation]**<a name="BP-7310"></a>
>
> In the case where all granules of a collection contain the same asset types, these assets should be provided in the collection encoding as `Item asset` as defined in the "STAC Item Assets Definition Extension Specification" [[AD25]](./introduction.md#AD25).
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

> **CEOS-STAC-REQ-7410 - Support for granule search [Requirement]**<a name="BP-7410"></a>
> 
> Collections supporting granule search shall contain a link with rel="items" and type="application/geo+json" in the STAC collection representation.

> **CEOS-STAC-REC-7420 - Support for granule search [Recommendation]**<a name="BP-7420"></a>
> 
> Collections supporting granule search should contain a link with rel="http://www.opengis.net/def/rel/ogc/1.0/queryables" and type="application/schema+json" in the STAC collection representation.

> **CEOS-STAC-REQ-7430 - Support for granule search [Requirement]**<a name="BP-7430"></a>
> 
> STAC Granule Catalogs shall advertise all "additional" collection specific search/filter parameters applicable for a granule search within a collection in the corresponding queryables object for that collection and not rely on a global set of queryables applicable to all collections made available via a link with rel="http://www.opengis.net/def/rel/ogc/1.0/queryables" from the landing page (typically "/collections/{collectionId}/queryables" instead of "/queryables"), to be combined with a collection-specific set (which may be empty).

> **CEOS-STAC-REQ-7440 - Support for granule search [Requirement]**<a name="BP-7440"></a>
> 
> Collections not supporting granule search shall not contain a link rel="items" and type="application/geo+json" in the STAC collection representation.

> **CEOS-STAC-REC-7450 - Reference to license [Recommendation]**<a name="BP-7450"></a>
>
> CEOS STAC collection metadata should include a Link object with rel="license" to reference an external file describing the license information for the collection, unless the `license` property has a specific [SPDX license identifier](https://spdx.org/licenses/).


## 7.5 Facilitating catalog federation

> **CEOS-STAC-REQ-7510 - Absolute links [Requirement]**<a name="BP-7510"></a>
>
> "href" attributes in links or assets shall use absolute paths and not relative paths in CEOS STAC collection metadata records.

> **CEOS-STAC-REC-7520 - Parent relation [Recommendation]**<a name="BP-7520"></a>
>
> Implementations should not use the rel="parent" relation in STAC collection encodings as the original collection may be referenced or included in a federated catalog below a different parent.
>

## 7.6 CEOS-ARD 

> **CEOS-STAC-REC-7610 - Optical ARD collections [Recommendation]**<a name="BP-7610"></a>
>
> CEOS STAC collection metadata for optical ARD collections should include Collection Summaries as defined by the [CEOS-ARD STAC Extension for Optical data](https://github.com/stac-extensions/ceos-ard/blob/main/optical.md#stac-collections) [[AD27]](./introduction.md#AD28).

> **CEOS-STAC-REC-7620 - Radar ARD collections [Recommendation]**<a name="BP-7620"></a>
>
> CEOS STAC collection metadata for radar ARD collections should include Collection Summaries as defined by the [CEOS-ARD STAC Extension for Radar data](https://github.com/stac-extensions/ceos-ard/blob/main/radar.md#stac-collections) [[AD27]](./introduction.md#AD28).



[Previous](granule-metadata.md) | [Table of contents](README.md) | [Next](federation.md)
