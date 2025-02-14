Data management including upload, download, and validation is handled through a local DANDI Client.  
The DANDI Client provides both a command line interface (CLI) and Python API.

## Update the DANDI Client to reference your API

To reference your DANDI-clone API, [update the URLs reference per each CLI action](https://github.com/dandi/dandi-cli/blob/15196a93310618f8897c7b43444e216bbb094549/dandi/consts.py#L119-L135) and push a PR to the [dandi-cli GitHub repository](https://github.com/dandi/dandi-cli).

Here is an example PR of another clone adding to the available instances of `DandiInstance` objects in `dandi-cli`: [see here](https://github.com/dandi/dandi-cli/pull/1527)

For example:

```python
known_instances = {
    "dandi": DandiInstance(
        "dandi",
        "https://dandiarchive.org",
        "https://api.dandiarchive.org/api",
    ),
    "dandi-staging": DandiInstance(
        "dandi-staging",
        "https://gui-staging.<your-domain>.org",
        "https://api-staging.<your-domain>.org/api",
    ),
    "dandi-api-local-docker-tests": DandiInstance(
        "dandi-api-local-docker-tests",
        f"http://{instancehost}:8085",
        f"http://{instancehost}:8000/api",
    ),
    "<your-dandi-clone>": DandiInstance( # Your own "dandi"
        "<your-dandi-clone>", # Your own "dandi"
        "https://<your-dandi-clone-domain>.org", 
        "https://api.<your-dandi-clone-domain>.org/api", 
    ),
}
```

Once your DANDI clone is added to the list of available `DandiInstance` objects, you should be able to perform operations via the `-i` flag.  For example:

`dandi upload -i <your-dandi-clone>`

## Access credentials

Users will be prompted for a `DANDI_API_KEY`
environment variable.  This variable does not need to be unique to your DANDI clone.  A user can just set their `DANDI_API_KEY` to the value that your DANDI API clone issues.  See docs on [storing access credentials](https://www.dandiarchive.org/handbook/13_upload/#storing-access-credentials).

## Handling Versioning

DANDI CLI leverages a tool called [versioneer](https://pypi.org/project/versioneer/) for semantic versioning in PyPI.

Upon merging of a PR into `main`, if a given GitHub label is attached to the PR (`major`, `minor` or `patch` specifically)
`versioneer` will generate a human-readable CHANGELOG entry, and then push to PyPI the proper new semantic version.

### Versioning-Realted Resources
- [PyPI package](https://pypi.org/project/dandi/)
- [Source code](https://github.com/dandi/dandi-cli)
- [Developer instructions](https://github.com/dandi/dandi-cli/blob/master/DEVELOPMENT.md)




