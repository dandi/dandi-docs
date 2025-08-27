# Using the DANDI Hub

[DANDI Hub](http://hub.dandiarchive.org) is a [JupyterHub](https://jupyterhub.readthedocs.io) instance in the cloud to interact with the data stored in DANDI, and is free to use for exploratory analysis of data on DANDI.
For instructions on how to navigate JupyterHub see this [YouTube tutorial](https://www.youtube.com/watch?v=5pf0_bpNbkw&t=09m20s).
Note that DANDI Hub is not intended for significant computation, but provides a place to introspect Dandisets and to perform some analysis and visualization of data.

## Registration

To use the [DANDI Hub](http://hub.dandiarchive.org), you must first register for an account using the [DANDI website](http://dandiarchive.org).
See the [Create a DANDI Account](../getting-started/creating-account.md) page.

## Choosing a server option

When you start up the DANDI Hub, you will be asked to select across a number of server options.
For basic exploration, Tiny or Base would most likely be appropriate.
The DANDI Hub also currently offers Medium and Large options, which have more available memory and compute power.
The "T4 GPU inference" server comes with an associated T4 GPU, and is intended to be used for applications that require GPU for inference.
We request that users of this server be considerate of their usage of the DANDI Hub as a free community resource.
Training large deep neural networks is not appropriate.
A "Base (MATLAB)" server is also available, which provides a MATLAB cloud installation but you would be required to provide your own license.

## Using conda environments

DANDI Hub provides two ways to work with Python environments: shared environments managed through conda-store, and individual environments you create with conda in your home directory.

**Shared environments** are managed through conda-store and are available to all DANDI Hub users.
These environments contain commonly used packages for neurophysiology analysis and are maintained by administrators.
Use shared environments when:
- You need standard analysis tools and packages
- You want to collaborate with other users using the same environment
- You prefer not to manage package dependencies yourself

**Individual environments** are created and managed using standard conda commands in your user home directory (`/home/username`).
These are private to your account and **should be used instead of conda-store for personal environments**.
Create individual environments when:
- You need specific package versions not available in shared environments
- You're experimenting with new packages or configurations
- You need a customized environment for your specific analysis workflow

**Important:** Do not use conda-store for creating individual environments.
Conda-store is a deployment service for shared environments only.
Use regular conda commands for personal environments in your home directory.

### Using shared environments

#### Activating in the terminal

To see available shared environments:
```bash
conda env list
```

To activate a shared environment:
```bash
conda activate environment-name
```

For example, to activate the dandi environment:
```bash
conda activate nebari-git-dandi
```

#### Activating in your Jupyter notebook

**At startup:** When launching JupyterLab, you can select a shared environment from the kernel dropdown in the launcher.

**In an existing notebook:** 

1. In the top right of a notebook, click the current environment which will open a "Start a new kernel for mynotebook.ipynb"
2. Select the desired shared environment from the list
3. The notebook will switch to use packages from that environment

### Creating individual environments

#### Lightweight `venv` overlay

If you need to use an environment, ie `dandi` with extra dependencies, please **do not** create a new conda environment.
Instead use `venv` to create a local virtual environment **on top of an existing env.**

```bash
conda activate nebari-git-dandi
python -m venv --system-site-packages my-dandi-extras
source my-dandi-extras/bin/activate
pip install some-extra-package
```

#### Full custom `conda` environment

If you need to create a conda env make sure it is stored in your home directory using the `--prefix` flag:

```bash
conda create --prefix /home/username/.conda/envs/my-env-name python=3.9
```

To activate your individual environment:

```bash
conda activate /home/username/.conda/envs/my-env-name
```

To install packages in your individual environment:

```bash
conda activate /home/username/.conda/envs/my-env-name
conda install package-name
# or
pip install package-name
```

**Note:** Replace `username` with your actual username, or use `$HOME` instead of `/home/username`.

## Custom server image

If you need additional software installed in the image, you can add a server image that will be made available for all users in the `Server Options` menu.  Add a server image by following the instructions below and submitting a pull request to the [dandi-hub repository](https://github.com/dandi/dandi-hub).  Once the pull request is merged, the DANDI team will redeploy JupyterHub and the image will be available.


1. Fork and clone the [dandi-hub](https://github.com/dandi/dandi-hub) repository.
2. Add a Dockerfile to the [images](https://github.com/dandi/dandi-hub/tree/main/images) directory.
3. Test the Dockerfile with the following commands to build and run the new image, which can be viewed locally in the browser at 127.0.0.1:8888/
```sh
docker build -f "$(CONTAINERFILE)" -t dandihub-dev:latest .
docker run --rm -p 8888:8888 --name dev_jupyterlab dandihub-dev:latest start-notebook.sh --NotebookApp.token=""
```
4. Add the Dockerfile to the `include` matrix of both the [docker-push.yaml](https://github.com/dandi/dandi-hub/blob/main/.github/workflows/docker-push.yaml) and [docker-test.yaml](https://github.com/dandi/dandi-hub/blob/main/.github/workflows/docker-test.yaml) files.  This will allow the image to be built when new pull requests are opened and pushed to the [DANDI Archive Docker Hub](https://hub.docker.com/u/dandiarchive) when the pull requests are merged. 
5. Add the image to the server options by updating the [jupyterhub.yaml](https://github.com/dandi/dandi-hub/blob/main/envs/shared/jupyterhub.yaml) file.

## Example notebooks

The best way to share analyses on DANDI data is through the DANDI example notebooks.
These notebooks are maintained in the [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository which provides more information about their organization.
Dandiset contributors are encouraged to use these notebooks to demonstrate how to read, analyze, and visualize the data, and how to produce figures from associated scientific publications.

Notebooks can be added and updated through a pull request to the [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository.
Once the pull request is merged, your contributed notebook will be available to all DANDI Hub users.
