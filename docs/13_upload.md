# Creating Dandisets and Uploading Data

This page provides instructions for creating a new Dandiset and uploading data to DANDI.

## Prerequisites
1. **Convert data to NWB.** You should start by converting your data to NWB format (2.1+). We suggest beginning the conversion process using only a small amount of data so that common issues may be spotted earlier in the process.
  This step can be complex depending on your data. Consider using the following tools:

    1. **[NWB Graphical User Interface for Data Entry (GUIDE)](https://nwb-guide.readthedocs.io/en/stable/)** is a cross-platform desktop application for converting data from common proprietary formats to NWB and uploading it to DANDI.
    2. **[NeuroConv](https://neuroconv.readthedocs.io/)** is a Python library that automates  conversion to NWB from a variety of popular formats. See the [Conversion Gallery](https://neuroconv.readthedocs.io/en/main/conversion_examples_gallery/index.html) for example conversion scripts.
    3. **[PyNWB](https://pynwb.readthedocs.io/en/stable/)** and **[MatNWB](https://github.com/NeurodataWithoutBorders/matnwb)** are APIs in Python and MATLAB that allow full flexibility in reading and writing data. ([PyNWB tutorials](https://pynwb.readthedocs.io/en/stable/tutorials/index.html), [MatNWB tutorials](https://github.com/NeurodataWithoutBorders/matnwb?tab=readme-ov-file#tutorials))
    4. **[NWB Overview Docs](https://nwb-overview.readthedocs.io)** points to more tools helpful for working with NWB files.

    Feel free to [reach out to us for help](https://github.com/dandi/helpdesk/discussions).

2. **Choose a server.**
    - **Production server**: https://dandiarchive.org. This is the main server for DANDI and should be used for sharing neuroscience data.
      When you create a Dandiset, a permanent ID is automatically assigned to it.
      This Dandiset can be fully public or embargoed according to NIH policy.
      All data are uploaded as draft and can be adjusted before publishing on the production server.
    - **Development server**: https://gui-staging.dandiarchive.org. This server is for testing and learning how to use DANDI.
      It is not recommended for sharing data, but is recommended for testing the DANDI CLI and GUI or as a testing platform for developers.
      Note that the development server should not be used to stage your data.
   
     The below instructions will alert you to where the commands for interacting with these two different servers differ slightly. 

3. **Register for DANDI and copy the API key.** To create a new Dandiset and upload your data, you need to have a DANDI account.
     * If you do not already have an account, see [Create a DANDI Account](./16_account.md) page for instructions. 
     * Once you are logged in, copy your API key.
     Click on your user initials in the top-right corner after logging in.
     Production (https://dandiarchive.org) and staging (https://gui-staging.dandiarchive.org) servers have different API keys and different logins.
     * Store your API key somewhere that the CLI can find it; see ["Storing Access Credentials"](#storing-access-credentials) below.

## Data upload/management workflow

The NWB GUIDE provides a graphical interface for inspecting and validating NWB files, as well as for uploading data to
DANDI. See the **[NWB GUIDE Dataset Publication Tutorial](https://nwb-guide.readthedocs.io/en/latest/tutorials/dataset_publication.html)** for more information.

The below instructions show how to do the same thing programmatically using the command line interface (CLI).
The CLI approach may be more suitable for users who are comfortable with the command line or who need to automate the process, or for advanced use-cases.

1. **Create a new Dandiset.** 
    * Click `NEW DANDISET` in the Web application (top right corner) after logging in.
    * You will be asked to enter basic metadata: a name (title) and description (abstract) for your dataset. 
    * After you provide a name and description, the dataset identifier will be created; we will call this `<dataset_id>`.
1. **Check your files for [NWB Best Practices](https://nwbinspector.readthedocs.io/en/dev/best_practices/best_practices_index.html).**
   Run [NWB Inspector](https://nwbinspector.readthedocs.io/en/dev/user_guide/user_guide_index.html) programmatically. Install the Python library (`pip install -U nwbinspector`) and run:

        nwbinspector <source_folder> --config dandi
   
     If the report is too large to efficiently navigate in your console, you can save a report using

        nwbinspector <source_folder> --config dandi --report-file-path <report_location>.txt
          
     For more details and other options, run:
                
        nwbinspector --help

     Thoroughly read the NWBInspector report and try to address as many issues as possible.
     **DANDI will prevent validation and upload of any issues labeled as level 'CRITICAL' or above when using the `--config dandi` option.**
     See ["Validation Levels for NWB Files"](./135_validation.md) for more information about validation criteria for 
     uploading NWB files and which are deemed critical. We recommend regularly running the inspector early in the process to generate the best NWB files possible. Note that some auto-detected violations, such as `check_data_orientation`, may be safely ignored in the event 
     that the data is confirmed to be in the correct form. See [the NWBInspector CLI documentation](https://nwbinspector.readthedocs.io/en/dev/user_guide/using_the_command_line_interface.html) for more information.

1. **Install the [DANDI Client](https://pypi.org/project/dandi/).**

        pip install -U dandi

1. **Validate NWB files.** Perform a validation of the NWB files by running:
        
        dandi validate --ignore DANDI.NO_DANDISET_FOUND <source_folder>

     **If you are having trouble with validation, make sure the conversions were run with the most recent version of `dandi`, `PyNWB` and `MatNWB`.**

1. **Upload the data to DANDI.** This can either be done through the NWB GUIDE, or programmatically:

        dandi download https://dandiarchive.org/dandiset/<dataset_id>/draft
        cd <dataset_id>
        dandi organize <source_folder> -f dry
        dandi organize <source_folder>
        dandi validate .
        dandi upload

     Note that the `organize` steps should not be used if you are preparing a BIDS dataset with the NWB files.
     Uploading to the development server is controlled via `-i` option, e.g. `dandi upload -i dandi-staging`.
     Note that validation is also done during `upload`, but ensuring compliance using `validate` prior to upload helps avoid interruptions of the lengthier upload process due to validation failures.
     If you have an issue using the DANDI Client, see the [DANDI Debugging section](./15_debugging.md).

1. **Add metadata to the Dandiset.** Visit your Dandiset landing page:
   `https://dandiarchive.org/dandiset/<dataset_id>/draft` and click on the `METADATA` link.


## Storing Access Credentials

There are two options for storing your DANDI access credentials.

1. `DANDI_API_KEY` Environment Variable

    - By default, the DANDI CLI looks for an API key in the `DANDI_API_KEY`
      environment variable.  To set this on Linux or macOS, run:

            export DANDI_API_KEY=personal-key-value

    - Note that there are no spaces around the "=".

2. `keyring` Library
    - If the `DANDI_API_KEY` environment variable is not set, the CLI will look up the API
        key using the [keyring](https://github.com/jaraco/keyring) library, which
        supports numerous backends, including the system keyring, an encrypted keyfile,
        and a plaintext (unencrypted) keyfile.

    - Specifying the `keyring` backend
        - You can set the backend the `keyring` library uses either by setting
          the `PYTHON_KEYRING_BACKEND` environment variable or by filling in
          the `keyring` library's [configuration file](https://github.com/jaraco/keyring#configuring).

        - IDs for the available backends can be listed by running `keyring
          --list`.

        - If no backend is specified in this way, the library will use the
          available backend with the highest priority.

        - If the DANDI CLI encounters an error while attempting to fetch the
          API key from the default keyring backend, it will fall back to using
          an encrypted keyfile (the `keyrings.alt.file.EncryptedKeyring`
          backend).  If the keyfile does not already exist, the CLI will ask
          you for confirmation; if you answer "yes," the `keyring`
          configuration file (if it does not already exist; see above) will be
          configured to use `EncryptedKeyring` as the default backend.  If you
          answer "no," the CLI will exit with an error, and you must store the
          API key somewhere accessible to the CLI on your own.

            - Unless a different location is set via the `keyring`
              configuration file, the encrypted keyfile will be located at the
              following path:

                - On Linux and macOS, if the `XDG_DATA_HOME` environment
                  variable is set to a nonempty string, the keyfile will be at
                  `$XDG_DATA_HOME/python_keyring/crypted_pass.cfg`; otherwise,
                  it will be at
                  `~/.local/share/python_keyring/crypted_pass.cfg`.

                - On Windows, if the `LOCALAPPDATA` environment variable is
                  set, the keyfile will be at `%LOCALAPPDATA%\Python
                  Keyring\crypted_pass.cfg`; otherwise, if the `ProgramData`
                  environment variable is set, the keyfile will be at
                  `%ProgramData%\Python Keyring\crypted_pass.cfg`; otherwise,
                  it will be at `Python Keyring\crypted_pass.cfg` within the
                  current directory.

    - Storing the API key with `keyring`
        1. You can store your API key where the `keyring` library can find it by using
          the `keyring` program: Run `keyring set dandi-api-dandi key` and enter the
          API key when asked for the password for `key` in `dandi-api-dandi`.

        2. If the API key isn't stored in either the `DANDI_API_KEY` environment variable
          or in the keyring, the CLI will prompt you to enter the API key, and then it
          will store it in the keyring.  This may cause you to be prompted further; you
          may be asked to enter a password to encrypt/decrypt the keyring, or you may be
          asked by your operating system to confirm whether to give the DANDI CLI access to the
          keyring.
