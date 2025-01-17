# DANDI Docs
Documentation for interacting with the DANDI Archive.

## DANDI Style Guidelines

Follow the guidelines below when creating and revising text in the DANDI Docs:

*	**dandi-** repositories — hyphenate the names of DANDI GitHub repositories (e.g. **dandi-archive**); "Dandisets" is an exception because it is a
complete word
*	**Dandiset**  — use single, unformatted, capitalized word (**not** dandiset or `Dandiset`)
*	file names — use lower case (e.g. **development.md**)
*	headings — use Title Capitalization (for 1st and 2nd levels) and follow with an intro sentence
*	**GitHub** — use camel case (**not** github or Github)
*	instructional language — should be direct, imperative, active, straightforward (e.g. "Install the files in your Python environment", *not* "Files could be installed in your Python environment")
*	**JupyterHub** — use camel case (**not** Jupyterhub)
*	**license** (**not** licence); in general, prefer American spelling
*	limited use of "please"
*	steps should start with 1, not 0
*	**DANDI Archive** - capitalize "archive" if it follows DANDI (**not** DANDI archive)

## HOWTO

The DANDI Docs uses [mkdocs](https://www.mkdocs.org/) to render the documentation written as a collection of markdown files into a website.
If you would like to render it locally, you would need to create and configure a python environment according to configuration provided in [requirements.txt](./requirements.txt) file, e.g. via

    python3 -m venv venv && source venv/bin/activate && python3 -m pip install -r requirements.txt

And your current session would already be using that virtual Python environment, which you could deactivate by executing `deactivate` command.
If in the future you would need to activate it, just `source venv/bin/activate` again.

After that you can either 
- do one time manual build using `mkdocs build` and find built website under `site/` folder.
- run `mkdocs serve` which would not only build website and start a local webserver for you to visit rendered version at e.g., http://0.0.0.0:8000/, but also it would automatically re-build if you change any source markdown or configuration file.
