[Previous](5-granule-metadata.md) 
# 6. Collection Metadata Best Practices

[//]: # (this is a comment)

## 6.1 Overview
Explain main parts

## 6.2 Properties

- ...
- summaries  (platform, instrument, science keywords, GCMD)
- organisation objects with names/URL from GCMD ?


> **CEOS-STAC-BP-XXX - Collection representation [Requirement]**<a name="BP-TBD"></a>
>
> A(n EO) Collection metadata record shall be represented as a STAC Collection according to version v1.0.0 of the "STAC Collection Specification" [[AD02]](./1-introduction.md#AD02).


> **CEOS-STAC-BP-XXX - Platform information [Requirement]**<a name="BP-TBD"></a>
>
> A(n EO) Collection metadata record shall encode the platform name(s) as $..summaries.platform property and use the platform name corresponding to the [GCMD platform](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/platforms?gtm_scheme=platforms) preferred label.

> **CEOS-STAC-BP-XXX - Instrument information [Requirement]**<a name="BP-TBD"></a>
>
> A(n EO) Collection metadata record shall encode the instrument name(s) as $..summaries.instruments property and use the instrument names corresponding to the [GCMD instrument](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/instruments?gtm_scheme=instruments) preferred label.

> **CEOS-STAC-BP-XXX - Science keywords [Requirement]**<a name="BP-TBD"></a>
>
> A(n EO) Collection metadata record shall encode related science keywords as $.keywords property and use the science keywords corresponding to the [GCMD Earth Science](https://gcmd.earthdata.nasa.gov/KeywordViewer/scheme/Earth%20Science?gtm_scheme=Earth%20Science)) preferred label.


```
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


> **CEOS-STAC-BP-XXX - DOI [Requirement]**<a name="BP-TBD"></a>
>
> The DOI of a collection, if available, shall be encoded according to the Scientific Citation Extension Specification, i.e. using the `sci:doi` property and a link object with rel="cite-as" [[AD13]](./1-introduction.md#AD13).
> 



## 6.3 Assets and roles

- what names (roles, media types) should be used for ...

## 6.4 Links and relations

- how to encode "offerings" (i.e. links to OGC or other service endpoints in a STAC collection) ?


> **CEOS-STAC-BP-TBD - Reference to metadata [Recommended]**<a name="BP-TBD"></a>
>
> STAC implementations should include Link objects in Collections with rel="alternate" or rel=”via” for detailed representation of the metadata. (The “via” relation should be preferred to convey the authoritative resource or the source of the information from where the Collection is made.)


> **CEOS-STAC-BP-TBD - Reference to documentation [Recommended]**<a name="BP-TBD"></a>
>
> STAC implementations should use a Link object with rel="describedby" to reference from a collection to its documentation.

Note: although some implementations use rel="about" for the same purpose, rel="describedby" is recommended by https://docs.ogc.org/DRAFTS/20-024.html.

The table below list some frequently used formats for metadata standards  or documentation and their corresponding media type (`type`).

| **Format**                   | **type** |   
| --------                   | --------- | 
| [DIF10](https://www.earthdata.nasa.gov/esdis/esco/standards-and-practices/directory-interchange-format-dif-standard)           | `application/dif10+xml` |  
| [ISO19139](https://www.iso.org/standard/32557.html)        | `application/vnd.iso.19139+xml` |  
| [ISO19139-2](https://www.iso.org/standard/57104.html)      | `application/vnd.iso.19139-2+xml` | 
| [ISO19115-3](https://www.iso.org/standard/32579.html)      | `application/vnd.iso.19115-3+xml` | 
| [ISO19157-2](https://www.iso.org/standard/66197.html)      | `application/vnd.iso.19157-2+xml` | 
| [OGC 17-084r1](https://docs.ogc.org/bp/17-084r1/17-084r1.html)  | `application/geo+json;profile=http://www.opengis.net/spec/eoc-geojson/1.0`  |
| [Dublin Core](http://www.loc.gov/standards/sru/recordSchemas/dc-schema.xsd)  | `application/xml`  |
| [Markdown](https://datatracker.ietf.org/doc/html/rfc7763)  | `text/markdown`  |
| [PDF](https://en.wikipedia.org/wiki/PDF)  | `application/pdf`  |

## 6.5 Facilitating catalog federation

- make available DIF10 metadata record as "asset" (for IDN) ?

> **CEOS-STAC-BP-TBD - Root relation [Recommendation]**<a name="BP-TBD"></a>
>
> It is discouraged to use the rel="root" relation in STAC collection encoding as the collection's original data provider's catalog/collections may be included in a federated catalog with a different root.
>

## 6.6 CEOS-ARD recommendations

- TBD
