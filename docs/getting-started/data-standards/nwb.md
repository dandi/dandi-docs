# Neurodata Without Borders (NWB)

[NWB](https://www.nwb.org/nwb-neurophysiology/) is a data standard for neurophysiology, providing neuroscientists with a common standard to share, archive, use, and build analysis tools for neurophysiology data.

NWB is designed to store a variety of neurophysiology data, including data from intracellular and extracellular electrophysiology experiments, data from optical physiology experiments, and tracking and stimulus data.

## NWB Tools and Resources

The NWB team supports APIs in Python ([PyNWB](https://pynwb.readthedocs.io/)) and MATLAB ([MatNWB](https://matnwb.readthedocs.io/)), with tutorials for writing data broken down by experiment type. See [Converting Data to NWB](../../user-guide-sharing/converting-data/index.md) for the latest tools to convert data to NWB.

## Getting Help with NWB

The best way to get help from the NWB community is through the [NWB user Slack channel](https://nwb-users.slack.com/).

## Using NWB with DANDI

DANDI is designed to work seamlessly with NWB files. When you upload NWB files to DANDI:

1. The files are validated to ensure they conform to the NWB standard
2. Metadata is automatically extracted to make your data more discoverable
3. The data can be accessed programmatically through the DANDI API

For more information on validating NWB files for DANDI, see the [Validating NWB Files](../../user-guide-sharing/validating-files.md) section.
