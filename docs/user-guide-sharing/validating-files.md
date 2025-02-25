# Validating NWB Files
To be accepted by DANDI, NWB files must conform to criteria that are enforced via three levels of validation:

## NWB File Validation
[PyNWB validation](https://pynwb.readthedocs.io/en/stable/validation.html) is used to validate the NWB files, 
ensuring that they meet the specifications of core NWB and of any NWB extensions that were used. Generally 
speaking, all files produced by PyNWB and MatNWB should pass validation, however there are occasional bugs. More 
often, NWB files that fail to meet these criteria have been created outside PyNWB and MatNWB.

## Critical NWB Checks
The [NWB Inspector](https://nwbinspector.readthedocs.io/en/dev/) scans NWB files using heuristics to find mistakes 
or areas for improvements in NWB files. There are three levels of importance for checks: `CRITICAL`, 
`BEST PRACTICE VIOLATIONS`, and `BEST PRACTICE SUGGESTIONS`. `CRITICAL` warnings indicate some internal inconsistency in the data of the 
NWB files. The NWB Inspector will print out all warnings, but only `CRITICAL` warnings will prevent a file from being 
uploaded to DANDI. Errors in NWB Inspector will be block upload as well, but reflect a problem with the NWB 
Inspector software as opposed to the NWB file. 

## Missing DANDI Metadata
DANDI has requirements for metadata beyond what is strictly required for NWB validation. The following metadata must 
be present in the NWB file for a successful upload to DANDI:

  - You must define a `Subject` object.
  - The `Subject` object must have a `subject_id` attribute.
  - The `Subject` object must have a `species` attribute. This can either be the Latin binomial, e.g. "Mus musculus", or 
  an NCBI taxonomic identifier.
  - The `Subject` object must have a `sex` attribute. It must be "M", "F", "O" (other), or "U" (unknown).
  - The `Subject` object must have either `date_of_birth` or `age` attribute. It must be in ISO 8601 format, e.g. "P70D" 
  for 70 days, or, if it is a range, must be "[lower]/[upper]", e.g. "P10W/P12W", which means "between 10 and 12 weeks"

These requirements are specified in the 
[DANDI configuration file of NWB Inspector](https://github.com/NeurodataWithoutBorders/nwbinspector/blob/dev/src/nwbinspector/internal_configs/dandi.inspector_config.yaml).

Passing all of these levels of validation can sometimes be tricky. If you have any questions, please ask them via the 
[DANDI Help Desk](https://github.com/dandi/helpdesk/discussions) and we would be happy to assist you.
