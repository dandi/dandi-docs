# Integrate External Services with DANDI

This page provides guidance on how to integrate external services with the DANDI Archive, including how to work with DANDI metadata models and APIs.

## DANDI Metadata Models Integration

**DANDI metadata models** are defined as 
[Pydantic models](https://github.com/dandi/dandi-schema/blob/master/dandischema/models.py)
in [**dandischema**](https://github.com/dandi/dandi-schema) and transformed into 
[JSON schemas](https://github.com/dandi/schema). **Both** representations, 
the original Pydantic definitions and JSON schemas, are used across the DANDI ecosystem. 
The diagram below outlines how these two representations are integrated into various 
components, including the CLI, the backend/API, and the web interface.

``` mermaid
---
config:
  layout: dagre
---
flowchart TD
    subgraph subGraph0["<a href=https://github.com/dandi/dandi-schema>dandi/dandischema</a>"]
        dandi_pydantic@{ label: "<a href=\"https://github.com/dandi/dandi-schema/blob/master/dandischema/models.py\">dandi/dandischema::models.py</a><br>(Pydantic models)" }
        dandi_validate@{ label: "<a href=\"https://github.com/dandi/dandi-schema/blob/c3007768e002c9f51ea37b5e6b3628f7f7f20943/dandischema/metadata.py#L195\">dandi/dandischema::validate()</a><br>(Validation helper)" }
        dandi_json_runtime["Latest JSON Schema models"]
    end
    subgraph subGraph1["<a href=https://github.com/dandi/dandi-archive>dandi/dandi-archive</a>"]
        dandi_archive_db[("PostgresDB")]
        dandi_archive_backend@{ label: "<a href=\"https://api.dandiarchive.org\">api.dandiarchive.org</a><br>(Backend/API)" }
        dandi_archive_frontend@{ label: "<a href=\"https://www.dandiarchive.org\">www.dandiarchive.org</a><br>(Frontend/Web UI)" }
        meditor["Meditor<br>(vjsf-based web form)"]
        dandi_archive_validate[/"Celery task to validate<br>dandiset and asset metadata"/]
    end

    %% nodes
    dandi_cli@{ label: "<a href=\"https://github.com/dandi/dandi-cli\">dandi-cli</a><br>(Python client lib and CLI)" }
    ci@{ label: "<a href=\"https://github.com/dandi/dandi-schema/blob/master/.github/workflows/release.yml\">GitHub CI</a>" }
    dandi_json@{ label: "<a href=\"https://github.com/dandi/schema\">dandi/schema</a><br>(Versions of JSON Schema models)" }

    %% edges
    dandi_pydantic -- Used by --> dandi_cli & dandi_validate & ci
    dandi_pydantic -- Used for generating --> dandi_json_runtime
    dandi_json_runtime -- Used by --> dandi_validate
    ci -- Generates<br> JSON Schema models<br> per model release --> dandi_json
    dandi_json -- Used by (for any versions) --> dandi_validate
    dandi_json -- Used by --> dandi_archive_frontend
    dandi_validate -- Used by --> dandi_archive_validate
    dandi_archive_backend -- Schedules --> dandi_archive_validate
    dandi_archive_backend <---> dandi_archive_db
    dandi_cli -- Extracts and uploads<br>metadata for assets --> dandi_archive_backend
    dandi_archive_frontend -- Generates --> meditor
    web_input["User input through web form"] -- Restricted by --> meditor
    meditor -- Stores user inputs through --> dandi_archive_backend
    dandi_archive_validate -- Records validation status --> dandi_archive_db

    %% styles
    dandi_json@{ shape: docs}
    dandi_cli@{ shape: rect}
    ci@{ shape: rect}
    web_input@{ shape: manual-input}
    dandi_pydantic@{ shape: rect}
    dandi_validate@{ shape: rect}
    dandi_json_runtime@{ shape: doc}
    dandi_archive_backend@{ shape: rect}
    dandi_archive_frontend@{ shape: rect}
```

## Integration Methods

There are several ways to integrate external services with DANDI:

### 1. REST API Integration

The DANDI Archive provides a comprehensive REST API that allows external services to interact with the archive programmatically. The API documentation is available at:

- [Swagger UI](https://api.dandiarchive.org/swagger)
- [ReDoc](https://api.dandiarchive.org/redoc)

Key API endpoints include:

- `/api/dandisets/`: List and search Dandisets
- `/api/dandisets/{dandiset_id}/versions/{version_id}/`: Get specific Dandiset version
- `/api/dandisets/{dandiset_id}/versions/{version_id}/assets/`: List assets in a Dandiset
- `/api/dandisets/{dandiset_id}/versions/{version_id}/assets/{asset_id}/`: Get specific asset

Authentication is required for write operations and is handled via API keys. Read operations on public data do not require authentication.

### 2. Python Client Integration

For Python applications, the [DANDI Python client](https://github.com/dandi/dandi-cli) provides a convenient way to interact with the DANDI Archive:

```python
from dandi.dandiapi import DandiAPIClient

# Initialize client
client = DandiAPIClient()

# Get a specific Dandiset
dandiset = client.get_dandiset("000123", "draft")

# List assets
assets = list(dandiset.get_assets())

# Get a specific asset
asset = dandiset.get_asset_by_path("path/to/file.nwb")

# Download an asset
asset.download("local_file.nwb")
```

### 3. WebDAV Integration

DANDI provides a [WebDAV](https://en.wikipedia.org/wiki/WebDAV) service at https://webdav.dandiarchive.org/ that allows external services to access DANDI data using standard WebDAV clients:

```python
import requests

# Access a file via WebDAV
response = requests.get("https://webdav.dandiarchive.org/dandisets/000123/draft/path/to/file.nwb")
```

### 4. Custom Visualization Services

To integrate a custom visualization service with DANDI:

1. Create a service that can accept a URL to an NWB file
2. Register your service with the DANDI team
3. DANDI will add a link to your service next to compatible files in the web interface

For example, NWB Explorer is integrated this way, allowing users to visualize NWB files directly from the DANDI web interface.

## Getting Help

If you need assistance integrating your service with DANDI, you can:

1. Open an issue on the [DANDI helpdesk](https://github.com/dandi/helpdesk/issues)
2. Contact the DANDI team at help@dandiarchive.org
3. Join the DANDI Slack workspace (available to registered DANDI users)
