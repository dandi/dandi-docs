# External Services

DANDI integrates with various external services to enhance data accessibility and analysis capabilities. This page describes the external services that can be used with DANDI data.

The trusted applications below have worked with the DANDI team to integrate their tools. In some applications (e.g. Neurosift) you may enter your `DANDI_API_KEY` to view embargoed data. If you need to reset your `DANDI_API_KEY`, please see these [instructions](../../user-guide-sharing/uploading-data.md#1-dandi_api_key-environment-variable).

## NWB Explorer

[NWB Explorer](https://nwbexplorer.opensourcebrain.org/) is a web-based tool for visualizing and exploring NWB files. It provides an interactive interface for browsing NWB file structure and visualizing data without requiring any programming.

### Using NWB Explorer with DANDI

1. Navigate to a Dandiset on the DANDI Archive
2. Browse to an NWB file
3. Look for the "Open with NWB Explorer" link next to the file
4. Click the link to open the file in NWB Explorer

NWB Explorer allows you to:

- Browse the hierarchical structure of NWB files
- Visualize time series data
- View spike raster plots
- Explore spatial data
- Examine metadata

## Neurosift

[Neurosift](https://neurosift.app/) is a web-based visualization platform for neurophysiology data. It provides interactive visualizations for various types of neural data, including spike trains, LFP, and tracking data.

### Using Neurosift with DANDI

1. Navigate to a Dandiset on the DANDI Archive
2. Browse to an NWB file
3. Look for the "Open with Neurosift" link next to the file
4. Click the link to open the file in Neurosift

Neurosift allows you to:

- Visualize spike trains and raster plots
- Explore LFP and other time series data
- View position tracking data
- Analyze neural data with interactive plots
- Share visualizations with collaborators

## Custom Integrations

DANDI provides a [REST API](https://api.dandiarchive.org/swagger) that can be used to build custom integrations with other services. The API allows you to:

- Search for Dandisets and assets
- Get metadata for Dandisets and assets
- Download assets
- And more

For more information on the DANDI API, see the [API documentation](../../api/rest-api.md).
