# Deleting Dandisets

This page explains how to delete an entire Dandiset from the DANDI Archive.

Deletion is permanent. There is no undo and no trash bin, so make sure you have a local
copy of anything you may need before deleting.

## What You Can Delete

- You must be an owner of the Dandiset to delete anything from it.
- An entire Dandiset can be deleted if it has no published versions and is not currently
  being published or unembargoed.
- Individual files can be deleted only in the `draft` version.
- An embargoed Dandiset can be deleted by its owners under the same conditions as a
  public one.
- A published version can be withdrawn only by the DANDI team. See [Published
  Dandisets](#published-dandisets) below.

### Published Dandisets

Once a Dandiset has been published, it has a DOI and a citable, immutable version, so
neither the published version nor the Dandiset itself can be deleted. Withdrawing
published content is an exceptional action described in the [DANDI
Policies](../terms-policies/policies.md#removal). If you need a published Dandiset
withdrawn, [contact the DANDI team](../support.md).

## Deleting an Entire Dandiset

Deleting a Dandiset removes its draft version, all of its files, and its metadata. The
Dandiset identifier is retired and is not reassigned.

There is no button in the web application for deleting an entire Dandiset. Use the DANDI
Client as described below.

### Using the DANDI Client

Install the client and store your API key first, as described in [Storing Access
Credentials](./uploading-data.md#storing-access-credentials). Then run:

```bash
dandi delete dandi://dandi/<dandiset_id>
```

See the [`dandi delete`
documentation](https://dandi.readthedocs.io/en/latest/cmdline/delete.html) for the full
list of options.

