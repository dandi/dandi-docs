# Validating Files

DANDI validates data against multiple standards to ensure quality and
interoperability.  The unified entry point is `dandi validate`, which checks
NWB files, BIDS datasets, and DANDI-specific layout requirements in a single
command.

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

You can run `dandi validate` on NWB files directly:

```console
$ dandi validate sub-RAT123/sub-RAT123.nwb
[pynwb.GENERIC] sub-RAT123/sub-RAT123.nwb — error: nwb_version '2.0b' is not a proper semantic version.
[NWBI.check_subject_age] sub-RAT123/sub-RAT123.nwb — Subject age, '12 mo', does not follow ISO 8601 duration format...
[NWBI.check_subject_weight] sub-RAT123/sub-RAT123.nwb — Subject weight '2 lbs' does not follow the expected form...
```

Each line shows the **issue ID** (e.g., `NWBI.check_subject_age`), the **file path**, and a **description** of the
problem.

Passing all of these levels of validation can sometimes be tricky. If you have any questions, please ask them via the
[DANDI Help Desk](https://github.com/dandi/helpdesk/discussions) and we would be happy to assist you.

## Validating BIDS Datasets

Once your files are converted to the BIDS standard,

  - ensure that you have a [`dataset_description.json`](https://bids-specification.readthedocs.io/en/stable/modality-agnostic-files/dataset-description.html#dataset_descriptionjson) file at the top-level of your dataset directory;
  - ensure that you have a `.bidsignore` file containing `dandiset.yaml`, since that DANDI-specific file is not part of the BIDS specification;
  - perform validation of the files using `dandi validate` to ensure your data is compliant with the BIDS and/or NWB standards.

`dandi validate` runs the [BIDS Validator](https://bids.neuroimaging.io/tools/validator.html) and reports all
findings.  For example, on a valid BIDS EEG dataset with only minor recommendations:

```console
$ dandi validate eeg_cbm/
[BIDS.README_FILE_MISSING] eeg_cbm/dataset_description.json — The recommended file /README is missing.
[BIDS.JSON_KEY_RECOMMENDED] eeg_cbm/dataset_description.json — A JSON file is missing a key listed as recommended.
[BIDS.SIDECAR_KEY_RECOMMENDED] eeg_cbm/sub-cbm001/eeg/sub-cbm001_task-protmap_eeg.edf — A data file's JSON sidecar is missing a key listed as recommended.
...
```

On a dataset with actual errors (missing README, wrong file extension):

```console
$ dandi validate --min-severity ERROR invalid_eeg_cbm/
[BIDS.EMPTY_FILE] invalid_eeg_cbm/sub-cbm001/eeg/sub-cbm001_task-protmap_eeg.edf — Empty files not allowed.
[BIDS.NIFTI_HEADER_UNREADABLE] invalid_eeg_cbm/sub-cbm011/sub-cbm011_scans.nii — We were unable to parse header data from this NIfTI file.
[BIDS.EXTENSION_MISMATCH] invalid_eeg_cbm/sub-cbm011/sub-cbm011_scans.nii — Extension used by file does not match allowed extensions for its suffix
...
```

!!! note
    [`dandi upload`](https://dandi.readthedocs.io/en/latest/cmdline/upload.html) also validates
    before uploading. Only ERROR-level and above issues block upload; HINTs and WARNINGs are
    reported but do not prevent upload.

## Using `dandi validate`

### Basic Usage

Validate a single file, a directory, or an entire Dandiset:

```bash
dandi validate path/to/file.nwb
dandi validate path/to/bids-dataset/
dandi validate .  # validate current directory
```

### Output Formats

By default, `dandi validate` prints human-readable text.  Use `--format` (`-f`) to switch:

=== "Text (default)"

    ```
    [NWBI.check_subject_age] sub-RAT123/sub-RAT123.nwb — Subject age, '12 mo', does not follow ISO 8601 duration format...
    [NWBI.check_subject_weight] sub-RAT123/sub-RAT123.nwb — Subject weight '2 lbs' does not follow the expected form...
    ```

=== "YAML"

    ```yaml
    - id: NWBI.check_subject_age
      severity: ERROR
      path: sub-RAT123/sub-RAT123.nwb
      message: "Subject age, '12 mo', does not follow ISO 8601 duration format..."
      origin:
        validator: nwbinspector
        standard: null
    ```

=== "JSON"

    ```json
    [
      {
        "id": "NWBI.check_subject_age",
        "severity": "ERROR",
        "path": "sub-RAT123/sub-RAT123.nwb",
        "message": "Subject age, '12 mo', does not follow ISO 8601 duration format...",
        "origin": {
          "validator": "nwbinspector",
          "standard": null
        }
      }
    ]
    ```

=== "JSONL"

    ```json
    {"id": "NWBI.check_subject_age", "severity": "ERROR", "path": "sub-RAT123/sub-RAT123.nwb", ...}
    {"id": "NWBI.check_subject_weight", "severity": "ERROR", "path": "sub-RAT123/sub-RAT123.nwb", ...}
    ```

    JSONL (JSON Lines) emits one JSON object per line, which is ideal for piping to other tools
    or loading into data analysis environments.

```bash
dandi validate -f yaml path/to/data/
dandi validate -f json_pp path/to/data/      # pretty-printed JSON
dandi validate -f json_lines path/to/data/   # one JSON object per line
```

### Filtering and Grouping

**Filter by severity** to focus on what matters:

```bash
dandi validate --min-severity ERROR path/to/data/   # only errors and critical
dandi validate --min-severity WARNING path/to/data/  # warnings and above
```

**Ignore specific issues** by ID regex:

```bash
dandi validate --ignore "BIDS.SIDECAR_KEY_RECOMMENDED" path/to/data/
```

**Group results** to organize large output.  Use `-g` (repeatable for nesting):

```console
$ dandi validate -g severity invalid_eeg_cbm/
=== HINT (410 issues) ===
  [BIDS.README_FILE_MISSING] dataset_description.json — The recommended file /README is missing.
  [BIDS.JSON_KEY_RECOMMENDED] dataset_description.json — A JSON file is missing a key...
  [BIDS.JSON_KEY_RECOMMENDED] dataset_description.json — A JSON file is missing a key...
  ... and 407 more issues
=== ERROR (22 issues) ===
  [BIDS.EMPTY_FILE] sub-cbm001/eeg/sub-cbm001_task-protmap_eeg.edf — Empty files not allowed.
  [BIDS.EMPTY_FILE] sub-cbm002/eeg/sub-cbm002_task-protmap_eeg.edf — Empty files not allowed.
  [BIDS.EMPTY_FILE] sub-cbm003/eeg/sub-cbm003_task-protmap_eeg.edf — Empty files not allowed.
  ... and 19 more issues
```

Hierarchical grouping with `-g severity -g id`:

```console
$ dandi validate -g severity -g id --max-per-group 2 invalid_eeg_cbm/
=== HINT (410 issues) ===
  === BIDS.README_FILE_MISSING (1 issue) ===
    [BIDS.README_FILE_MISSING] dataset_description.json — The recommended file /README is missing.
  === BIDS.JSON_KEY_RECOMMENDED (3 issues) ===
    [BIDS.JSON_KEY_RECOMMENDED] dataset_description.json — A JSON file is missing a key...
    [BIDS.JSON_KEY_RECOMMENDED] dataset_description.json — A JSON file is missing a key...
    ... and 1 more issue
  === BIDS.SIDECAR_KEY_RECOMMENDED (360 issues) ===
    ...
=== ERROR (22 issues) ===
  === BIDS.EMPTY_FILE (20 issues) ===
    [BIDS.EMPTY_FILE] sub-cbm001/eeg/sub-cbm001_task-protmap_eeg.edf — Empty files not allowed.
    [BIDS.EMPTY_FILE] sub-cbm002/eeg/sub-cbm002_task-protmap_eeg.edf — Empty files not allowed.
    ... and 18 more issues
  === BIDS.NIFTI_HEADER_UNREADABLE (1 issue) ===
    ...
  === BIDS.EXTENSION_MISMATCH (1 issue) ===
    ...
```

Available grouping keys: `none`, `path`, `severity`, `id`, `validator`, `standard`, `dandiset`.

Use `--max-per-group N` to limit output per group and `--summary` to append aggregate statistics:

```console
$ dandi validate --summary 000027/
[DANDI.NO_DANDISET_FOUND] 000027 — Path is not inside a Dandiset
[pynwb.GENERIC] sub-RAT123/sub-RAT123.nwb — error: nwb_version '2.0b' is not a proper semantic version.
[NWBI.check_subject_age] sub-RAT123/sub-RAT123.nwb — Subject age, '12 mo', does not follow ISO 8601 duration format...
[NWBI.check_subject_weight] sub-RAT123/sub-RAT123.nwb — Subject weight '2 lbs' does not follow the expected form...
--- Validation Summary ---
Total issues: 4
By severity:
  ERROR: 4
By validator:
  dandi: 2
  nwbinspector: 2
By standard:
  N/A: 3
  DANDI-LAYOUT: 1
```

### Saving and Loading Results

Save results to a file with `--output` (`-o`). The format is auto-detected from the file extension:

```bash
dandi validate -o results.jsonl path/to/data/   # JSONL
dandi validate -o results.yaml path/to/data/    # YAML
dandi validate -o results.json path/to/data/    # JSON
```

!!! tip "Automatic companion files"
    Every time you run `dandi validate` (without `--output`), a JSONL companion file is
    automatically saved next to the dandi-cli log file.  Look for a message like:

    ```
    Validation companion saved to ~/.local/state/dandi-cli/log/2026.04.04-12.00.00Z-123_validation.jsonl
    ```

**Reload saved results** with `--load` to re-render with different grouping, filtering, or format
without re-running validation:

```bash
# Re-review with different grouping
dandi validate --load results.jsonl -g severity -g id

# Show only errors
dandi validate --load results.jsonl --min-severity ERROR

# Convert to YAML
dandi validate --load results.jsonl -f yaml

# Combine multiple result files
dandi validate --load run1.jsonl --load run2.jsonl -g validator --summary
```

This is especially useful for large datasets where validation takes a long time.

## Validation During Upload

When you run `dandi upload`, validation is performed automatically before each file is
uploaded.  The validation results are saved as a JSONL companion file alongside the upload
log:

```
~/.local/state/dandi-cli/log/2026.04.04-12.00.00Z-123.log               # upload log
~/.local/state/dandi-cli/log/2026.04.04-12.00.00Z-123_validation.jsonl   # validation results
```

On macOS, logs are stored under `~/Library/Logs/dandi-cli/` instead.

To review validation results from a past upload:

```bash
dandi validate --load ~/.local/state/dandi-cli/log/*_validation.jsonl --summary
```

Only ERROR-level and above issues block upload.  HINTs and WARNINGs are recorded but
do not prevent files from being uploaded.  See
[Uploading Data](uploading-data.md) for more details on the upload process.

## Reviewing Results with VisiData

[VisiData](https://www.visidata.org/) is an interactive terminal tool for exploring tabular
data.  It can open JSONL files directly, making it ideal for navigating validation results.

Install VisiData and open a validation result file:

```bash
pip install visidata
vd results.jsonl
```

Useful VisiData key bindings for validation review:

| Key | Action |
|-----|--------|
| `[` / `]` | Sort ascending / descending by current column |
| `F` | Frequency table for current column (great for severity or id) |
| `\|` | Select rows matching a regex in the current column |
| `-` | Hide the current column |
| `z Enter` | Expand the current cell (useful for long messages) |
| `q` | Quit the current sheet (or exit VisiData) |

Compose multiple validation files for a combined view:

```bash
cat upload1_validation.jsonl upload2_validation.jsonl | vd -f jsonl
```

<div id="visidata-demo"></div>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    if (typeof AsciinemaPlayer !== 'undefined') {
      AsciinemaPlayer.create(
        '../../examples/validation/visidata-demo.cast',
        document.getElementById('visidata-demo'),
        { cols: 120, rows: 36, speed: 1.5, idleTimeLimit: 2, theme: 'monokai' }
      );
    }
  });
</script>

## Validation Result Schema

Each validation result (whether displayed as text or serialized to JSON/YAML/JSONL) contains
these fields:

| Field | Description |
|-------|-------------|
| `id` | Issue identifier, e.g., `NWBI.check_subject_age`, `BIDS.EMPTY_FILE` |
| `severity` | One of: `INFO`, `HINT`, `WARNING`, `ERROR`, `CRITICAL` |
| `scope` | What was validated: `file`, `folder`, `dandiset`, or `dataset` |
| `path` | Path to the problematic file or directory |
| `message` | Human-readable description of the issue |
| `asset_paths` | List of affected asset paths (if applicable) |
| `within_asset_paths` | Location within an HDF5/NWB file hierarchy |
| `dandiset_path` | Path to the Dandiset root |
| `dataset_path` | Path to the dataset root |
| `metadata` | Additional metadata (e.g., BIDS entity mappings) |
| `origin` | Validator information (see below) |
| `record_version` | Schema version for forward compatibility (currently `"1"`) |

The `origin` field identifies which validator produced the result:

| Field | Description |
|-------|-------------|
| `validator` | Tool name: `dandi`, `nwbinspector`, or `bids-validator-deno` |
| `validator_version` | Version of the validator tool |
| `standard` | Standard being checked: `BIDS`, `DANDI-LAYOUT`, `DANDI-SCHEMA`, `NWB`, `OME-ZARR` |
| `standard_version` | Version of the standard (if applicable) |
| `standard_schema_version` | Schema version (e.g., BIDS schema `1.2.1`) |

Severity levels in order of increasing importance:

| Level | Value | Meaning |
|-------|-------|---------|
| `INFO` | 10 | Status information |
| `HINT` | 20 | Data is valid but could be improved |
| `WARNING` | 30 | Data is not fully valid; changes recommended |
| `ERROR` | 40 | Data is invalid |
| `CRITICAL` | 50 | Serious issue preventing further validation |

Only `ERROR` and `CRITICAL` issues block upload to DANDI.

## Troubleshooting

If you have questions about validation errors or need help fixing issues, please ask via the
[DANDI Help Desk](https://github.com/dandi/helpdesk/discussions).
