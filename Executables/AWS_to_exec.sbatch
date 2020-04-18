#!/bin/bash

#SBATCH --nodes=1                         # Number of requested nodes

#SBATCH --account=ucb164_summit1 
#SBATCH --time=06:00:00                   # Max wall time
#SBATCH --qos=normal                      # Specify testing QOS
#SBATCH --partition=shas                  # Specify Summit haswell nodes
#SBATCH --ntasks=1                       # Number of tasks per job
#SBATCH --array=1-13

##SBATCH --time=00:02:00                   # Max wall time
##SBATCH --qos=testing                      # Specify testing QOS
##SBATCH --partition=shas-testing                  # Specify Summit haswell nodes
##SBATCH --ntasks=1                       # Number of tasks per job

#SBATCH --job-name=AWS         # Job submission name
#SBATCH --output=./sbatch_out_files/%x.%j.out     # Output file name with Job ID
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eric.keenan@colorado.edu

# purge all exisitng modules
module purge
module load proj
module load intel

command=$(sed -n ${SLURM_ARRAY_TASK_ID}p to_exec.lst)
${command}
command=$(sed -n ${SLURM_ARRAY_TASK_ID}p /projects/erke2265/1D_Snowpack/Executables/to_exec2.lst)
${command}
command=$(sed -n ${SLURM_ARRAY_TASK_ID}p /projects/erke2265/1D_Snowpack/Executables/to_exec3.lst)
${command}
