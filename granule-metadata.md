[Previous](collection-catalogs.md) | [Table of contents](README.md) | [Next](collection-metadata.md)
***
# 6. Granule Metadata Best Practices

[//]: # (this is a comment)

## 6.1 Overview

This chapter presents the requirements and recommendations that apply to STAC granule metadata representations (returned by a static or searchable catalog, in isolation or included in a search response) in addition to the general metadata requirements presented in [Metadata Best Practices](best-practices.md#33-metadata-best-practices).

The requirements and recommendations provided relate to:

- Properties
- Asset and roles
- Links and relations
- Facilitating federation 

## 6.2 Properties

> **CEOS-STAC-REQ-6210 - Granule representation [Requirement]**<a name="BP-6210"></a>
>
> A(n EO) Granule metadata record shall be represented as a STAC Item according to version v1.0.0 of the "STAC Item Specification" [[AD03]](./introduction.md#AD03).

> **CEOS-STAC-REC-6220 - Temporal extents [Recommendation]**<a name="BP-6220"></a>
>
> STAC implementations should represent temporal extents in Items with the `start_datetime` and `end_datetime` properties and include the value for `start_datetime` also as `datetime` property.

> **CEOS-STAC-REQ-6230 - Geographical extents [Requirement]**<a name="BP-6230"></a>
>
> STAC implementations shall represent geographical extents of Items with the `geometry` property (GeoJSON Geometry object or null if not available).

Geographical extents of Items are represented using GeoJSON geometry objects [RFC7946](#AD4) in STAC item search responses.  This representation can natively represent multi-point, multi-line and multi-polygon geometries, thus no additional guidance similar to `CEOS-BP-014B`, `CEOS-BP-014C` and `CEOS-BP-014D` is required.

> **CEOS-STAC-REQ-6235 - Polygon geometry [Requirement]**<a name="BP-6235"></a>
>
> The geographical extent of an Item represented as polygon shall follow the right-hand rule with respect to the area it bounds and in case of a polygon with more than one ring, the first shall be the exterior ring and the others shall be interior rings as required by the [GeoJSON specification](https://datatracker.ietf.org/doc/html/rfc7946#section-3.1.6).

> **CEOS-STAC-REQ-6240 - Minimum-bounding rectangle [Requirement]**<a name="BP-6240"></a>
>
> CEOS implementations should render spatial extents using a minimum-bounding
rectangle (MBR) with a GeoJSON `bbox` property [RFC7946](#AD4) in addition to the native more accurate
representation of that extent with the `geometry` property. The value of the bbox
element must be an array of length 4 (two long/lat pairs), with the southwesterly point followed by the northeasterly point.

The `bbox` item property is mandatory according to the STAC Item specification unless `geometry` is null.


> **CEOS-STAC-REQ-6250 - Granule representation  extension [Recommendation]**<a name="BP-6250"></a>
>
> A(n EO) Granule metadata record represented as a STAC Item should use applicable properties defined by the following STAC extensions:


| **Reference**                   | **STAC Extension** |     **Example Properties** |
| --------                   | --------- |  --------- | 
| [[AD14]](./introduction.md#AD14)  | [EO Extension](https://github.com/stac-extensions/eo)  |  eo:cloud_cover, eo:snow_cover, eo:bands |
| [[AD15]](./introduction.md#AD15)  | [SAR Extension](https://github.com/stac-extensions/sar)  | sar:instrument_mode, sar:polarizations, sar:product_type |
| [[AD16]](./introduction.md#AD16)  | [SAT Extension](https://github.com/stac-extensions/sat)  | sat:orbit_state, sat:absolute_orbit, ... |
| [[AD13]](./introduction.md#AD13)  | [Scientific Extension](https://github.com/stac-extensions/scientific)  | sci:doi |
| [[AD17]](./introduction.md#AD17)  | [Version Extension](https://github.com/stac-extensions/version)  | version |
| [[AD18]](./introduction.md#AD18)  | [View Extension](https://github.com/stac-extensions/view)  | view:azimuth, view:incidence_angle, ... |
| [[AD19]](./introduction.md#AD19)  | [Projection Extension](https://github.com/stac-extensions/projection)  | proj:espg |
| [[AD20]](./introduction.md#AD20)  | [Timestamps Extension](https://github.com/stac-extensions/timestamps)  | published, expires |
| [[AD23]](./introduction.md#AD23)  | [Landsat Extension](https://landsat.usgs.gov/stac/landsat-extension/schema.json)  | landsat:wrs_path, landsat:wrs_row |
| [[AD21]](./introduction.md#AD21)  | [Processing Extension](https://github.com/stac-extensions/processing)  | processing:level, processing:facility, ... |
| [[AD22]](./introduction.md#AD22)  | [Hyperspectral Extension](https://github.com/stac-extensions/hsi)  | hsi:wavelength_min, hsi:wavelength_max |


Additional guidance on how to encode OGC17-003r2 metadata properties with the above extensions is available in ["Mapping from OGC EO Dataset Metadata GeoJSON(-LD) Encoding Standard to STAC"](https://github.com/stac-utils/stac-crosswalks/tree/master/OGC_17-003r2). 


```json
{ 
  "stac_version": "1.0.0",
  "id": "AL1_OESR_AV2_OBS_1C_20060613T100220_20060613T100232_002047_0307_2730_0410",
  "bbox": [
    14.5302398,
    42.4746857,
    15.6508019,
    43.348489
  ],
  "geometry": {
    "coordinates": [
      [
        [
          14.7799437,
          43.348489
        ],
        [
          15.6508019,
          43.1791444
        ],
        [
          15.3915014,
          42.4746857
        ],
        [
          14.5302398,
          42.6427013
        ],
        [
          14.7799437,
          43.348489
        ]
      ]
    ],
    "type": "Polygon"
  },
  "collection": "ALOS.AVNIR-2.L1C",
  "type": "Feature",
  "stac_extensions": [
    "https://stac-extensions.github.io/sar/v1.0.0/schema.json",
    "https://stac-extensions.github.io/processing/v1.1.0/schema.json",
    "https://stac-extensions.github.io/projection/v1.1.0/schema.json",
    "https://stac-extensions.github.io/sat/v1.0.0/schema.json",
    "https://stac-extensions.github.io/view/v1.0.0/schema.json"
  ],
  "properties": {
    "start_datetime": "2006-06-13T10:02:20.948Z",
    "end_datetime": "2006-06-13T10:02:32.786Z",
    "processing:facility": "ESR",
    "view:sun_azimuth": 147,
    "title": "AL1_OESR_AV2_OBS_1C_20060613T100220_20060613T100232_002047_0307_2730_0410",
    "platform": "ALOS",
    "proj:epsg": 4326,
    "view:sun_elevation": 67,
    "datetime": "2006-06-13T10:02:20.948Z",
    "sar:instrument_mode": "OBS",
    "instruments": [
      "AVNIR-2"
    ],
    "constellation": "ALOS",
    "sar:product_type": "AV2_OBS_1C",
    "sat:orbit_state": "DESCENDING",
    "processing:software": {
      "AVNIR-2": "04.10"
    },
    "updated": "2023-03-28T18:01:51Z",
    "sat:absolute_orbit": 2047
  }
}
```

> **CEOS-STAC-PER-6255 - Granule representation extension validation [Permission]**<a name="BP-6255"></a>
>
> A CEOS STAC implementation may include a subset of properties in the item encoding defined by any of the above STAC extensions, even though the STAC extension may require additional properties to be included to pass the corresponding STAC extension JSON schema validation. 


## 6.3 Assets and roles

> **CEOS-STAC-REC-6310 - Browse image [Recommendation]**<a name="BP-6310"></a>
>
> STAC implementations should provide a URL to the granule’s browse image when available, via an Asset object with role=`overview`.

> **CEOS-STAC-REC-6320 - Thumbnail image [Recommendation]**<a name="BP-6320"></a>
>
> STAC implementations should provide a URL to the granule’s thumbnail image (smaller than the browse image) when available, via an Asset object with role=`thumbnail`.

```json
 "assets": {
    "quicklook": {
      "roles": [
        "overview"
      ],
      "href": "http://tpm-ds.eo.esa.int/oads/meta/PROBA1-CHRIS/browse/PR1_OPER_CHR_MO2_1P_20020710T102800_N45-018_E012-003_0001.SIP.ZIP_BID.PNG",
      "type": "image/png",
      "title": "QUICKLOOK"
    },
    "thumbnail": {
      "roles": [
        "thumbnail"
      ],
      "href": "http://tpm-ds.eo.esa.int/oads/meta/PROBA1-CHRIS/thumbnail/PR1_OPER_CHR_MO2_1P_20020710T102800_N45-018_E012-003_0001.SIP.ZIP_TIMG.jpg",
      "type": "image/png",
      "title": "THUMBNAIL"
    }
 }
```

> **CEOS-STAC-REC-6330 - Data access [Recommendation]**<a name="BP-6330"></a>
>
> STAC implementations should provide the data access URL for the granule via an Asset object with role=`data`.


Example: Asset object for Cloud Optimized GeoTIFF data
```json
"assets": {
  "enclosure": {
          "roles": [
          "data"
      ],
      "href": "https://storage.googleapis.com/sample-cogs/cog/20210515_145754_03_245c_3B_AnalyticMS.tif",
      "type": "image/tiff; application=geotiff; profile=cloud-optimized",
      "title": "4-Band Analytic"
  }
}
```

Example: Asset object for Zarr data
```json
 "assets": {
    "zmetadata": {
      "roles": [
        "data",
        "metadata",
        "zarr-consolidated-metadata"
      ],
      "description": "Consolidated metadata file for Zarr store",
      "href": "https://storage.sbg.cloud.ovh.net/v1/AUTH_d40770b0914c46bfb19434ae3e97ae19/hdsa-public/prisma_v2/20200410/.zmetadata",
      "type": "application/json"
    }
 }
```


> **CEOS-STAC-REC-6340 - Data access to multiple files [Recommendation]**<a name="BP-6340"></a>
>
> When data access to a granule in a granule search response is to be provided in multiple physical files, each file should be linked to via a separate Asset object with role=`data`.



> **CEOS-STAC-REC-6360 - Alternate locations [Recommendation]**<a name="BP-6360"></a>
>
> When the same assets are available at multiple locations or via multiple protocols, they should be encoded as `alternate asset` as defined in the "STAC Alternate Assets Extension Specification" [[AD24]](./introduction.md#AD24).
>

.Example: Use of alternate Asset object for data available on S3 storage
```json
 "assets": {
    "data": {
      "href": "https://storage.esa.int/store/TSX_OPER_SAR/2013/06/11/TSX_OPER_SAR_SC_MGD_20130611T054228_N53-141_E011-048_0000_v0100/TSX_OPER_SAR_SC_MGD_20130611T054228_N53-141_E011-048_0000_v0100.zarr/.zmetadata",
      "title": "Zarr consolidated metadata",
      "type": "application/json"
      "roles": [
        "data",
        "metadata",
        "zarr-consolidated-metadata"
      ],
      "alternate": {
        "s3": {
          "title": "S3 Access",
          "href": "s3://storage.esa.int/store/TSX_OPER_SAR/2013/06/11/TSX_OPER_SAR_SC_MGD_20130611T054228_N53-141_E011-048_0000_v0100/TSX_OPER_SAR_SC_MGD_20130611T054228_N53-141_E011-048_0000_v0100.zarr/.zmetadata"
        }
      }
    }
  }
```

> **CEOS-STAC-REC-6370 - Common band names [Recommendation]**<a name="BP-6370"></a>
>
> If access to individual bands is provided via assets, then [Common Band Names](https://github.com/stac-extensions/eo/blob/main/README.md#common-band-names) should be used, preferably according to the forthcoming OGC Best Practice document [[RD03]](./introduction.md#RD03).
>

## 6.4 Links and relations

> **CEOS-STAC-REC-6410 - WMS Offering [Recommendation]**<a name="BP-6410"></a>
>
> STAC implementations should indicate available data access via WMS using a STAC Web Map Link as defined in [[AD26]](./introduction.md#AD26).

.Example: Use of WMS Web Map Link Extension
```json
{
    "href": "http://10.23.12.4/v1/wmts",
    "rel": "wms",
    "type": "image/png",
    "wms:transparent": true,
    "title": "Granule visualized via WMS",
    "wms:layers": [
        "SMOS_Open_V7:SMOS_Open_V7_MIR_OSUDP2_cog",
        "SMOS_Open_V7:SMOS_Open_V7_MIR_SMUDP2_cog"
    ],
    "wms:styles": [
        "RAINBOW"
    ],
    "wms:dimensions": {
        "time": "2023-10-04T01:04:20.174Z,2023-10-04T01:58:21.418Z",
    }
}
```

## 6.5 Facilitating catalog federation

> **CEOS-STAC-REQ-6510 - Absolute links [Requirement]**<a name="BP-6510"></a>
>
> "href" attributes in links or assets shall use absolute paths and not relative paths in CEOS STAC granule metadata records.


## 6.6 CEOS-ARD 

[CEOS-ARD](https://ceos.org/ard/) [[AD30]](./introduction.md#AD30) publishes Product Family Specifications (PFS) that define recommendations and requirements to make certain types of data available as Analysis-Ready Data (ARD).

The CEOS-ARD specifications are available as specification text and do not provide an official mapping to STAC.
A community-lead project aims at providing a mapping between the CEOS-ARD requirements and existing STAC extensions, which can be used as a guideline for STAC implementations that aim for CEOS-ARD compliance.
See the [STAC CEOS-ARD Extension Specification](https://github.com/stac-extensions/ceos-ard) [[AD28]](./introduction.md#AD28) and its Optical and Radar profiles for details.

***
[Previous](collection-catalogs.md) | [Table of contents](README.md) | [Next](collection-metadata.md)
