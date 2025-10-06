# Navigating the Filesystem & Understanding Storage Spaces

On Tillicum, storage is **physically separate** from computation nodes. It’s mounted so every node in the cluster can access it under `/gpfs/`. 

You’ll often hear Tillicum storage referred to as GPFS, which stands for **General Parallel File System** — IBM’s high-performance, cluster-wide filesystem. It allows all compute nodes to read and write to the same shared data simultaneously with very high throughput.

So whenever you see a path like:

```bash
/gpfs/home/UWnetID
```
that means you’re accessing your home directory on the GPFS storage system, not a local disk on the login node.

![Diagrammatic representation of the Tillicum filesystem directory tree. The directory tree shows the root directory at the top which holds all subdirectories. The picture is a truncated view of the filesystem showing the root directory and a few directories within it, including GPFS and a few directories within GPFS/: home/ where the Home directories are, software/ where we keep software, datasets/ where common datasets are stored, scrubbed/ where users can utilize temporary storage, and projects/ where the lab groups their dedicated storage.](/img/directory_graphic.jpg 'filesystem')
*Diagram - truncated view of the Tillicum filesystem.*


As shown above, the Tillicum filesystem is organized under the root directory `/`. Within it, `/gpfs/` contains several key subdirectories:

* `home/` — individual user home directories for configuration and small files.
* `software/` — centrally managed shared applications and tools.
* `datasets/` — curated public or shared research datasets. We have a process by which groups can nominate datasets for storage under our [**<ins>Data Commons</ins>**](https://hyak.uw.edu/docs/data-commons/requirements). 
* `scrubbed/` — temporary scratch space for active work, periodically cleaned.
* `projects/` — long-term storage for groups and project-specific data.

Every user on Tillicum has access to three key storage spaces mounted under `/gpfs/` where they can **write** *and* **read** files:

1. Home directory (`/gpfs/home/UWNetID`)— personal, backed-up storage
1. Project/lab dedicated storage (`/gpfs/projects/group-name`) — shared, backed-up storage for research groups
1. Scrubbed storage (`/gpfs/scrubbed/some-directory`) — large, temporary scratch space for active computation

Here’s a quick overview of Tillicum storage policies:
| Storage             | Size / Quota          | Backup          | Notes                                                                        |
| ------------------- | --------------------- | --------------- | ---------------------------------------------------------------------------- |
| Home Directory      | 10 GB per user        | Daily snapshots | Keep only configuration files here; use other spaces for data/code           |
| Project/Lab Storage | 1 TB per project/lab  | Daily snapshots | Request allocation via [**<ins>Tillicum intake form</ins>**](https://uwconnect.uw.edu/it?id=kb_article_view&sysparm_article=KB0036077)                             |
| Scrubbed Storage    | Up to 100 TB per user | None            | Scratch space, purged after 60 days of inactivity; not for long-term storage |

***Tillicum is a new service. We will constantly evaluate these storage policies based on user feedback.***

**Important**: For this tutorial, participants will not have project storage. To request project or lab storage, complete the [**<ins>Tillicum intake form</ins>**](https://uwconnect.uw.edu/it?id=kb_article_view&sysparm_article=KB0036077).

## Practice

Let's review key storage directories on Tillicum and practice commands.

### Your Home Directory

Your Home directory is your default location when logging into Tillicum. It’s located at:

```bash
cd ~
/gpfs/home/UWnetID
```
where **UWnetID** is *your* UW NetID.

We recommend storing only configuration files here and using other storage spaces for data, code, and software.

To check your current location, use:

```bash
pwd
```
To list the contents of your directory:

```bash
ls
```
To show detailed information or hidden files:

```bash
# List items with details
ls -l
# List item including hidden files
ls -a
```

### 2. Monitoring Your Storage Usage
To see how much space each subdirectory uses:

```bash
du -h -d 1
```

This command reports how much space each folder occupies and updates dynamically as you clean up files.

### 3. Moving Around — cd
The `cd` command changes your current directory. Some useful shortcuts:

```bash
cd /       # Go to the root directory
cd ~       # Go to your home directory
cd         # Also goes to home directory
cd /gpfs   # Go to the GPFS directory
cd datasets # Go to our Data Commons
ls         # List savailable datasets
cd -       # Return to your previous directory
```
Check your current location with `pwd`.

### 4. Scrubbed Storage — Our Tutorial Workspace
Scrubbed storage is temporary scratch space for active computation. It’s not backed up and files are deleted automatically after **60 days** of inactivity.

Location:

```bash
/gpfs/scrubbed/
```

For this tutorial, we’ll use scrubbed space as our working directory. Create a personal folder there and move into it:

```bash
mkdir /gpfs/scrubbed/$USER
cd /gpfs/scrubbed/$USER
```

While we're at it, le'ts clone the git repository for this tutorial, we'll use some of the files later. 

```bash
git clone https://github.com/UWrc/tillicum-onboarding.git
```

You can check the contens of your working directory and the contents of the git repository at any time with:

```bash
ls
ls tillicum-onboarding
```

#### Important Note on `/gpfs/scrubbed` and Conda Environments

Because `/gpfs/scrubbed` is periodically cleaned, files that have not been modified in the last 60 days may be deleted.
We have found that if users store their Conda environment directories here, some package files may be removed over time, breaking the environment.

* Do not store Conda environments in `/gpfs/scrubbed`.
* The home directory is too small for most environments.
* We recommend using dedicated project storage (available through the Tillicum intake process) for stable environment storage.

### 5. Practice: Exploring the Tillicum Filesystem
Let’s practice a few commands to get familiar with the filesystem:

```bash
# Go to the root directory
cd /

# List top-level directories
ls

# Explore home directories
ls /gpfs/home/

# Explore scrubbed storage
ls /gpfs/scrubbed/

# Enter your scrubbed working directory for this tutuorial
cd /gpfs/scrubbed/$USER

# Return to your home directory
cd ~
pwd
```