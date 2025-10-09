# Computing Environment

Tillicum provides a flexible software environment for research computing. You can run software through modules (via Lmod) or containers (via Apptainer). 

Here we'll focuse on how to build a custom computing environment using the minimal Conda module provided on Tillicum.

## Conda Environments

Conda allows you to create isolated environments that include specific versions of Python, libraries, and tools. 

A [conda cheatsheet](https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html) from Anaconda that you may find helpful.

### Load Conda Module

First, load the Conda module:

```bash
$ module load conda
________________________________________________________________________________
Miniforge (conda) has been loaded.

- Please create and work in your own conda environments:
    conda create -n myenv python=3.11
    conda activate myenv

- To customize environment or package locations, edit your ~/.condarc:
    envs_dirs:
      - /path/to/your/envs
    pkgs_dirs:
      - /path/to/your/pkgs

  For more information, see:
    https://docs.conda.io/projects/conda/en/latest/configuration.html

- If your personal Conda stops working after unloading this module, try:
    source ~/.bashrc
________________________________________________________________________________
```

After loading the module, the `conda` command becomes available. You can now create and manage your own environments.

### Create and Manage Conda Environments

For example, create an environment named "myenv" with Python 3.12 and the NumPy package:

```bash
conda create --name myenv python=3.12 numpy
```

Activate the environment to use it:

```bash
conda activate myenv
```

List your available Conda environments:

```bash
conda env list
```

Now your custom Conda environment is active and you can install additional packages using `conda install`. Conda has several default channels that will be used first for package installation. If you want to use another channel beyond the defaults channel, you can, but we suggest that you select your channel carefully.

> ⚠️ **WARNING:** By default, the system Conda stores environments in your home directory ($HOME/.conda/envs). We recommend installing Conda environments to your **project directory** under `/gpfs/<myproject>/<myfolder>` (see instructions below) due to the limited storage space (10 GB) in your home directory.

Remove an environment:

```bash
conda env remove --name myenv
```

### Customize Environment and Package Locations

There are two ways to specify where your Conda environments and packages are stored.

**Option 1. Use `--prefex` for explicit paths**

Manually set the path to your Conda environment by `--prefix` and always activate your Conda environment with full path.

```bash
module load conda
conda create --prefix /gpfs/<myproject>/<myfolder>/myenv python=3.12
conda activate /gpfs/<myproject>/<myfolder>/myenv
conda install numpy scipy matplotlib
```

**Option 2. Configure defaults in `$HOME/.condarc`**

To make this the default behavior, edit (or create) the file `$HOME/.condarc`:

```yaml
envs_dirs:
  - /gpfs/<myproject>/<myfolder>/conda/envs
pkgs_dirs:
  - /gpfs/<myproject>/<myfolder>/conda/pkgs
```

This will place all of your environments and package caches in this directory by default, and you won't have to worry about specifying the full prefix to your environment when installing it or activating it.

### Installing Packages with `pip`

You can use `pip` inside a Conda environment to install Python packages. Anaconda provides some [best practices](https://www.anaconda.com/blog/using-pip-in-a-conda-environment) for using `pip` with Conda. Our suggested use of pip is inside a conda environment. For example:

```bash
module load conda
conda activate myenv
pip install seaborn
```

This ensures that `pip` installs packages into the active Conda environment — **not globally** — making it easy to clean up completely when you are done.

See the [pip documentation](https://pip.pypa.io/en/stable/cli/pip_install/) for more information.

## Containers

Tillicum supports Apptainer containers for running portable, reproducible software stacks. We highly recommend using containers to build your software environment on Tillicum, particularly for GPU workflows with complex dependencies. [NVIDIA NGC Catalog](https://catalog.ngc.nvidia.com/?filters=&orderBy=weightPopularDESC&query=&page=&pageSize=) has pre-built containers with CUDA and NVIDIA drivers configured, which work well with the Tillicum environment.

We will hold separate, hands-on training sessions for building and running containers on Tillicum. 

> 🗓️ **Stay Tuned:** Check our [Research Computing Calendar](https://calendar.washington.edu/sea_uwit-rc) for upcoming training events.