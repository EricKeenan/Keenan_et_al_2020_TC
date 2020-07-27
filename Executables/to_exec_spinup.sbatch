#!/bin/bash

#SBATCH --nodes=1

#SBATCH --account=ucb164_summit1
#SBATCH --time=23:59:00
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --ntasks=1
#SBATCH --array=1-2

#SBATCH --job-name=density_profile
#SBATCH --output=./sbatch_out_files/%x.%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eric.keenan@colorado.edu

# purge all existing modules
module purge
module load proj
module load intel

time=$(date +%s -d "+23 hours +30 minutes")
export MAX_START_TIME=${time}
command=$(sed -n ${SLURM_ARRAY_TASK_ID}p to_exec_spinup.lst)
${command}
