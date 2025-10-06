#!/bin/bash

#SBATCH --job-name=loop_job
#SBATCH --QOS=normal
#SBATCH --gpus=1
#SBATCH --time=5:00
#SBATCH -o %x_%j.out

time ./loop_script.sh 0 1000000