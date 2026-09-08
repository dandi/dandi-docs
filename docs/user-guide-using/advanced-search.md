# Advanced Search

The Dandiset list's search box accepts a Gmail-style syntax that lets you mix free-text
terms with structured `key:value` operators, so you can filter by creation date, species,
approach, measurement technique, and owner from the same input.

## Example

```
neuropixels species:mouse created_after:2022-01-01 approach:electrophysiological published_after:2022-01-01 modified_after:2022-01-01 modified_before:2026-01-01 technique:"multi electrode extracellular electrophysiology recording" owner:"Jerome Lecoq"
```

That query mixes free text with every kind of operator: date bounds, the three
asset-summary operators, and `owner`. At the time of writing it returns two Dandisets,
000253 and 000563. [Run it in the Archive](https://dandiarchive.org/dandiset/search?search=neuropixels+species:mouse+created_after:2022-01-01+approach:electrophysiological+published_after:2022-01-01+modified_after:2022-01-01+modified_before:2026-01-01+technique:%22multi+electrode+extracellular+electrophysiology+recording%22+owner:%22Jerome+Lecoq%22).

Operators combine with AND. Quoted phrases (`"like this"`) are treated as a single value.
Anything you type without a `key:` prefix is full-text matched against the Dandiset
metadata, the same way the search box worked before operators existed.

When you start typing an operator name, the search box offers an autocomplete dropdown of
the available operators. The question-mark icon at the right edge of the box opens a help
popover listing them with examples.

## How Operators Combine

Operators describe the Dandiset, not individual assets. Each operator is an independent
constraint at the Dandiset level. `species:mouse species:rat` returns Dandisets whose
asset summary lists both mouse and rat.

Free text and operators are ANDed together. `place cells species:mouse` returns Dandisets
whose metadata contains "place" and "cells" and whose asset summary includes mouse.

Multiple different operators are also ANDed. `species:mouse approach:electrophysiological`
returns Dandisets that have some mouse data and some electrophysiology data, possibly
described by different entries in the summary.

To use a multi-word value, wrap it in double quotes, e.g. `technique:"spike sorting"`.
Wrapping a whole token in quotes opts out of operator parsing, so `"species:mouse"`
searches for the literal text `species:mouse` rather than running the operator.

## Operator Reference

### Dates

All date operators take an ISO date in the form `YYYY-MM-DD`. The `_before` bound is
exclusive and the `_after` bound is inclusive.

| Operator | What it filters |
|---|---|
| `created_before:YYYY-MM-DD` | Dandiset's `created` timestamp before the date |
| `created_after:YYYY-MM-DD` | Dandiset's `created` timestamp on or after the date |
| `modified_before:YYYY-MM-DD` | Most recent version's `modified` timestamp before the date |
| `modified_after:YYYY-MM-DD` | Most recent version's `modified` timestamp on or after the date |
| `published_before:YYYY-MM-DD` | Most recent published version's `created` timestamp before the date (draft-only Dandisets are excluded) |
| `published_after:YYYY-MM-DD` | Most recent published version's `created` timestamp on or after the date |

```
created_after:2024-01-01                                # everything created since 2024
modified_after:2025-01-01 modified_before:2026-01-01    # changed during 2025
published_after:2023-01-01                              # published since 2023
```

### Asset Summary

These operators match case-insensitive substrings against the summary of a Dandiset
version's assets (`assetsSummary` in the version metadata), which is the same information
shown in the overview on a Dandiset's landing page.

| Operator | What it matches |
|---|---|
| `species:VALUE` | Any `assetsSummary.species[].name` |
| `approach:VALUE` | Any `assetsSummary.approach[].name` |
| `technique:VALUE` | Any `assetsSummary.measurementTechnique[].name` |

```
species:mouse                          # House mouse, Mus musculus, and so on
species:"Mus musculus"                 # narrower phrase match
approach:electrophysiological
technique:"spike sorting"
```

When several of these operators appear in one query, they must all be satisfied by the
same Dandiset version, so a draft version and a published version with different summaries
do not combine into a spurious match.

### Owner

`owner:VALUE` restricts the results to Dandisets owned by a matching user. `VALUE` is
matched case-insensitively against the owner's GitHub username, email address, first name,
last name, or full name in `"first last"` form.

```
owner:alice
owner:alice@example.com
owner:Smith                            # any user named Smith
owner:"Jane Doe"                       # full display name
```

If a name matches multiple users, for example two people named Smith, Dandisets owned by
any of them are returned.

## Error Messages

Invalid syntax does not fail silently. The common cases are:

| What you type | What you get back |
|---|---|
| `specie:mouse` | 400: `Unknown search operator "specie". Did you mean "species"? Wrap the term in double quotes (e.g. "foo:bar") to search for it as text.` |
| `created_after:not-a-date` | 400: `Invalid date for "created_after": 'not-a-date'. Use YYYY-MM-DD.` |
| `hello "world` | 400: `Unbalanced quote in search query. Remove the stray quote, or wrap the intended phrase in matched quotes.` |
| `owner:` (empty value) | 400: `Operator "owner" requires a value (e.g. owner:something).` |

Typo suggestions come from
[`difflib.get_close_matches`](https://docs.python.org/3/library/difflib.html#difflib.get_close_matches),
so treat them as a hint rather than as authoritative.

Search queries are capped at 1024 characters, which is well above any reasonable
interactive query.

## Using the Syntax From the API

The same syntax works against the REST API. The search string goes in the `?search=` query
parameter on `/api/dandisets/`:

```bash
curl --get 'https://api.dandiarchive.org/api/dandisets/' \
  --data-urlencode 'search=neuropixels species:mouse created_after:2022-01-01 approach:electrophysiological published_after:2022-01-01 modified_after:2022-01-01 modified_before:2026-01-01 technique:"multi electrode extracellular electrophysiology recording" owner:"Jerome Lecoq"'
```

```python
import requests

query = (
    'neuropixels species:mouse created_after:2022-01-01 '
    'approach:electrophysiological published_after:2022-01-01 '
    'modified_after:2022-01-01 modified_before:2026-01-01 '
    'technique:"multi electrode extracellular electrophysiology recording" '
    'owner:"Jerome Lecoq"'
)
r = requests.get(
    'https://api.dandiarchive.org/api/dandisets/',
    params={'search': query, 'draft': 'true', 'empty': 'true'},
)
r.json()
```

The OpenAPI description at [https://api.dandiarchive.org/swagger/](https://api.dandiarchive.org/swagger/)
lists every operator inline.

## Limitations and Notes

Matching is by case-insensitive substring. `species:mouse` matches `House mouse`,
`Mus musculus`, and anything else containing the substring. There is no exact-match mode
at the moment, so use a longer substring to narrow the result.

Operators always combine with AND. There is no OR or NOT, and no grammar for nesting, so
`(species:mouse OR species:rat)` is not supported. To express OR, run two queries.

The existing `?user=me` query parameter still works for "my Dandisets". There is no
`owner:me` alias in the operator syntax.
