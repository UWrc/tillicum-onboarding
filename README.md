# Tillicum Onboarding Tutorial

Welcome to the Tillicum Onboarding Tutorial — a guided introduction to the Tillicum GPU cluster at the University of Washington.
This repository provides step-by-step materials to help new users get started with Tillicum, including examples, commands, and best practices.

While this content is designed to remain relevant for all future users, it was originally developed for the Tillicum Onboarding and Training Workshop delivered live on Friday, October 10, 2025, 10:00 AM–12:00 PM in Seattle, Washington.
An introduction video from that workshop will be added here when available.

## Overview

Tillicum is a GPU-accelerated research computing cluster supporting AI, data science, and HPC workloads.
This tutorial covers everything you need to start using Tillicum effectively — from logging in to running interactive notebooks on GPUs.

By completing this tutorial, you’ll learn how to:

* Connect to the UW VPN
* Log in and access Tillicum resources
* Navigate the filesystem and manage data
* Transfer data with scp and Globus
* Submit and monitor jobs with Slurm
* Load and manage software modules
* Use Conda computing environments
* Launch Jupyter notebooks through Open OnDemand

## Repository Structure
Each topic in this tutorial is contained in its own Markdown file for easy navigation:

| Section                                      | Description                                                         |
| -------------------------------------------- | ------------------------------------------------------------------- |
| [**<ins>01-vpn.md</ins>**](./01-vpn.md)                     | Connecting to the UW VPN (required for Open OnDemand)               |
| [**<ins>02-logging-in.md</ins>**](./02-logging-in.md)       | How to log in via SSH                             |
| [**<ins>03-filesystem.md</ins>**](./03-filesystem.md)       | Understanding Tillicum filesystem, storage, and best practices                   |
| [**<ins>04-file-transfer.md</ins>**](./04-file-transfer.md)               | Transferring data using Globus (installing Globus Connect Personal) |
| [**<ins>05-slurm.md</ins>**](./05-slurm.md)                 | Submitting, monitoring, and managing jobs                           |
| [**<ins>06-modules.md</ins>**](./06-modules.md)             | Using LMOD to load software modules                                 |
| [**<ins>07-computing-env.md</ins>**](./07-computing-env.md) | Setting up Conda environments                         |
| [**<ins>08-ood-jupyter.md</ins>**](./08-ood-jupyter.md)     | Running Jupyter notebooks via Open OnDemand                         |
| [**<ins>09-task.md</ins>**](./09-task.md)     | Hands-on exercise                         |


## Introduction video

A link to the October 10, 2025 workshop intro video will be added here when available.

## Feedback

We’d love your feedback to help improve this tutorial and future Tillicum trainings.
After completing the tutorial or attending the workshop, please fill out our [**<ins>feedback form</ins>**](https://forms.office.com/r/bSXQpjYTQZ).

## Additional Resources

* [**<ins>Tillicum Documentation</ins>**](https://hyak.uw.edu/docs/tillicum/)
* [**<ins>Open OnDemand Portal</ins>**](https://hyak.uw.edu/docs/ood/start)
* [**<ins>Our Globus Docs</ins>**](https://hyak.uw.edu/docs/storage/globus)
* [**<ins>Globus' Documentation</ins>**](https://docs.globus.org/?_gl=1*da6xxk*_ga*ODMxMTMwMTg2LjE3NTg3MzQ0OTk.*_ga_7ZB89HGG0P*czE3NTk2MTAwNTAkbzckZzAkdDE3NTk2MTAwNTAkajYwJGwwJGgw)

