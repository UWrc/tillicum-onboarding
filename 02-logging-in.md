# Logging In to Tillicum

Accessing Tillicum through the command line allows you to interact directly with the cluster — submitting jobs, managing files, and running software. When you log in using SSH, you’re opening a secure terminal session on one of the login nodes. From here, you can explore the filesystem, prepare scripts, and submit workloads to compute nodes.

## Two-Factor Authentication

UW policy requires two-factor authentication (2FA) for all UW services, including Tillicum.

Before you begin, please ensure you have 2FA configured:

[<ins>**UW 2FA setup page →**</ins>](https://identity.uw.edu/2fa/)

You need 2FA to log onto any UW-IT Research Computing cluster.

## Logging in with SSH

Once your account and 2FA are set up, you can use ssh to log into Tillicum. SSH (Secure Shell) is the standard way to connect to remote computing systems like HPC clusters.

**Mac and Linux Users:** Open the Terminal application (usually found in Applications → Utilities on macOS).

**Windows Users:**
You can use:
* **PowerShell** or **Command Prompt** (built-in)
* **Windows Subsystem for Linux** (WSL) if installed
* Or external tools such as [<ins>**PuTTY**</ins>](https://www.putty.org/) or [<ins>**Git Bash - use "The Bash Shell" with Git installed on Windows from this link for a video with install instructions.**</ins>](https://carpentries.github.io/workshop-template/install_instructions/#shell)

Once you have a shell open, connect to Tillicum by typing:

```bash
ssh UWNetID@tillicum.hyak.uw.edu
```
Replace UW NetID with your UW NetID. You’ll be prompted for your UW password and then your Duo 2FA method:

```bash
Enter a passcode or select one of the following options:

 1. Duo Push to XXX-XXX-1234
 2. Phone call to XXX-XXX-1234

Passcode or option (1-2): 1
Success. Logging you in...
```

If successful, you’ll see a welcome banner like this:
```bash
      _____ _ _ _ _                           _    ___ 
     |_   _(_) | (_) ___ _   _ _ __ ___      / \  |_ _|
       | | | | | | |/ __| | | | '_ ` _ \    / _ \  | | 
       | | | | | | | (__| |_| | | | | | |  / ___ \ | | 
       |_| |_|_|_|_|\___|\__,_|_| |_| |_| /_/   \_\___|


This login node is meant for interacting with the job scheduler and 
transferring data to and from Tillicum. Please work by requesting an 
interactive session on (or submitting batch jobs to) compute nodes.
```

**Too many incorrect login attempts will result in an IP ban lasting up to an hour.**

## What’s a Shell?

The shell is your command-line interface to Tillicum — the environment where you type commands.
When you log in, you’re connected to a login node, which serves as the front door to the cluster. This is where you prepare your work, but not where you run compute-intensive jobs. All operations on the Tillicum login nodes are free of charge; however, compute- or memory-intensive tasks are not permitted, as these can disrupt other users. The login nodes are shared by all users.

Your prompt will look something like:
```bash
[UWNetID@tillicum-login01 ~]$
```

Let’s break this down:

* **UWNetID** — your username
* **tillicum-login01** — the login node you’re connected to
* **~** — the tilde symbol is a short hand for your home directory; this section of your command prompt will cahnge as you traverse the filesystem in the next section. 

## Practice

Once logged in, here are a few simple exercises to get familiar with the shell:

### 1. Check where you are

```bash
pwd
```

### 2. This prints your current directory (should be your home directory).

See what’s in your home directory

```bash
ls -l
```

This lists files and directories, along with details like size, and permissions.

### 3. Check what node you’re on

```bash
hostname
```

This confirms which login node you’re connected to (e.g., `tillicum-login01`).
