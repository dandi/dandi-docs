# Accessing Data

DANDI provides multiple ways to access data stored in the archive. This page provides an overview of the different methods available for accessing data from Dandisets.

## Access Methods Overview

DANDI offers several methods for accessing data, each suited to different use cases:

1. **Web Interface**: Browse and download individual files directly from the DANDI web application.
2. **DANDI CLI**: Command-line tool for downloading entire Dandisets or specific files.
3. **DataLad**: Access Dandisets as Git repositories with DataLad for version control and reproducibility.
4. **WebDAV**: Access DANDI data using standard WebDAV clients.
5. **DANDI Hub**: Analyze data directly in the cloud using Jupyter notebooks.
6. **Programmatic Access**: Access data programmatically using the DANDI API through Python or other languages.

## Choosing the Right Access Method

The best method for accessing data depends on your specific needs:

- **For browsing and exploring data**: Use the [Web Interface](./downloading.md#using-the-dandi-web-application).
- **For downloading entire Dandisets**: Use the [DANDI CLI](./downloading.md#using-the-python-cli-client).
- **For version control and reproducibility**: Use [DataLad](./downloading.md#using-datalad).
- **For integration with existing tools**: Use [WebDAV](./downloading.md#using-webdav), [DANDI CLI](./downloading.md#using-the-python-cli-client), [DANDI Python Client](https://dandi.readthedocs.io/) or [DANDI API](./external-services.md#dandi-api) depending on the tool language/interfaces.
- **For cloud-based analysis**: Use [DANDI Hub](../dandi-hub.md).
- **For programmatic access**: Use the [DANDI Python Client](https://dandi.readthedocs.io/) for Python or the [DANDI API](./external-services.md#dandi-api) for other languages.

## Data Access Considerations

When accessing data from DANDI, consider the following:

- **Data Size**: Large datasets may be better accessed using the DANDI CLI or DataLad rather than the web interface.
- **Bandwidth**: For users with limited bandwidth, consider using DANDI Hub to analyze data in the cloud.
- **Reproducibility**: DataLad provides version control and reproducibility features that are valuable for scientific workflows.
- **Streaming**: For large files, streaming access may be more efficient than downloading entire files.

## Next Steps

Explore the following pages for detailed information on each access method:

- [Downloading Data](./downloading.md): Learn how to download data using the web interface, DANDI CLI, DataLad, or WebDAV.
- [Streaming Data](./streaming.md): Learn how to stream data without downloading entire files.
- [External Services](./external-services.md): Learn about external services that can be used to access and analyze DANDI data.
- [DANDI Hub](../dandi-hub.md): Learn how to use DANDI Hub for cloud-based analysis.
