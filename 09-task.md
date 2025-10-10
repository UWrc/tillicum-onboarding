<!-- omit in toc -->
# Hands-on Exercise: Running a Python Script on Tillicum

This hands-on exercise will guide you through the essential steps for using Tillicum:

You’ll create a working directory, start an interactive job, load modules, build a Conda environment, run Python code, submit a batch job, and finally connect that environment to Jupyter Notebook.

> 🎯 **GOAL:** Learn how to build and run a simple workflow on Tillicum — from terminal to Jupyter.

**Overview**

- [0. Create Your Working Directory](#0-create-your-working-directory)
- [1. Start an Interactive Job](#1-start-an-interactive-job)
- [2. Load Conda Module and Create an Environment](#2-load-conda-module-and-create-an-environment)
- [3. Run a Simple Python Script](#3-run-a-simple-python-script)
- [4. Submit a Batch Job](#4-submit-a-batch-job)
- [5. Register the Conda Environment for Jupyter Notebook](#5-register-the-conda-environment-for-jupyter-notebook)
- [6. Launch JupyterLab from Open OnDemand](#6-launch-jupyterlab-from-open-ondemand)
- [7. Cleanup](#7-cleanup)

## 0. Create Your Working Directory

All hands-on exercise should be done in your `/gpfs/scrubbed` directory. Let's start with creating your own directory in `/gpfs/scrubbed` and cloning the onboarding repository to your directory:

```bash
# Skip this step if you've already completed it.
mkdir /gpfs/scrubbed/$USER
cd /gpfs/scrubbed/$USER
git clone https://github.com/UWrc/tillicum-onboarding.git
```

> 📝 **NOTE:** The `$USER` variable automatically expands to your username.

## 1. Start an Interactive Job

> ⚠️ **WARNING:** All compute work must run on compute nodes — **never** on the login node.

Request an interactive session with 1 GPU for 1 hour:

```bash
salloc --qos=interactive --gpus=1 --time=01:00:00
```

Once resources are allocated, confirm you're on a compute node:

```bash
hostname
```

You should see the hostname change from `tillicum-login0*` to something like `g***`.

Check GPU availability:

```bash
nvidia-smi
```

If you see GPU details (e.g., NVIDIA H200 with driver and CUDA versions), you're ready to compute.

## 2. Load Conda Module and Create an Environment

> ⚠️ **WARNING:** To install GPU-aware packages (TensorFlow in our case), always request a GPU node for the installation.

List available modules and locate Conda:

```bash
module avail
module spider conda
```

Load the system Conda module:

```bash
module load conda
```

To avoid Home disk quota exceeded, open the file `$HOME/.condarc`:

```bash
nano ~/.condarc
```

and edit it to include following lines:

```yaml
envs_dirs:
  - /gpfs/scrubbed/<UW NetID>/conda/envs
pkgs_dirs:
  - /gpfs/scrubbed/<UW NetID>/conda/pkgs
```

Please replace <UW NetID> with your own UW NetID. Save (^O) and exit (^X) before continue in the shell.

This will place all of your environments and package caches in the specified directories by default, and you won't have to worry about specifying the full prefix to your environment when installing it or activating it.

Create a Conda environment in your scrubbed directory:

```bash
# Rename "myenv" to anything you prefer.
conda create --name myenv python=3.12 tensorflow
```

Activate the environment:

```bash
conda activate myenv
```

Verify Python is ready in your environment:

```bash
which python
python --version
```

You'll see the full path such as `/gpfs/scrubbed/$USER/myenv/bin/python`, and `python --version` returns "Python 3.12.11". That confirms your environment is isolated and stored safely in your workspace.

## 3. Run a Simple Python Script

A simple demo script `tillicum_demo.py` is provided in the training repository. Run it as follows:

```bash
cd /gpfs/scrubbed/$USER/tillicum-onboarding
python tillicum_demo.py 2>/dev/null
```

Here, `2>/dev/null` redirect standard error to `/dev/null` when running the script.

You’ll see console output like:

```plain text
▶️ Starting Tillicum demo job...
# TensorFlow version used
# CUDA availability reported
# GPU count and name
✅ Completed successfully.
```

This verifies that TensorFlow can detect and use your GPU.

## 4. Submit a Batch Job

Now, let's run the same task as a batch job using Slurm so it can run unsupervised.

Deactivate your environment and exit your interactive shell:

```bash
conda deactivate
exit
```

A template job script is included in the training repository. Review and update it before submitting the job:

```bash
nano tillicum_demo.slurm
```

> 📝 **NOTE:** Update the `conda activate` environment name in the script to match your actual name. Save (^O) and exit (^X) before continue in the shell.

> 💡 **TIP:** `#SBATCH --output=tillicum_demo_%j.out` redirect both standard output (`stdout`) and standard error (`stderr`)to the file specified `tillicum_demo_%j.out`, where %j is the job ID allocated.

Submit a batch job:

```bash
sbatch tillicum_demo.slurm
```

Slurm will return a job ID.

Monitor your pending and running jobs:

```bash
squeue -u $USER
```

When the job finishes, view results:

```bash
cat tillicum_demo_.out
```

## 5. Register the Conda Environment for Jupyter Notebook

You can now use your Conda environment inside Jupyter via Open OnDemand (OOD).

Install the IPython kernel package `ipykernel` from a terminal on Tillicum:

```bash
module load conda
conda activate myenv
conda install ipykernel
```

Register your environment as a Jupyter kernel:

```bash
python -m ipykernel install --user --name myenv --display-name "Python (Tillicum Demo)"
```

> 💡 **TIP:** You only need to register each environment once.

## 6. Launch JupyterLab from Open OnDemand

**Preparation:** By default, Jupyter sessions on OOD start in your Home directory. To access files outside your Home directory, we need to create a symbolic link in your Home directory which links to the actual working directory in `/gpfs/scrubbed/$USER`.

```bash
cd ~
ln -s /gpfs/scrubbed/$USER scrubbed
```

Then launch JupyterLab:

- Go to [**Tillicum Open OnDemand Portal**](https://tillicum-ood.hyak.uw.edu/).
- Choose **Interactive Apps** > **Jupyter**.
- Configure:
    - **Account**: trainob2025
    - **QOS**: interactive
    - **Number of GPUs**: 1
    - **Number of hours**: 1
    - **User Interface**: Jupyter Lab
- Click **Launch**, wait for resources to be allocated.
- Click **Connect to Jupyter** when resources are ready.
- In JupyterLab, click **Python (Tillicum Demo)** under **Notebook** in **Launcher** tab to open a new notebook.
- Go to **Kernel** > **Change Kernel** > select **Python (Tillicum Demo)** in the dropdown box.

Now your computing environment is ready. 

To test your environment, copy the following code snippet and paste it in a cell, and then run the cell with shift+enter:

```python
import tensorflow as tf
print(f"Using TensorFlow {tf.__version__}")
gpus = tf.config.list_physical_devices('GPU')
if gpus:
    print(f"CUDA available; {len(gpus)} GPU(s) detected:")
    print("GPUs:", gpus)
```

If it returns "CUDA available", your GPU is active!

## 7. Cleanup

When finished:

1. Close the Jupyter browser tab.
2. Return to OOD and click **Delete** on your running session card.

This release compute resources back to the cluster.

> ⚠️ **WARNING:** Leaving sessions running consumes GPU hours and counts toward your project usage.

To remove your temporary environment later, run from a terminal on Tillicum:

```bash
module load conda
conda env remove --name myenv
```

> 📝 **NOTE:** Make sure your environment is *deactivated* before removing it.