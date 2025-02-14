The DANDI ecosystem includes a self-hosted Jupyter notebook service. This service is hosted on AWS and orchestrated with a Kubernetes (k8s) cluster
that provides different instance types for users to efficiently interact with data in the DANDI Archive.

The instructions for configuring and deploying your own JupyterHub instance are available in the [dandi-hub repository](https://github.com/dandi/dandi-hub) (see [README](https://github.com/dandi/dandi-hub/blob/main/README.md#dandihub)).
For example configurations that have been previously generated for the DANDI, LINC, and BICAN projects see the [envs directory](https://github.com/dandi/dandi-hub/tree/main/envs).
**Note: it is important that your k8s cluster is in the same region as your data.**

Resources

• [Source code and instructions]( https://github.com/dandi/dandi-hub)

• [DANDI Hub](https://hub.dandiarchive.org/)

• [LINC Hub](https://hub.lincbrain.org/)