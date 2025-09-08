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

Code repositories:
- https://github.com/dandi
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
- Escalate policy or security concerns
- Facilitate cross‑repository alignment
- Onboard and mentor reviewers
Expectations:
- Active presence
- Adhere to conflict of interest and bias avoidance
Path to role:
- Demonstrated sustained contributions and review quality
- Nomination and consensus of existing repository Maintainers

### 5.4 Project Leadership
- Current leadership team:
    - Satrajit Ghosh
    - Yaroslav O. Halchenko
- Responsibilities:
    - Approve or amend governance document and Code of Conduct
    - Strategic project oversight
    - Resolve escalated disputes
    - Approve major architectural shifts
    - Oversee risk, sustainability, funding alignment

## 12. Amendments to Project Governance

Process
1. Proposal pull request
2. Minimum of a 30 day public comment
3. Approval by Project Leadership
4. Update version and effective data in Governance document header

- Urgent amendments may use an accelerated 7 day window with rationale documented.
- The document becomes active upon Project Leadership approval and publication in the [DANDI Docs](https://docs.dandiarchive.org/).

