# Uploading Data

This page provides instructions for uploading data to DANDI after you have [created a Dandiset](./creating-dandiset.md) and [converted your data to NWB format](./converting-data/index.md).

## Prerequisites

Before uploading data to DANDI, ensure you have:

1. [Created a Dandiset](./creating-dandiset.md) on DANDI
2. [Converted your data to NWB format](./converting-data/index.md)
3. [Validated your NWB files](./validating-files.md) to ensure they meet DANDI's requirements
4. Installed the [DANDI Client](https://pypi.org/project/dandi/):
   ```bash
   pip install -U dandi
   ```

5. Set up your API key (see [Storing Access Credentials](#storing-access-credentials) below)

## Upload Methods

DANDI provides two main methods for uploading data:

### 1. Using NWB GUIDE

The NWB GUIDE provides a graphical interface for uploading data to DANDI. See the [NWB GUIDE Dataset Publication Tutorial](https://nwb-guide.readthedocs.io/en/latest/tutorials/dataset_publication.html) for more information.

### 2. Using the DANDI CLI

For command-line users or those with larger datasets, the DANDI CLI provides a powerful way to upload data:

1. **Download the Dandiset locally**:

   ```bash
   dandi download https://dandiarchive.org/dandiset/<dataset_id>/draft
   cd <dataset_id>
   ```

2. **Organize your data** (skip this step if you are preparing a proper [BIDS dataset](https://bids.neuroimaging.io/) with e.g. OME-Zarr, NWB and other files):

   ```bash
   dandi organize <source_folder> -f dry  # Dry run to see what would happen
   dandi organize <source_folder>         # Actually organize the files
   ```

3. **Validate your data**:

   ```bash
   dandi validate .
   ```

4. **Upload your data**:

   ```bash
   dandi upload
   ```

   To upload to the development server, use:

   ```bash
   dandi upload -i dandi-staging
   ```

## Storing Access Credentials

There are two options for storing your DANDI access credentials:

### 1. `DANDI_API_KEY` Environment Variable

- By default, the DANDI CLI looks for an API key in the `DANDI_API_KEY` environment variable. To set this on Linux or macOS, run:

  ```bash
  export DANDI_API_KEY=personal-key-value
  ```

- Note that there are no spaces around the "=".

### 2. `keyring` Library

- If the `DANDI_API_KEY` environment variable is not set, the CLI will look up the API key using the [keyring](https://github.com/jaraco/keyring) library, which supports numerous backends, including the system keyring, an encrypted keyfile, and a plaintext (unencrypted) keyfile.

- **Specifying the `keyring` backend**:
  - You can set the backend the `keyring` library uses either by setting the `PYTHON_KEYRING_BACKEND` environment variable or by filling in the `keyring` library's [configuration file](https://github.com/jaraco/keyring#configuring).
  - IDs for the available backends can be listed by running `keyring --list`.
  - If no backend is specified, the library will use the available backend with the highest priority.

- **Storing the API key with `keyring`**:
  1. You can store your API key where the `keyring` library can find it by using the `keyring` program: Run `keyring set dandi-api-dandi key` and enter the API key when asked for the password for `key` in `dandi-api-dandi`.
  2. If the API key isn't stored in either the `DANDI_API_KEY` environment variable or in the keyring, the CLI will prompt you to enter the API key, and then it will store it in the keyring.

## Troubleshooting

If you encounter issues during the upload process:

- Ensure your NWB files pass validation (see [Validating NWB Files](./validating-files.md))
- Check that you're using the latest versions of `dandi`, `PyNWB`, and `MatNWB`

If you continue to have issues, please reach out via the [DANDI Help Desk](https://github.com/dandi/helpdesk/discussions).
