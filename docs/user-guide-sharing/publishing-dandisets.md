# Publishing Dandisets

Once you create a Dandiset, DANDI will automatically create a `draft` version
of the Dandiset that can be changed as many times as needed by editing the 
metadata or uploading new files.

When the draft version is ready, you can *publish* your Dandiset. This results
in an immutable snapshot of your Dandiset with its own unique version number
that others can cite. If you need to change the data or metadata, you can do
so by continuing to modify the draft version and publishing a new version
when you are ready.

Follow these steps to publish your Dandiset:

1. Edit the Dandiset metadata, aiming to fix all Dandiset metadata validation
   errors, and include any other useful information. For example, you may want
   to edit the following fields:
    - People and funding contributors
    - Protocol information
    - Keywords
    - Related resources such as publications and code repositories
    - Description - Note, images can be embedded using Markdown syntax with external links:
      ```markdown
      ![enter-text-here](<enter-url-to-image-here>)
      ```

1. Fix all asset metadata errors by modifying the asset files to eliminate
   the errors and re-uploading them.

1. When all the Dandiset metadata and asset metadata errors are fixed, and the Dandiset is made public if it was initially embargoed, the
   `Publish` button (on the right panel of the Dandiset landing page) will
   be enabled and turn green. Click the button to publish your Dandiset.

1. In the lower right section of the Dandiset landing page, you should see
   the new, published version of your Dandiset listed. Click on that link
   to view this version.

**NOTE:** Dandisets with Zarr assets currently cannot be published. We are 
actively working on enabling this feature.

## Citing DANDI

You can add the following statement to the methods section of your manuscript.

> Data and associated metadata were uploaded to the DANDI archive [RRID:SCR_017571] using 
  the Python command line tool (https://doi.org/10.5281/zenodo.3692138). The data were first 
  converted into the NWB format (https://doi.org/10.1101/2021.03.13.435173) and  organized 
  into a BIDS-like (https://doi.org/10.1038/sdata.2016.44) structure.

You can refer to DANDI using any of the following options:

* Using an RRID [RRID:SCR_017571](https://scicrunch.org/scicrunch/Resources/record/nlx_144509-1/SCR_017571/resolver). 

* Using the DANDI CLI reference: https://doi.org/10.5281/zenodo.3692138
