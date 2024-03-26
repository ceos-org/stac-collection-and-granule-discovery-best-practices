[Previous](collection-metadata.md) | [Table of contents](README.md)
***
# 8. Federation Best Practices
The CWIC federated discovery architecture will remain as-is but we will replace the existing Open Search API implementations with STAC API implementations.

To recap the CWIC architecture uses a two-step discovery process (see 8.1). Collection discovery will be implemented by CMR's STAC API utilizing the following extensions to the core STAC API specifications,
- Collection Search
- Bounding Box filtering
- Temporal extent filtering
- Free text filtering
- Others?

```
GET https://cmr.earthdata.nasa.gov/stac/ISRO/collections
```
The results of a collection search will consist of a list of STAC collections. Each collection corresponds to a CMR collection. If that collection is a CWIC collection it will contain a link, of relation 'items', that points to a STAC API. This API will return items (granule metadata) for that specific collection. 

```
collections: [
    {
        id: "IMS1_HYSI_GEO.v1.0",
        stac_version: "1.0.0-beta.2",
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
                type: "application/json"
            }
        ]
        ...
    },
]
```

That API may be resident in either NASA CMR or a CWIC agency. A client can then search for granules associated with a particular collection at this endpoint.

```
GET https://uops.nrsc.gov.in/stac/collections/IMS1_HYSI_GEO.v1.0/items
```

The results of an item search will consist of a list of STAC items

## 8.1 Two-step discovery
The primary rationale behind two-step discovery is to improve the efficiency,  accuracy and performance of searching for geospatial data.
But, an additional benefit of splitting the search paradigm along collection and granule lines is the ability to host collection and granule search services at different agencies. CWIC leverages this ability to provide a federated discovery capability.

## 8.2 Collection discovery
For successfull collection discovery the CWIC Best Practices for Open Search require the following support,
- Filter by spatial constraint: Bounding Box
- Filter by temporal constraint
- Filter by free text
### STAC Extensions required for CWIC collection discovery
In order to achieve a federated CWIC solution, a STAC API implementing the collection step of two-step discovery must implement the following extensions,
| **ID**  | **Title** | 
| -------- | --------- | 
| `AD06` <a name="AD06"></a> | [STAC API - Filter Extension](https://github.com/stac-api-extensions/filter) |
| `AD07` <a name="AD07"></a> | [STAC API - Collection Search](https://github.com/stac-api-extensions/collection-search) |
| `AD27` <a name="AD26"></a> |[STAC API - Free Text Search](https://github.com/cedadev/stac-freetext-search)|

## 8.3 Granule discovery
For successfull granule discovery the CWIC Best Practices for Open Search require the following support,
- Filter by spatial constraint: Bounding Box
- Filter by temporal constraint
### STAC Extensions required for CWIC granule discovery
In order to achieve a federated CWIC solution, a STAC API serving granules must implement the following extensions,
| **ID**  | **Title** | 
| -------- | --------- | 
| `AD06` <a name="AD06"></a> | [STAC API - Filter Extension](https://github.com/stac-api-extensions/filter) |
## 8.4 Data acquisition
The list of items that a granule search will return will represent data files/granules. Each of those items will have a link to the data itself which the client can use to acquire the data. It should be noted that the API that serves up this data may (and usually is) subject to a particular agencies authentication system. This usually manifests as an OAUTH2-type user experience where the user is first redirected to a login page where they can either create a user profile or enter the credentials of their existing profile. Once complete, the user is redirected to the data asset and acquisition can complete.
***
[Previous](collection-metadata.md) | [Table of contents](README.md)