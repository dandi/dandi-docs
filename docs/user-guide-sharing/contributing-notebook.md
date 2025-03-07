# Contributing an Example Notebook

Example notebooks are a great way to showcase how to use your data and help others understand and reproduce your analyses. This page explains how to contribute an example notebook to the DANDI Archive.

## What are Example Notebooks?

Example notebooks are Jupyter notebooks that demonstrate how to:

- Load and access data from a Dandiset
- Perform basic analyses or visualizations
- Reproduce figures from associated publications
- Showcase the potential uses of your data

These notebooks are maintained in the [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository and are available to all DANDI Hub users.

## Why Contribute an Example Notebook?

Contributing an example notebook:

- Makes your data more accessible and usable by others
- Increases the visibility and impact of your dataset
- Helps ensure reproducibility of your research
- Provides a starting point for others to build upon your work
- Demonstrates the value of your data to the community

## How to Contribute an Example Notebook

To contribute an example notebook:

1. **Create a Jupyter notebook** that demonstrates how to use your data. Your notebook should:

    - Include clear documentation and comments
    - Load data directly from your published Dandiset using the DANDI API
    - Include examples of basic analyses or visualizations
    - Be well-organized and easy to follow

2. **Submit a pull request** to the [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository:
    - Fork the repository
    - Add your notebook to the appropriate directory
    - Submit a pull request with a clear description of your notebook

3. **Wait for review and approval** from the DANDI team. Once approved, your notebook will be merged into the repository and made available to all DANDI Hub users.

## Best Practices for Example Notebooks

To create effective example notebooks:

- **Start with a clear introduction** explaining the purpose of the notebook and the dataset it uses
- **Include installation instructions** for any required packages
- **Use relative paths** when accessing data to ensure portability
- **Include visualizations** to help users understand the data
- **Document any assumptions or limitations** of your analyses
- **Test your notebook** in the DANDI Hub environment before submitting
- **Keep the notebook focused** on demonstrating how to use the data rather than complex analyses

## Example Notebook Organization

The [dandi/example-notebooks](https://github.com/dandi/example-notebooks) repository is organized into several directories:

- **[dandi/](https://github.com/dandi/example-notebooks/tree/master/dandi)**: Notebooks that demonstrate general DANDI functionality
- **[tutorials/](https://github.com/dandi/example-notebooks/tree/master/tutorials)**: Notebooks that provide step-by-step tutorials for specific tasks
- **[demos/](https://github.com/dandi/example-notebooks/tree/master/demos)**: Notebooks that showcase specific features or use cases
- **`{dandiset_id}`/**: Notebooks that demonstrate how to use a specific Dandiset

When contributing your notebook, place it in the appropriate directory based on its content and purpose.

For more information about the organization of example notebooks, see the [README](https://github.com/dandi/example-notebooks) in the example-notebooks repository.
