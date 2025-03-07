# PyNWB and MatNWB

[PyNWB](https://pynwb.readthedocs.io/en/stable/) and [MatNWB](https://matnwb.readthedocs.io) are the official Python and MATLAB APIs for reading and writing NWB files. These libraries provide the most flexibility for creating and manipulating NWB files.

## Overview

PyNWB and MatNWB offer:

- Complete control over the structure and content of NWB files
- Direct access to all features of the NWB format
- Ability to create custom extensions for specialized data types
- Integration with Python and MATLAB analysis workflows

## PyNWB

PyNWB is the Python API for NWB files. It provides a Pythonic interface for creating, reading, and writing NWB files. The [PyNWB tutorials](https://pynwb.readthedocs.io/en/stable/tutorials/index.html) provide examples for creating and using NWB files in Python.

## MatNWB

MatNWB is the MATLAB API for NWB files. It provides a MATLAB interface for creating, reading, and writing NWB files. The [MatNWB tutorials](https://matnwb.readthedocs.io/en/latest/pages/tutorials/index.html) provide examples for creating and using NWB files in MATLAB.

## When to Use PyNWB and MatNWB

PyNWB and MatNWB are ideal for:

- Data formats not supported by [NeuroConv](./neuroconv.md) or [NWB GUIDE](./nwb-guide.md)
- Custom data structures that require specialized handling
- Integration with existing Python or MATLAB analysis workflows
- Creating custom NWB extensions for specialized data types (supported by PyNWB)

While these APIs offer the most flexibility, they also require more knowledge of the NWB format and more programming effort compared to higher-level tools like NeuroConv and NWB GUIDE.
