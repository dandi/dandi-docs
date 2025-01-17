# Dandiset Metadata

The Dandiset Landing Page (DLP) displays metadata about the Dandiset and the data within.
Some of this metadata is automatically extracted from the files, for example the `Size` in the top panel.
The Assets Summary panel at the bottom of the DLP displays additional information
that is automatically extracted from NWB files, such as the species of the subject and the types of recordings.
This metadata will automatically be re-computed if you make any changes to the data files.

## Metadata editor

DANDI also has metadata that you must set manually using the `METADATA` button on the right panel.
Any `Owner` of a Dandiset has the ability to edit the manual Dandiset metadata through this editor.
Several fields here are essential for publication, and the rest provide opportunities to make your Dandiset
more FAIR, enabling secondary analysis.

### General

The General section is for high-level metadata.
The title should be about as descriptive as the title of a journal article.
If this Dandiset is associated with a specific journal article or preprint, you may give the Dandiset the same title.
You may also use the paper abstract as the Dandiset Description, though you are encouraged to provide more
detailed information if appropriate.

Note that funding information should be entered in the Dandiset Contributors section, **not** in the `Acknowledgements`
field of `General`.


### Contributors

The Contributors section allows you to provide attribution to personnel and organizations that contributed to the
publication of this data, metadata that is essential for Publication of the Dandiset. For each person, you
have the ability to enter rich metadata.
We highly encourage the use of ORCID identifiers for each person.
For each person, you have the ability to annotate multiple roles.
The "Author" role is often appropriate for contributors.
Marking a contributor as "Author" will make their name appear on the DLP.
You can also add contributors that are non-authors, such as data curators.
One of the personnel must be listed as the Contact, and this Person must have contact information.


**The Contributors tab is also where you enter funding information.**
Choose "Organization" and proceed to fill in information.
ror.org is a platform that provides unique identifiers for institutions.
It is highly recommended to search http://ror.org and include the unique identifiers for each funding agency.
Make sure to inspect the metadata for each institution on the ror.org website, as many organizations have similar names
(e.g. many different countries have an "NIH").

### Subject Matter

The Subject Matter section allows you to annotate the Dandiset with links to terms in ontologies. Use `Generic Type`
for any type other than `Anatomy` or `Disorder`.

### Ethics Approvals

The Ethics Approvals section allows you to provide information about the ethics approvals that were obtained for the
experiment. It is highly recommended to include this information.

### Related Resources

This section allows you to annotate the Dandiset with links to related resources such as publications and code repositories.
It is highly recommended to add links to the following resources (if they exist):

  * The associated publication
  * The public code repository used to convert the data
  * A data analysis library associated with the publication that can take this data as input
  * An example notebook submitted to http://github.com/dandi/example-notebooks that demonstrates how to use the data
  * Associated datasets published on DANDI or on other archives.