# Advanced Search

The dandiset list's search box accepts a Gmail/GitHub-style syntax that lets you mix
free-text terms with structured `key:value` operators. Filter by creation date,
species, file type, contributor, role, owner, and more — all from the same input.

## Quick examples

```
neuropixels species:mouse created_after:2023-01-01
author:"Doe, Jane" funder:NIH
data_curator:"Smith, Alice" published_after:2024-01-01
contributor:0000-0002-2990-9889 standard:nwb
affiliation:Stanford
```

Operators combine with AND. Quoted phrases (`"like this"`) are treated as a single
value. Anything you type without a `key:` prefix is full-text matched against the
dandiset metadata, the same way the original search box worked.

---

## How operators combine

- **Operators describe the dandiset**, not individual assets. Each operator is
  an independent constraint at the dandiset level. `species:mouse species:rat`
  returns dandisets that have at least one mouse asset AND at least one rat
  asset — they can be the same asset (multi-species recording) or two
  different assets (a comparative-species dandiset).
- **Free text + operators**: ANDed together. `place cells species:mouse`
  returns dandisets whose metadata contains "place" AND "cells" AND has at
  least one mouse asset.
- **Multiple different operators**: ANDed at the dandiset level. `author:Doe
  funder:NIH` returns dandisets where someone named Doe is an Author *and*
  someone named NIH is a Funder. They can be different contributor entries.
  `species:mouse approach:electrophysiological` returns dandisets that have
  some mouse data AND some electrophysiology data — possibly on different
  assets, possibly on the same one.
- **Quoting**: wrap multi-word values in double quotes, e.g.
  `technique:"spike sorting"`. A whole token wrapped in quotes opts out of
  operator parsing — `"author:Doe"` searches for the literal text `author:Doe`
  rather than running the operator.

---

## Operator reference

### Dates

All take an ISO date in the form `YYYY-MM-DD`. Bounds are exclusive on
`_before` and inclusive on `_after`.

| Operator | What it filters |
|---|---|
| `created_before:YYYY-MM-DD` | Dandiset's `created` timestamp before the date |
| `created_after:YYYY-MM-DD` | Dandiset's `created` timestamp on/after the date |
| `modified_before:YYYY-MM-DD` | Most recent version's `modified` timestamp before the date |
| `modified_after:YYYY-MM-DD` | Most recent version's `modified` timestamp on/after the date |
| `published_before:YYYY-MM-DD` | Most recent **published** version's `created` timestamp before the date (draft-only dandisets are excluded) |
| `published_after:YYYY-MM-DD` | Most recent **published** version's `created` timestamp on/after the date |

```
created_after:2024-01-01                    # everything created since 2024
modified_after:2025-01-01 modified_before:2026-01-01   # changed during 2025
published_after:2023-01-01                  # published since 2023
```

### Asset content

Substring matches (case-insensitive) against the dandiset's asset metadata.
A dandiset matches if at least one of its assets satisfies the predicate.
Multiple asset operators are AND'd at the dandiset level — each must be
satisfied by *some* asset, but not necessarily the same one. See
[How operators combine](#how-operators-combine) above.

| Operator | What it matches |
|---|---|
| `species:VALUE` | Substring against any `wasAttributedTo[].species.name` |
| `approach:VALUE` | Substring against any `approach[].name` |
| `technique:VALUE` | Substring against any `measurementTechnique[].name` |
| `standard:VALUE` | Substring against any `dataStandard[].name` |
| `file_type:VALUE` | `encodingFormat` startswith. Accepts the aliases `nwb`, `image`, `text`, `video`, or any MIME prefix (`application/x-nwb`, `image/`, ...) |

```
species:mouse                          # House mouse, Mus musculus, etc.
species:"Mus musculus"                 # exact-ish phrase match
approach:electrophysiological          # any contributor's approach contains this
technique:"spike sorting"
standard:nwb
file_type:image                        # → image/* mime types
file_type:application/x-nwb            # explicit MIME prefix
```

### Owner

| Operator | What it matches |
|---|---|
| `owner:VALUE` | Dandisets owned by users matching `VALUE` (case-insensitive) against `username`, `email`, `first_name`, `last_name`, or `"first_name last_name"` |

```
owner:alice
owner:alice@example.com
owner:Smith                            # any user named Smith
owner:"Jane Doe"                       # full display name
```

If a name matches multiple users (e.g. two Smiths), dandisets owned by **any**
of them are returned.

### Contributors

The contributor operators search the dandiset's `metadata.contributor[]` list
(the same data shown in the "Contributors" section on the landing page). Each
operator matches a contributor by **name**, **email**, OR **identifier** —
which means ORCID for Person contributors (`0000-0002-2990-9889`) and ROR URL
for Organization contributors (`https://ror.org/01cwqze88`) both work. Bare-ID
substrings (`01cwqze88`) match the full URL.

| Operator | Role constraint |
|---|---|
| `contributor:VALUE` | Any role (catch-all) |
| `author:VALUE` | Must hold the `Author` role |
| `contact_person:VALUE` | Must hold the `ContactPerson` role |
| `data_collector:VALUE` | Must hold the `DataCollector` role |
| `data_curator:VALUE` | Must hold the `DataCurator` role |
| `data_manager:VALUE` | Must hold the `DataManager` role |
| `maintainer:VALUE` | Must hold the `Maintainer` role |
| `project_leader:VALUE` | Must hold the `ProjectLeader` role |
| `funder:VALUE` | Must hold the `Funder` role |
| `sponsor:VALUE` | Must hold the `Sponsor` role |

```
contributor:"Doe, Jane"                # any role
author:Doe                             # Doe specifically as an Author
data_curator:0000-0002-2990-9889       # this ORCID, must be a DataCurator
funder:NIH                             # NIH (or any string containing NIH) as Funder
funder:01cwqze88                       # by ROR id
author:Doe funder:NIH                  # both must hold (possibly different people)
```

The role-restricting operators map to the [DANDI schema's `RoleType`](https://github.com/dandi/schema/blob/master/dandischema/models.py)
values. The catch-all `contributor:` covers any other role
(Conceptualization, Researcher, etc.); for those, filter by name and use the
landing page to check the specific role.

### Affiliation

`affiliation` is special — affiliations live in a *nested* field
(`contributor[].affiliation[]`), not as a role on the contributor itself. The
operator queries that path:

| Operator | What it matches |
|---|---|
| `affiliation:VALUE` | Substring against any contributor's affiliation `name` OR `identifier` (ROR URL) |

```
affiliation:Stanford                       # any contributor affiliated with Stanford
affiliation:"University College London"
affiliation:00f54p054                      # Stanford's ROR id (substring of the URL)
author:Doe affiliation:Stanford            # Doe as author AND someone Stanford-affiliated
```

---

## Recipes

**Find recent NWB dandisets from a particular lab.**
```
file_type:nwb affiliation:"University College London" published_after:2024-01-01
```

**Find dandisets where I'm the contact person.**
```
contact_person:"My Name"
```

**Find dandisets funded by NIH with mouse data.**
```
funder:NIH species:mouse
```

**Find dandisets that cite a particular ORCID as an author.**
```
author:0000-0002-2990-9889
```

**Find your own dandisets in the listing.**
```
owner:"Your Name"
```
(Or use the **My Dandisets** tab if you're signed in — it's the same set.)

---

## Quoting rules

- Wrap a multi-word **value** in double quotes:
  `technique:"spike sorting"`, `contributor:"Doe, Jane"`,
  `affiliation:"Cold Spring Harbor Laboratory"`.
- Wrap a whole **token** in double quotes to opt out of operator parsing —
  useful when the text you're searching for contains a colon:
  `"foo:bar"` searches for the literal text `foo:bar`.
- Unbalanced quotes return a 400 with a friendly error message.

---

## Error messages

Invalid syntax doesn't fail silently. Common cases:

| What you type | What you get back |
|---|---|
| `specie:mouse` | 400 — `Unknown search operator "specie". Did you mean "species"?` |
| `data_curatr:Doe` | 400 — `Did you mean "data_curator"?` |
| `created_after:not-a-date` | 400 — `Invalid date for "created_after"; Use YYYY-MM-DD.` |
| `hello "world` | 400 — `Unbalanced quote in search query. Remove the stray quote...` |
| `owner:` (empty value) | 400 — `Operator "owner" requires a value` |

Typo suggestions are produced by [`difflib.get_close_matches`](https://docs.python.org/3/library/difflib.html#difflib.get_close_matches);
they're a hint, not authoritative.

---

## Using from the API

The same syntax works against the REST API — the search string lives in the
`?search=` query parameter on `/api/dandisets/`:

```bash
curl 'https://api.dandiarchive.org/api/dandisets/?search=species:mouse+author:Doe'
```

```python
import requests
r = requests.get(
    'https://api.dandiarchive.org/api/dandisets/',
    params={'search': 'species:mouse author:Doe', 'draft': 'true', 'empty': 'true'},
)
r.json()
```

The OpenAPI description on `/swagger/` lists every operator inline.

---

## Limitations and notes

- **Substring, case-insensitive.** `species:mouse` matches `House mouse`,
  `Mus musculus`, etc. There's no exact-match mode at the moment — use a longer
  substring to narrow.
- **No OR or NOT.** Operators always combine with AND. To express OR, run two
  queries (or wait for a future revision; see below).
- **No nesting.** `(species:mouse OR species:rat)` and similar grammar isn't
  supported.
- **AND combines at the dandiset level for assets and contributors.** Each
  asset operator filters dandisets independently — different operators may
  match different assets within the same dandiset. Contributor operators
  combine on the *same* version's contributor list (so a draft + published
  version with disjoint contributors don't combine into a spurious match);
  within that single version, different contributor operators may match
  different entries of `contributor[]`.
- **`?user=me`** (an existing query parameter) still works for "my dandisets";
  there's no `owner:me` magic alias in the operator syntax.
- **Free-text and operators combine.** The same `?search=` parameter accepts
  both, so you don't need a different endpoint depending on whether you have
  operators.
