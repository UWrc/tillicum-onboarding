# Scheduling Jobs on Tillicum

When you first log in to Tillicum, you land on a shared login node (`tillicum-login01`). Login nodes are for light activity like transferring data, setting up environments, and preparing job scripts.

🛑 **Do not run compute-heavy work here**. All compute work must be run through the job scheduler.

Tillicum uses Slurm, a workload manager that allocates compute resources on the cluster. Slurm coordinates who gets GPUs and CPUs, when jobs run, and where they run.

## Understanding Job Types

There are two main ways to run work on Tillicum:

| Job Type            | Command  | Best For                     | Runs On                                         |
| ------------------- | -------- | ---------------------------- | ----------------------------------------------- |
| **Interactive Job** | `salloc` | Exploratory or hands-on work | A compute node you connect to directly          |
| **Batch Job**       | `sbatch` | Long or unattended jobs      | Runs automatically when resources are available |


Tillicum jobs are submitted under a "Quality-of-Service" or **QOS**, which defines limits like wall time, GPU count, and concurrent jobs. All Tillicum compute nodes have 8 GPUs (141 GB each) and these are provisioned with 200 GB system RAM per GPU and 8 CPUs per GPU.

| QOS             | Max Time   | Max GPUs per Job | Concurrent GPU Limit | Notes                           |
| --------------- | ---------- | ---------------- | -------------------- | ------------------------------- |
| **normal**      | 24 hours   | 16               | 48 GPUs              | Standard production work        |
| **debug**       | 30 minutes | 1                | 1 job                | Low-cost testing and setup      |
| **interactive** | 8 hours    | 2                | 2 jobs               | For real-time work or debugging |
| **long**        | by request | details TBA       | details TBA           | For special long jobs           |
| **wide**        | by request | details TBA       | details TBA           | For distributed jobs            |

**Tip**: You must request at least 1 GPU. CPU-only jobs are not allowed.

## Job Cost Estimates

Tillicum provides usage-based billing:

**Rate:** $0.90 per GPU-hour

**Formula:** GPU Hours = GPUs × Time Used

When you submit a job, Slurm estimates the cost:

```bash
salloc:     GPUs: 1
salloc:     CPUs: 1
salloc:     MEM: 200000 MB
salloc:     TIME: 1.00 hrs
salloc: *** COST: $0.90 (Est.)
```

Billing is handled monthly through UW-IT’s ITBill system.

## Interactive Jobs with `salloc`

Interactive jobs give you a live shell on a compute node — great for testing or exploring.

Run the following to start an interactive session using 1 GPU:

```bash
salloc --qos=interactive --gpus=1 --time=01:00:00
```

When the job starts, you’ll see the following:

```bash
salloc: Granted job allocation 18523
salloc: Waiting for resource configuration
salloc: Nodes g021 are ready for job
```

**Notice**: The hostname changed from `tillicum-login01` to `g021` or another Tillicum compute node (`g001`-`g024`). You are now on a compute node. 

**Tip**: If you have trouble with a job, saving the jobID (e.g. above, 18523) allows us to investigate what was going on when your job failed. 

Confirm your GPU is active:

```bash
nvidia-smi
```

You’ll see your GPU model, memory usage, and any running processes.

To end the session, type:
```bash
exit
```

## Batch Jobs with `sbatch`

Batch jobs run automatically without supervision. The following is an example of a script that can be used to schedule a job on Tillicum:

```bash
#!/bin/bash
#SBATCH --job-name=myjob
#SBATCH --qos=normal
#SBATCH --gpus=2
#SBATCH --cpus-per-task=16
#SBATCH --mem=400G
#SBATCH --time=04:00:00
#SBATCH --output=slurm-%j.out

hostname
nvidia-smi
```

You would submit the job with:

```bash
sbatch job.slurm
```

Slurm will return a job ID and queue it for execution.

Monitoring Jobs

Check your running and pending jobs:
```bash
squeue -u $USER
```

Watch your queue update every 10 seconds:

```bash
watch -n 10 squeue -u $USER
```

Use `sinfo -r` to view cluster status and available nodes.

## Practice

Tillicum uses Slurm to schedule jobs across its GPU nodes.
You’ll use two main job types:
* **Interactive** jobs for hands-on or exploratory work
* **Batch** jobs for longer, unattended run

### 1. Start an Interactive Job

Start by requesting one GPU for one hour:

```bash
salloc --qos=interactive --gpus=1 --time=01:00:00
```

You’ll see something like:

```bash
salloc: Granted job allocation 18523
salloc: Waiting for resource configuration
salloc: Nodes g021 are ready for job
bash-5.1$
```

You are now on a compute node. Check your hostname. 
```bash
hostname
```

**Notice**: The hostname changed from `tillicum-login01` to `g021` or another Tillicum compute node (`g001`-`g024`). 

**Tip**: If you have trouble with a job, saving the jobID (e.g. above, 18523) allows us to investigate what was going on when your job failed. 

### 2. Confirm Your GPU

Check that your GPU is active and ready to use:
```bash
nvidia-smi
```

This command shows your assigned GPU model, usage, and processes. The output will be two tables. The first table shows information such as the temperature (degrees Celsius), performance state (ranging from P0-P12, where P0 is the maximum performance state) and how much memory is used for all available GPUs. The second table provides information on all the processes using GPUs.

To continuously update the output every 5 seconds, use the flag `--loop = 5`:

```bash
nvidia-smi --loop=5
```

### 3. Run a Command Interactively

Let's try to run a simple script on the compute node. If you have been following along, you should have a directory in `/gpfs/scrubbed` and a copy of the git repository `/gpfs/scrubbed/$USER/tillicum-onboarding`. Change your directory to the cloned repository and list the items

```bash
cd /gpfs/scrubbed/$USER/tillicum-onboarding
ls
```

We will use `loop_script.sh` in the next sections to demonstrate executing commands with Slurm job scheduler. This script is a proxy for scripts or commands you might use. **Our main goal is to prepare you to adapt the Slurm commands for your research computing projects on Tillicum.**

`loop_script.sh` will take a starting point and an ending point and count until variable i=ending point. To execute this, use `./` with the desired starting and ending values:

```js
./loop_script.sh 0 1000000
```

The output should look like this:

```js
Sequence complete! Iterations from 0 to 1000000.
```

To see how long a job took, use the `time` command:

```js
time ./loop_script.sh 0 1000000
```

The output should look something like this:

```js
Sequence complete! Iterations from 0 to 1000000.

real    0m4.216s
user    0m4.071s
sys     0m0.068s
```

In exercise 5 below, we will execute `time ./loop_script.sh 0 1000000` again but this time as a batch job, that is executed without our supervision.

### 4. Exit the Compute Node

When you’re done exploring, end the session:
```bash
exit
```

You’ll return to the login node (e.g., `tillicum-login01`).

### 5. Submit a Batch Job

For longer running jobs, we recommend using a Slurm or `sbatch` script to submit a batch job rather than execute commands with an interactive session. Batch jobs are executed automatically without supervision. 

In this section, we will be using `loop_job.slurm` script in the git repository directory to run `loop_script.sh` as a batch job. Let's read it with:

```bash
cat loop_job.slurm
```

The first few lines of `loop_job.slurm` should look like this:

```bash
#!/bin/bash

#SBATCH --job-name=loop_job
#SBATCH --QOS=normal
#SBATCH --gpus=1
#SBATCH --time=5:00
#SBATCH -o %x_%j.out

time ./loop_script.sh 0 1000000
```

Slurm job scripts are written in the coding language bash and as such start with `#!/bin/bash`, also known as a "shebang." This ensures that the bash shell is used to run the script. The subsequent flags starting with `#SBATCH` are options for the `sbatch` command and communicate the specifications of the job that is being requested. Notice how the flags are reminiscent of the `salloc` command flags.

As written, this script requests a single GPU to run a job named `loop_job` to be sent to the `normal` QOS. The maximum time for the job is set to 5 minutes. The `#SBATCH -o %x_%j.out` requests that the standard output (stdout) or information that is usually printed to the screen during the execution of a command be saved to an output file. In this case, the filename will be similar to `loop_job_123456.out` because the `%x` is shorthand for the job name (`loop_job`) and the `%j` is shorthand for the JobID which will be assigned when the job is submitted.

Notice, we haven't specified an account, and Slurm will choose an account by default. However, if you would like to specify the account, you would include an additional option with `#SBATCH --account=` followed by the desired account. 

The commands you wish to execute will follow the `#SBATCH` option lines. In this case, we want to run `loop_script.sh` from 0 to 1000000 and see how long it takes:

The command to submit batch jobs is `sbatch`:

```bash
sbatch loop_job.slurm
```

The output file should have been made by now:

```bash
cat loop_job_<jobID>.out
# replace <jobID> above with the jobID
```

All outputs and error messages will appear in this file and should look like this if everything went well:

```bash
Sequence complete! Iterations from 0 to 1000000.

real    0m5.617s
user    0m5.570s
sys     0m0.016s
```

### 6. Monitor Your Job

Try increasing the looping interval to make the job run longer so that you can practice monitoring the job's progress. Open `loop_job.slurm` with `nano` to increase the interval: 

```bash
nano loop_job.slurm
```

Edit the command to be

```bash
time ./loop_script.sh 0 100000000
```
Exit the nano text editor with ctrl+x. The command to submit batch jobs is `sbatch`. Submit the job using `sbatch`:

```bash
sbatch loop_job.slurm
```

Check your job’s status:

```bash
squeue -u $USER
```

This command lists all your active or queued jobs.
You’ll see columns such as:
| Column               | Meaning                                                                                                            |
| -------------------- | ------------------------------------------------------------------------------------------------------------------ |
| **JOBID**            | A unique number assigned to your job. Use this to reference it in other commands.                                  |
| **PARTITION**        | The resource pool or QOS (e.g., `normal`, `interactive`).                                                          |
| **NAME**             | The job name you set in your script (`--job-name`).                                                                |
| **ST**               | The job’s status — common values include: <br> `PD` (Pending), `R` (Running), `CG` (Completing), `CD` (Completed). |
| **TIME**             | How long the job has been running.                                                                                 |
| **NODELIST(REASON)** | The node(s) your job is on, or if pending, the reason it’s waiting (like “Resources” or “Priority”).               |

Once it’s finished, view the output:
```bash
cat loop_job_<jobID>.out
# replace <jobID> above with the jobID
```


## Learn More

This workshop introduces Tillicum’s scheduler basics.
For a deeper dive — join our upcoming Tillicum Slurm Training later this quarter. [**<ins>Event information.</ins>**](https://calendar.washington.edu/sea_uwit-rc/Tillicum-Slurm-Workshop/E191023986)

![Tillicum Slurm Workshop Flyer. Follow the link able to event information for an accessible version of event details.](/img/tillicum_slurm.jpg 'event')