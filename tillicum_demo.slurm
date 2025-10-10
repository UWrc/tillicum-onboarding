#!/bin/bash
#SBATCH --job-name=tilly_demo
#SBATCH --qos=normal
#SBATCH --gpus=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --time=00:10:00
#SBATCH --output=tillicum_demo_%j.out

module load conda
conda activate myenv

python tillicum_demo.py