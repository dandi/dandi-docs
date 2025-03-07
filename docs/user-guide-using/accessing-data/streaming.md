# Streaming Data

Streaming data allows you to access and analyze DANDI data without downloading entire files. This is particularly useful for large datasets where downloading the complete files would be impractical.

## Streaming Methods

DANDI provides several methods for streaming data:

### 1. Python-based streaming methods

Using Python, you can set up data streaming using remfile, fsspec, or ros3. See the [PyNWB streaming tutorial](https://pynwb.readthedocs.io/en/stable/tutorials/advanced_io/streaming.html) for details. Note that these streaming methods tend to work better on [DANDI Hub](../dandi-hub.md), where data access is faster.

### 2. DataLad FUSE Mount

[DataLad FUSE](https://github.com/datalad/datalad-fuse/) allows you to mount DANDI datasets as if they were local files, with data being streamed on-demand when accessed.

```bash
# Install DataLad and DataLad FUSE
pip install datalad datalad-fuse

# Clone a Dandiset without downloading content
datalad clone https://github.com/dandisets/000123 dandiset-000123
cd dandiset-000123

# Mount the dataset
datalad fusefs -f .

# Now you can access files in the mountpoint directory
# Data will be streamed as needed
```