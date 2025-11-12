# Validating Files

## Validating NWB Files

To be accepted by DANDI, NWB files must conform to criteria that are enforced via three levels of validation:

### NWB File Validation
[PyNWB validation](https://pynwb.readthedocs.io/en/stable/validation.html) is used to validate the NWB files, 
ensuring that they meet the specifications of core NWB and of any NWB extensions that were used. Generally 
speaking, all files produced by PyNWB and MatNWB should pass validation, however there are occasional bugs. More 
often, NWB files that fail to meet these criteria have been created outside PyNWB and MatNWB.

### Missing DANDI Metadata
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

### Critical NWB Checks
The [NWB Inspector](https://nwbinspector.readthedocs.io/en/dev/) scans NWB files using heuristics to find mistakes or areas for improvements in NWB files. There are three levels of importance for checks: `CRITICAL`, `BEST PRACTICE VIOLATIONS`, and `BEST PRACTICE SUGGESTIONS`. `CRITICAL` warnings indicate some internal inconsistency in the data of the NWB files. The NWB Inspector will print out all warnings, but only `CRITICAL` warnings will prevent a file from being uploaded to DANDI. The NWB Inspector supports a special configuration for DANDI that includes additional checks relevant to DANDI. To use this configuration, you can specify the `--config dandi` option when running NWB Inspector.

You can run NWB Inspector locally by installing it via pip:
```bash
pip install nwbinspector
```

Then you can run it on your NWB file:
```bash
nwbinspector --config dandi path/to/yourfile.nwb
```

You can also use a directory as input, in which case it will recursively scan for NWB files.

Passing all of these levels of validation can sometimes be tricky. If you have any questions, please ask them via the 
[DANDI Help Desk](https://github.com/dandi/helpdesk/discussions) and we would be happy to assist you.

## Validating BIDS Files

Once your files are converted to the BIDS standard,

  - ensure that you have `.bidsignore` file containing `dandiset.yaml`, since that DANDI-specific file is not part of BIDS specification;
  - perform validation of the files ideally using both
    - the stock [BIDS validator](https://bids.neuroimaging.io/tools/validator.html)
    - and/or [dandi validate](https://dandi.readthedocs.io/en/latest/cmdline/validate.html) since it would also validate using other helper tools such as [NWB inspector](https://nwb.org/tools/core/nwbinspector/) if you have NWBs, to ensure that your data is compliant to all used standards.

Note that [dandi upload](https://dandi.readthedocs.io/en/latest/cmdline/upload.html) will also perform validation during upload.
