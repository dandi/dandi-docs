# Introduction

## What is DANDI?

DANDI is:

- An open data archive to submit neurophysiology data for electrophysiology,
optophysiology, and behavioral time-series, and images from immunostaining experiments.
- A persistent, versioned, and growing collection of standardized datasets.
- A place to house data to collaborate across research sites.
- Supported by the BRAIN Initiative and the AWS Public dataset programs.

DANDI provides significant benefits:

- A [FAIR (Findable, Accessible, Interoperable, Reusable)](https://www.force11.org/group/fairgroup/fairprinciples) data archive to house standardized neurophysiology and associated data.
- Rich metadata to support search across data.
- Consistent and transparent data standards to simplify data reuse and software development. We use the [Neurodata Without Borders](https://nwb.org), 
[Brain Imaging Data Structure](https://bids.neuroimaging.io/),
[Neuroimaging Data Model (NIDM)](http://nidm.nidash.org/), and other [BRAIN Initiative](https://braininitiative.nih.
  gov/) standards to organize and search the data. See [Data Standards](./getting-started/data-standards/index.md) for more information.
- The data can be accessed programmatically allowing for software to work directly with data in the cloud.
- The infrastructure is built on a software stack of open source products, thus enriching the ecosystem.

### Properties of DANDI 

**Data identifiers:** The archive provides persistent identifiers for versioned datasets and assets, thus improving reproducibility of neurophysiology research.

**Data storage:** Cloud-based platform on AWS. Data are available from a public S3 bucket. Data from embargoed datasets are available from a private bucket to owners only.

**Type of data** The archive accepts cellular neurophysiology data including electrophysiology, optophysiology, and behavioral time-series, and images from immunostaining experiments and other associated data (e.g. participant information, MRI or other modalities).

**Accepted Standards and Data File Formats:** NWB (HDF5), BIDS (NIfTI, JSON, PNG, TIF, OME.TIF, OME.BTF, OME.ZARR) 
(see [Data Standards](./getting-started/data-standards/index.md) for more details)

## Neurophysiology Informatics Challenges and DANDI Solutions

| Challenges | Solutions |
|---|---|
| Most raw data stays in laboratories. | DANDI provides a public archive for dissemination of raw and derived data. |
| Non-standardized datasets lead to significant resource needs to understand and adapt code to these datasets. | DANDI standardizes all data using NWB and BIDS standards. |
| The multitude of different hardware platforms and custom binary formats requires significant effort to consolidate into reusable datasets. | The DANDI ecosystem provides tools for converting data from different instruments into NWB and BIDS. |
| There are many domain general places to house data (e.g. Open Science Framework, G-Node, Dropbox, Google drive), but it is difficult to find relevant scientific metadata. | DANDI is focused on neurophysiology data and related metadata. |
| Datasets are growing larger, requiring compute services to be closer to data. | DANDI provides Dandihub, a JupyterHub instance close to the data. |
| Neurotechnology is evolving and requires changes to metadata and data storage. | DANDI works with community members to improve data standards and formats. |
| Consolidating and creating robust algorithms (e.g. spike sorting) requires varied data sources. | DANDI provides access to many different datasets. |
