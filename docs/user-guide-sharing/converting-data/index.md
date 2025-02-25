# Converting Data to NWB

Before uploading data to DANDI, you need to convert it to the NWB (Neurodata Without Borders) format. This page provides an overview of the conversion process and available tools.

## Why Convert to NWB?

NWB is a standardized data format for neurophysiology that:

- Provides a common structure for storing and sharing neurophysiology data
- Includes rich metadata to make your data more discoverable and reusable
- Enables interoperability with a growing ecosystem of analysis tools
- Facilitates data validation and quality control

## Conversion Process Overview

We suggest beginning the conversion process using only a small amount of data so that common issues may be spotted earlier in the process. This step can be complex depending on your data.

## Available Conversion Tools

Several tools are available to help you convert your data to NWB format:

1. **[NWB Graphical User Interface for Data Entry (GUIDE)](https://nwb-guide.readthedocs.io/en/stable/)** is a cross-platform desktop application for converting data from common proprietary formats to NWB and uploading it to DANDI.

2. **[NeuroConv](https://neuroconv.readthedocs.io/)** is a Python library that automates conversion to NWB from a variety of popular formats. See the [Conversion Gallery](https://neuroconv.readthedocs.io/en/main/conversion_examples_gallery/index.html) for example conversion scripts.

3. **[PyNWB](https://pynwb.readthedocs.io/en/stable/)** and **[MatNWB](https://github.com/NeurodataWithoutBorders/matnwb)** are APIs in Python and MATLAB that allow full flexibility in reading and writing data. ([PyNWB tutorials](https://pynwb.readthedocs.io/en/stable/tutorials/index.html), [MatNWB tutorials](https://github.com/NeurodataWithoutBorders/matnwb?tab=readme-ov-file#tutorials))

4. **[NWB Overview Docs](https://nwb-overview.readthedocs.io)** points to more tools helpful for working with NWB files.

## Getting Help

Converting data to NWB can be challenging, especially for complex datasets or formats not directly supported by existing tools. If you need assistance, feel free to [reach out to us for help](https://github.com/dandi/helpdesk/discussions).

## Next Steps

After converting your data to NWB, you should:

1. [Validate your NWB files](../validating-files.md) to ensure they meet DANDI's requirements
2. [Upload your data to DANDI](../uploading-data.md)
