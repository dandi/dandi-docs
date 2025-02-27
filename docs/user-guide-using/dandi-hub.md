# DANDI Hub

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

## Custom server image

If you need additional software installed in the image, you can add a server image that will be made available for all users in the `Server Options` menu.  Add a server image by updating the `profileList` in the [JupyterHub config file](https://github.com/dandi/dandi-hub/blob/do-eks/helm/jupyterhub/dandihub.yaml) and submitting a pull request to the [dandi-hub repository](https://github.com/dandi/dandi-hub).  Once the pull request is merged, the DANDI team will redeploy JupyterHub and the image will be available.

## Example notebooks

The best way to share analyses on DANDI data is through the DANDI example notebooks.
These notebooks are maintained in the [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository which provides more information about their organization.
Dandiset contributors are encouraged to use these notebooks to demonstrate how to read, analyze, and visualize the data, and how to produce figures from associated scientific publications.

Notebooks can be added and updated through a pull request to the [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository.
Once the pull request is merged, your contributed notebook will be available to all DANDI Hub users.
