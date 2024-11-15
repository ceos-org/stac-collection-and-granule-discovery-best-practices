[Previous](collection-metadata.md) | [Table of contents](README.md)
***
# 8. Federation Best Practices
CEOS provides federated search capabilities called CWIC (The CEOS WGISS Integrated Catalog), FedEO (Federated Earth Observation missions access) and IDN (International Directory Network). These capabilities combined provide a seamless user experience when discovering collections of interest across multiple agencies, identifying granules of interest within those collections and, ultimately, obtaining the data from the agency the collection belongs to.

The federated discovery architecture will remain as-is but we will replace the existing OpenSearch API implementations with STAC API implementations.

The architecture uses a two-step discovery process (see 8.1). Collection discovery will be implemented by NASA CMR's and FedEO's STAC API 

The API corresponding to the 'items' link may be resident in a CEOS agency. A client can then search for granules associated with a particular collection at this endpoint.

## 8.1 Two-step discovery
The primary rationale behind two-step discovery is to improve the efficiency,  accuracy and performance of searching for geospatial data.
But, an additional benefit of splitting the search paradigm along collection and granule lines is the ability to host collection and granule search services at different agencies. 

## 8.2 Collection discovery
For successfull collection discovery the Best Practices for STAC require the following support,
- Filter by spatial constraint: Bounding Box
- Filter by temporal constraint
- Filter by free text

Example:
```
GET https://cmr.earthdata.nasa.gov/stac/collections
```
The results of a collection search will consist of a list of STAC collections. Each collection corresponds to a CEOS collection. If that collection supports granule search it will contain a link, of related 'items', that points to a STAC API. This API will return items (granule metadata) for that specific collection and support filtering of those results by query. 

```
collections: [
    {
        id: "IMS1_HYSI_GEO.v1.0",
        stac_version: "1.0.0",
        license: "not-provided",
        title: "IMS-1 HYSI TOA Radiance and Reflectance Product",
        description: 
            "The data received from IMS1, HySI which operates in 64 spectral bands in VNIR bands(400-900nm) with 500 meter spatial resolution and swath of 128 kms.",
        links: [
            ...
            {
                rel: "items",
                href: "https://uops.nrsc.gov.in/stac/collections/IMS1_HYSI_GEO.v1.0/items",
                title: "Granules in this collection",
                type: "application/geo+json"
            }
        ]
        ...
    },
]
```
### STAC Extensions required for CWIC collection discovery
In order to achieve a federated CWIC solution, a STAC API implementing the collection step of two-step discovery must implement the following extensions,
| **ID**  | **Title** | 
| -------- | --------- | 
| `AD06` <a name="AD06"></a> | [STAC API - Filter Extension](https://github.com/stac-api-extensions/filter) |
| `AD07` <a name="AD07"></a> | [STAC API - Collection Search](https://github.com/stac-api-extensions/collection-search) |
| `AD27` <a name="AD26"></a> |[STAC API - Free Text Search](https://github.com/cedadev/stac-freetext-search)  |

## 8.3 Granule discovery
For successful granule discovery, an CEOS agency STAC API will require the following support,
- Filter by spatial constraint: Bounding Box
- Filter by temporal constraint

```
GET https://uops.nrsc.gov.in/stac/collections/IMS1_HYSI_GEO.v1.0/items
```

The results of an item search will consist of a list of STAC items

### STAC Extensions required for CWIC granule discovery
In order to achieve a federated CWIC solution, a STAC API serving granules must implement the following extensions,
| **ID**  | **Title** | 
| -------- | --------- | 
| `AD06` <a name="AD06"></a> | [STAC API - Filter Extension](https://github.com/stac-api-extensions/filter) |


## 8.4 Data acquisition
The list of items that a granule search will return will represent data files/granules. Each of those items will have a link to the data itself which the client can use to acquire the data. It should be noted that the API that serves up this data may be (and usually is) subject to a particular agency's authentication system. This usually manifests as an OAUTH2-type user experience where the user is first redirected to a login page where they can either create a user profile or enter the credentials of their existing profile. Once complete, the user is redirected to the data asset and acquisition can complete.


## 8.5 Authentication

> **CEOS-STAC-REQ-8510 - No authentication for discovery [Requirement]**<a name="BP-8510"></a>
>
> STAC implementations shall not require authentication for collection and granule discovery and provide access to the following resources (if available) without requiring authentication:
- collection metadata (STAC collection)
- granule metadata (STAC item)
- granule thumbnail
- granule quicklook


> **CEOS-STAC-REC-8520 - Advertising authentication interface [Recommendation]**<a name="BP-8520"></a>
>
> STAC implementations requiring authentication for asset download should advertise this using the STAC Authentication Extension [[AD32]](./introduction.md#AD32).


> **CEOS-STAC-REC-8530 - Advertising OpenID Connect authentication interface in granule metadata [Recommendation]**<a name="BP-8530"></a>
>
> STAC implementations requiring authentication via OpenID Connect for asset download (e.g. data download) should indicate this in the granule metadata using the STAC Authentication Extension [[AD32]](./introduction.md#AD32) and refer to the [metadata of the OpenID server](https://swagger.io/docs/specification/v3_0/authentication/openid-connect-discovery/).

.Example: Use of the Authentication Extension for OpenID Connect
```json
{
  "stac_version": "1.0.0",

  "assets": {
    "enclosure": {
      "created": "2012-01-17T00:00:00Z",
      "roles": [
        "data"
      ],
      
      "href": "https://catalog.maap.eo.esa.int/data/TropForest/2009/01/06/AL1_OTPF_AL1_AV2_2F_20090106T041747_20090106T041747_000000_E097_N025/AL1_OTPF_AL1_AV2_2F_20090106T041747_20090106T041747_000000_E097_N025.ZIP",
      "auth:refs": [
        "oidc"
      ],
      "type": "application/zip",
      "title": "Download",
      "file:size": 10512689
    }
  },
 
  "id": "AL1_OTPF_AL1_AV2_2F_20090106T041747_20090106T041747_000000_E097_N025",
  "collection": "TropForest",
  "type": "Feature",
  "stac_extensions": [
    "https://stac-extensions.github.io/file/v2.1.0/schema.json",
    "https://stac-extensions.github.io/authentication/v1.1.0/schema.json"
  ],
  "properties": {
    "auth:schemes": {
      "oidc": {
        "openIdConnectUrl": "https://iam.ascend.icsgate.eu/realms/esa-maap/.well-known/openid-configuration",
        "type": "openIdConnect"
      }
    }
  }
}
```


***
[Previous](collection-metadata.md) | [Table of contents](README.md)
