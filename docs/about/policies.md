# General Policies v1.1.0

## Content

- **Scope:** Neurophysiology research. Raw and derived experimental data. Content
  must not violate privacy or copyright, or breach confidentiality or non-disclosure
  agreements for data collected from human subjects.
- **Status of research data:** Empirical (not simulated) data and associated metadata from any stage of the
  research study's life cycle is accepted.  Simulated data is handled on a case-by-case basis, contact the DANDI team 
- **Eligible users:** Anyone working with the data in the scope of the archive may register as a user of DANDI. All users are
  allowed to deposit content for which they possess the appropriate rights
  and which falls within the **scope** of the archive.
- **Ownership:** By uploading content, no change of ownership is implied and no
  property rights are transferred to the DANDI team. All uploaded content remains
  the property of the parties prior to submission and must be accompanied by a license allowing
  DANDI project data access, archival, and re-distribution (see **License** below).
- **Data file formats:** DANDI only accepts data using standardized formats such
  as [Neurodata Without Borders](https://nwb.org), [Brain Imaging Data Structure](https://bids.neuroimaging.io/),
  [Neuroimaging Data Model](https://nidm.nidash.org/), and other [BRAIN Initiative](https://braininitiative.nih.gov/)
  standards. We are working with the community to improve these standards and to
  make DANDI archive FAIR.
- **Data quality:** All data are provided “as-is”, and the user shall hold
  DANDI and data providers supplying data to the DANDI Archive free and harmless in
  connection with the use of such data.
- **Metadata types and sources:** All metadata is stored internally in JSON format
  according to a defined JSON schema. Metadata records violating the schema are not allowed.
- **Language:** Textual items must be in English. Latin names could be used in exceptional cases where appropriate.
- **Licenses:** Users must specify a license for each dataset chosen from the list of the DANDI archive approved licenses. Users allow for the DANDI archive to extract metadata records and make them available under permissive CC0 license.

## Access and Reuse

- **Access to data objects:** Files deposited to the archive are accessible to the public 
  openly or accessible to collaborators for embargoed datasets. Access to metadata and data 
  files is provided over standard protocols such as HTTPS.
- **Use and reuse of data objects:** Use and reuse is subject to the terms of the license
  under which the data objects were deposited.
- **Metadata access and reuse:** Metadata records, provided by the users or extracted from the assets, are licensed under CC0. All metadata is made publicly available and can be harvested.

- **Embargo status:** Users may deposit content under an embargo status and
  provide an anticipated end date for the embargo. The repository will restrict
  access to the data until the end of the embargo period, at which time the
  content will automatically become publicly available. The end of the embargo
  period is the earliest of the date provided by submitter, the first publication
  using the data, or the end of funding support for the collection and/or dissemination
  of the dataset.
- **Restricted access:** Depositors of embargoed datasets have the ability to
  share access with other collaborators. These files will not be made publicly
  available till the end of the embargo period.

## Removal

- **Revocation:** Content not considered to fall under the scope of the repository
  can be removed and associated DOIs issued by DANDI revoked. Inform the DANDI team
  promptly, ideally no later than 24 hours from upload, about any suspected policy
  violation. Alternatively, content found to already have an external DOI will
  have the DANDI DOI invalidated and the record updated to indicate the original
  external DOI. User access may be revoked on violation of Terms of Use.

- **Withdrawal:** If the uploaded research object must later be withdrawn, the
  reason for the withdrawal will be indicated on a tombstone page, which will
  henceforth be served in its place. Withdrawal is considered an exceptional
  action, which normally should be requested and fully justified by the original
  uploader. In any other circumstance reasonable attempts will be made to contact
  the original uploader to obtain consent. The DOI and the URL of the original
  object are retained.

- **User data on Dandihub:** At present, user data on Dandihub is being removed
  periodically and Dandihub storage space should not be considered persistent.

## Longevity

- **Versions:** Datasets are versioned when published. Prior to publishing the
  state of a dataset may continue to evolve and the data or metadata are neither
  versioned, nor guaranteed to persist. Derivatives of data files may be generated, but original content is
  never modified.
- **Replicas:** All data files are stored on an AWS public bucket, with replicas
  housed at Dartmouth College.  Data files are kept in multiple replicas at the
  moment, but this may change over time, and no recovery mechanisms for unversioned data
  should be assumed to be in place.
- **Retention period:** Versioned items will be retained for the lifetime of the repository.
  This is currently the lifetime of the NIH award, which currently expires in
  April 2029.
- **Functional preservation:** DANDI makes no promises of usability and
  understandability of deposited objects.
- **File preservation:** Data files and metadata are backed up nightly and
  replicated into multiple copies in different storage services.
- **Fixity and authenticity:** All data files are stored along with multiple
  checksums of the file content. Files are regularly checked against their
  checksums to assure that file content remains constant.
- **Succession plans:** In case of a repository shutdown, our best efforts will
  be made to integrate all content into suitable alternative institutional and/or
  other repositories overlapping in the scope of the DANDI archive.

This policy document is derived from the [Zenodo General Policies v1.0](https://about.zenodo.org/policies/).
