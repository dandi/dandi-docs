# Creating a Dandiset

This page provides instructions for creating a new Dandiset on DANDI.

## Prerequisites

Before creating a Dandiset, you should:

1. **Register for DANDI and obtain an API key.** To create a new Dandiset, you need to have a DANDI account.
   * If you do not already have an account, see [Create a DANDI Account](../getting-started/creating-account.md) page for instructions. 
   * Once you are logged in, copy your API key by clicking on your user initials in the top-right corner after logging in.
   * Production (https://dandiarchive.org) and staging (https://gui-staging.dandiarchive.org) servers have different API keys and different logins.

2. **Choose a server.**
   * **Production server**: https://dandiarchive.org. This is the main server for DANDI and should be used for sharing neuroscience data.
     When you create a Dandiset, a permanent ID is automatically assigned to it.
     This Dandiset can be fully public or embargoed according to NIH policy.
     All data are uploaded as draft and can be adjusted before publishing on the production server.
   * **Development server**: https://gui-staging.dandiarchive.org. This server is for testing and learning how to use DANDI.
     It is not recommended for sharing data, but is recommended for testing the DANDI CLI and GUI or as a testing platform for developers.
     Note that the development server should not be used to stage your data.

## Creating a New Dandiset

1. **Create a new Dandiset.** 
   * Click `NEW DANDISET` in the Web application (top right corner) after logging in.
   * You will be asked to enter basic metadata: a name (title) and description (abstract) for your dataset. 
   * After you provide a name and description, the dataset identifier will be created; we will call this `<dataset_id>`.

2. **Add metadata to the Dandiset.** 
   * Visit your Dandiset landing page: `https://dandiarchive.org/dandiset/<dataset_id>/draft` and click on the `METADATA` link.
   * Fill in the required metadata fields. For more information on Dandiset metadata, see the [Dandiset Metadata](./dandiset-metadata.md) page.

## Next Steps

After creating your Dandiset, you'll need to:

1. [Convert your data to NWB format](./converting-data/index.md)
2. [Validate your NWB files](./validating-files.md)
3. [Upload your data to DANDI](./uploading-data.md)
4. [Publish your Dandiset](./publishing-dandisets.md) when you're ready to share it with the community
