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
