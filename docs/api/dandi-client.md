# DANDI Client

The DANDI Client is a Python library and command-line tool for interacting with the DANDI Archive. It provides functionality for downloading, validating, organizing, and uploading data to and from the DANDI Archive.

## Installation

You can install the DANDI Client using pip:

```bash
pip install dandi
```

## Documentation

The full documentation for the DANDI Client is available at [https://dandi.readthedocs.io/](https://dandi.readthedocs.io/).

## Key Features

- Download data from the DANDI Archive
- Validate NWB files
- Organize data for upload to the DANDI Archive
- Upload data to the DANDI Archive
- Search for Dandisets
- Manage Dandisets and their metadata

## Python API

The DANDI Client provides a Python API for programmatic interaction with the DANDI Archive. Here's a simple example of using the API to download a Dandiset:

```python
from dandi.dandiapi import DandiAPIClient

# Initialize client
client = DandiAPIClient()

# Get a specific Dandiset
dandiset = client.get_dandiset("000123", "draft")

# Download the Dandiset
dandiset.download("local_path")
```

For more information on the Python API, see the [API documentation](https://dandi.readthedocs.io/en/latest/modref/index.html).

## Command-Line Interface

The DANDI Client also provides a command-line interface for interacting with the DANDI Archive. Here are some common commands:

```bash
# Download a Dandiset
dandi download DANDI:000123

# Validate NWB files
dandi validate path/to/files

# Organize data for upload
dandi organize path/to/files

# Upload data to DANDI
dandi upload
```

For more information on the command-line interface, see the [CLI documentation](https://dandi.readthedocs.io/en/latest/cmdline/index.html).
