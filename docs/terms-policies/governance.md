# DANDI Archive Project Governance

Version: 1.0  
Effective Date: YYYY-MM-DD  
Status: Draft

## 1. Purpose

This document defines the governance structure, roles, responsibilities, and decision‑making processes for the DANDI Archive ecosystem. It applies uniformly to all current and future repositories and services, including:

Sites:

- https://dandiarchive.org
- https://hub.dandiarchive.org
- https://about.dandiarchive.org

Code git repositories:

- https://github.com/dandi

Data git/git-annex repositories:

- https://github.com/dandisets
- https://github.com/dandizarrs

## 2. Mission

DANDI (Distributed Archives for Neurophysiology Data Integration) enables FAIR (Findable, Accessible, Interoperable, Reusable) publishing, preservation, discovery, and computational reuse of neurophysiology data.  DANDI provides:

- A cloud-based platform to store, process, and disseminate data. You can use DANDI to collaborate and publish datasets.
- Open access to data to enable secondary uses of data outside the intent of the study.
- Optimize data storage and access through partnerships, compression and accessibility technologies.
- Enables reproducible practices and publications through data standards such as NWB and BIDS.
- The platform is not just an endpoint to dump data, it is intended as a living repository that enables collaboration within and across labs.

## 3. Core Principles

1. Openness & Transparency: Designs, discussions, and decisions are public by default
2. FAIR & Reproducibility: Data and code evolution remain traceable and citable
3. Sustainability: Architectural and process decisions consider long-term maintainability
4. Inclusivity & Respect: Guided by a Code of Conduct
5. Stewardship: Authority derives from consistent, high‑quality contribution
6. Accountability: Roles carry explicit responsibilities
7. Security & Privacy: Responsible handling of sensitive data and credentials

## 4. Project Structure

| Domain | Primary Repos |
|--------|------------------------------|
| Archive | [dandi-archive](https://github.com/dandi/dandi-archive), [dandi-infrastructure](https://github.com/dandi/dandi-infrastructure) |
| Client | [dandi-cli](https://github.com/dandi/dandi-cli), [dandidav](https://github.com/dandi/dandidav) |
| Metadata | [dandi-schema](https://github.com/dandi/dandi-schema), [schema](https://github.com/dandi/schema) |
| JupterHub | [dandi-hub](https://github.com/dandi/dandi-hub), [nebari](https://github.com/dandi/nebari), [nebari-deployments](https://github.com/dandi/nebari-deployments), [nebari-docker-images](https://github.com/dandi/nebari-docker-images) |
| Documentation & Support | [dandi-docs](https://github.com/dandi/dandi-docs), [dandi-about](https://github.com/dandi/dandi-about), [helpdesk](https://github.com/dandi/helpdesk) |

## 5. Roles & Responsibilities

### 5.1 Contributors
Anyone submitting issues, pull requests, documentation, or feedback.  
Responsibilities:
- Follow Code of Conduct and contribution guidelines
- Provide context and reproducible steps
- Where applicable, write tests and documentation for code changes

### 5.2 Reviewers
Contributors granted reviewer status for designated repositories.  

Responsibilities:
- Perform timely, constructive reviews
- Enforce style, testing, and security practices
- Identify architectural and performance impacts
Path to role:
- Consistent high‑quality reviews
- Sponsored by at least one Maintainer

### 5.3 Maintainers
Individuals with merge rights for designated repositories.  
Responsibilities:
- Final merge approval
- Release planning and tagging
- Triage (labels, prioritization, assignment)
- Manage vulnerability reports
- Escalate policy or security concerns
- Facilitate cross‑repository alignment
- Onboard and mentor reviewers
Expectations:
- Active presence
- Adhere to conflict of interest and bias avoidance
Path to role:
- Demonstrated sustained contributions and review quality
- Nomination and consensus of existing repository Maintainers

Maintainers for the respective DANDI repositories:
| Repository | Maintainers |
| -- | -- |
| [dandi/dandi-archive](https://github.com/dandi/dandi-archive) | [@dandi/archive-maintainers](https://github.com/orgs/dandi/teams/archive-maintainers) |
| [dandi/dandi-infrastructure](https://github.com/dandi/dandi-infrastructure) | [@dandi/archive-admin](https://github.com/orgs/dandi/teams/archive-admin) |
| [dandi/dandi-cli](https://github.com/dandi/dandi-cli) | [@dandi/dandi-cli-maintainers](https://github.com/orgs/dandi/teams/dandi-cli-maintainers) |
| [dandi/dandi-schema](https://github.com/dandi/dandi-schema) | [@dandi/dandi-schema-maintainers](https://github.com/orgs/dandi/teams/dandi-schema-maintainers) |
| [dandi/dandi-hub](https://github.com/dandi/dandi-hub) | [@dandi/dandi-hub-maintainers](https://github.com/orgs/dandi/teams/dandi-hub-maintainers) |
| [dandi/nebari-deployments](https://github.com/dandi/nebari-deployments) (Private) | [@dandi/dandi-hub-maintainers](https://github.com/orgs/dandi/teams/dandi-hub-maintainers) |
| [dandi/nebari](https://github.com/dandi/nebari) | [@dandi/dandi-hub-maintainers](https://github.com/orgs/dandi/teams/dandi-hub-maintainers) |
| [dandi/dandidav](https://github.com/dandi/dandidav) | [@dandi/dandi-dav-maintainers](https://github.com/orgs/dandi/teams/dandi-dav-maintainers) |
| [dandi/dandi-about](https://github.com/dandi/dandi-about) | [@dandi/dandi-docs-maintainers](https://github.com/orgs/dandi/teams/dandi-docs-maintainers) |
| [dandi/dandi-docs](https://github.com/dandi/dandi-docs) | [@dandi/dandi-docs-maintainers](https://github.com/orgs/dandi/teams/dandi-docs-maintainers) |
| [dandi/example-notebooks](https://github.com/dandi/example-notebooks) | [@dandi/dandi-docs-maintainers](https://github.com/orgs/dandi/teams/dandi-docs-maintainers) |

### 5.4 Project Leadership
- Current leadership team:
    - [Satrajit Ghosh](https://satra.cogitatum.org/) ([@satra](https://github.com/satra))
    - [Yaroslav O. Halchenko](https://centerforopenneuroscience.org/whoweare) ([@yarikoptic](https://github.com/yarikoptic))
- Responsibilities:
    - Approve or amend governance document and Code of Conduct
    - Strategic project oversight
    - Resolve escalated disputes
    - Approve major architectural shifts
    - Oversee risk, sustainability, funding alignment

## 6. Decision-Making Model

### 6.1 Roadmap
- Project targets are discussed during the biweekly Engineering Core and Scientific Core meetings.
- Project Leadership provides guidance on prioritization of targets.
- Public notes of these meetings are available on [Google Drive](https://drive.google.com/drive/folders/1-jXLpcrh3L650FiZyTFgcs096nZjO2C3).

### 6.2 Consensus Process
1. Open a GitHub issue describing the bug/feature request, context, and possible solutions.
2. For major architectural changes, create a design document and submit as a PR for discussion and refinement.
   For reference, see [previous design documents](https://github.com/dandi/dandi-archive/tree/master/doc).
3. Collect feedback during a 7 day review period.
4. Summarize consensus in the GitHub issue and resolve all suggestions in the design document.
5. Implement via pull request(s) referencing the proposed design.

### 6.3 Conflict of Interest
- Participants should disclose direct commercial interest in a technology choice.
- Conflicted member recuses oneself from final decision phase.

## 7. Pull Request Workflow

### 7.1 Pull Request Requirements
- Link the associated issue
- Add a clear description (problem, approach, alternatives considered)
- Major architectural changes require a design document
- Add or update tests
- Update documentation
- Ensure CI passes
- Large pull requests should be split unless justified
- No introduction of unreviewed secrets or credentials
- Verified provenance for large binary additions (discouraged in code repos)

### 7.2 Merge Policy
- All pull requests require:
    - All comments must be resolved or addressed
    - Approval by at least 1 listed Maintainer for that repository
    - 24 hour waiting period (unless addressing a critical issue)
- See section below regarding updates to the Governance document

### 7.3 Draft vs Ready for Review
- Open as a Draft for early feedback
- Convert to “Ready” only when tests and documentation are updated

### 7.4 Reverts
- Any Maintainer may revert a merged pull request causing regression, security issue, or service degradation, with immediate notice in original pull request thread.
- Follow-up issue required to track remediation

## 8. Releases

### 8.1 Versioning
- [Semantic Versioning 2.0](https://semver.org/spec/v2.0.0.html) for APIs and libraries

### 8.2 Release Steps
- For [dandi-archive](https://github.com/dandi/dandi-archive), once a pull request is merged the changes are deployed to the sandbox environment (https://sandbox.dandiarchive.org) for review and testing prior to release.
- New releases are created with a GitHub Actions workflow built around [`auto`](https://github.com/intuit/auto).
- When a pull request is merged that has the "`release`" label, `auto`:
    - Updates the changelog based on the pull requests since the last release and commits the results
    - Tags the new commit with the next version number
    - Creates a GitHub release for the tag
- For [dandi-cli](https://github.com/dandi/dandi-cli), upon release a new version is published to PyPI

## 9. Security

### 9.1 Reporting
- Security reports via help@dandiarchive.org
- Acknowledge within 48 hours

### 9.2 Handling
- Initial assessment within 5 business days
- Coordinate and address issue within 30 days
- User advisory via email when appropriate

### 9.3 Hardening Practices
- Mandatory dependency scanning
- Principle of least privilege enforced for service accounts

## 10. Documentation

- User and developer documentation is available at https://docs.dandiarchive.org
- Design documents for major decisions are available at https://github.com/dandi/dandi-archive/tree/master/doc
- DEVELOPMENT.md and CODE_OF_CONDUCT.md are maintained in relevant repositories

## 11. Communication

Communication channels include:

- GitHub Issues and Discussions for user support and team discussions
  - https://github.com/dandi/helpdesk for generic support requests and questions
  - individual repositories for targeted discussions
- Slack for user support and team discussions
- Email (info@dandiarchive.org, help@dandiarchive.org) for user support
- Email announcements for critical notifications to users
- GitHub Releases for release announcements
- Email newsletter to highlight major changes

## 12. Community

- Outreach events are hosted in collaboration with the Neurodata Without Borders team and can be found at https://nwb.org/events
- Code of Conduct is available at https://github.com/dandi/dandi-archive/blob/master/CODE_OF_CONDUCT.md
    - Instances of Code of Conduct violation can be reported to  community@dandiarchive.org
    - Enforcement of Code of Conduct is separate from primary technical decision flow where possible

## 13. Amendments to Project Governance

Process

1. Proposal pull request
2. Minimum of a 30 day public comment
3. Approval by Project Leadership
4. Update version and effective data in Governance document header

- Urgent amendments may use an accelerated 7 day window with rationale documented.
- The document becomes active upon Project Leadership approval and publication in the [DANDI Docs](https://docs.dandiarchive.org/).

## 14. Sunset Policy

If a component becomes unmaintained:
- Create a plan with guidance from the Project Leadership
- Update documentation to reflect deprecation including migration guidance
- Mark repository with `ARCHIVED` notice

## 15. Licenses

- Licenses (for code, artwork, documentation) are declared per repository
- Licenses must be [DFSG](https://www.debian.org/social_contract#guidelines) and [OSI](https://opensource.org/licenses) compliant
