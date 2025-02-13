# Integrating DANDI Metadata Models Across the Ecosystem

**DANDI metadata models** are defined as 
[Pydantic models](https://github.com/dandi/dandi-schema/blob/master/dandischema/models.py)
in [**dandischema**](https://github.com/dandi/dandi-schema) and transformed into 
[JSON schemas](https://github.com/dandi/schema). **Both** representations, 
the original Pydantic definitions and JSON schemas, are used across the DANDI ecosystem. 
The diagram below outlines how these two representations are integrated into various 
components, including the CLI, the backend/API, and the web interface.

For more information, follow the links in the diagram to the respective repositories and files.


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