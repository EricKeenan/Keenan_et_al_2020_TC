#!/bin/bash
source activate 1D_Snowpack

base_dir="/projects/erke2265/1D_Snowpack/Simulations/density_profile/"
sim_note="density_profile"
tgt_txt_file="/projects/erke2265/1D_Snowpack/Data/Density_Profile_Lat_Lon_Elevation.txt"
tgt_date_file="/projects/erke2265/1D_Snowpack/Simulations/density_profile/sumup_date.txt"
depth_thresh=950 # 950 cm, 9.5 m

# Calculate number of sites
num_sites=$(wc -l < "$tgt_txt_file")

# Variables for determining how much compute resources to request
declare -i cores_max=24
declare -i cores_request=24
declare -i sites_remain=${num_sites}

# Make simulation status, to_exec_spinup.lst file
sim_status_path="${base_dir}simulation_status.txt"
rm ${sim_status_path}
touch ${sim_status_path}

rm to_exec_spinup.lst
touch to_exec_spinup.lst

# Retrieve simulations status
for site in $(seq 1 $num_sites); do
#for site in $(seq 1 1); do
    echo working on site: ${site}
	tgt_date="1980-01-01T00:00"
	
	# Path to latest .pro file 
	pro_path="${base_dir}${sim_note}_${site}/output/"
	pro_file=$(ls -t ${pro_path}*pro | head -1)
	sno_file=$(ls -t ${pro_path}*sno | head -1)
	
	# All simulations need at least 950 cm of snow at the first time step, or else more spinup is needed
	if [ -f "${pro_file}" ] && [ -f "${sno_file}" ]; then 
		# Calculate snow depth
		depth_tgt_time=$(awk -v d="${tgt_date}" -F, 'BEGIN {p=0} {if(/^0500/ && sprintf("%04d-%02d-%02d", substr($NF,7,4), substr($NF,4,2), substr($NF,1,2))==substr(d,1,10)) {p=1}; if(p==1 && /^0501/) {print $NF; exit}}' ${pro_file})
		if (( $(echo "$depth_tgt_time < $depth_thresh" | bc -l) )); then
			echo "Profile ${site} snow depth = ${depth_tgt_time} -- More Time - not deep enough" >> ${sim_status_path}
			echo "bash more_spinup.sh $site $depth_thresh" >> to_exec_spinup.lst
		else
			echo "Profile ${site} snow depth = ${depth_tgt_time} -- Done" >> ${sim_status_path}
			sites_remain=$(( ${sites_remain} - 1))
		fi
	else
		echo "Profile ${site} -- Either no .pro or no .sno file found" >> ${sim_status_path}
		echo "bash more_spinup.sh $site $depth_thresh" >> to_exec_spinup.lst
	fi	
	
 	# Copy this script and others into simulation forlder
 	cp profile_spinup.sh ${base_dir}${sim_note}_${site}/
 	cp more_spinup.sh ${base_dir}${sim_note}_${site}/
 	cp to_exec_spinup.lst ${base_dir}${sim_note}_${site}/
done


# Print findings
echo "${sites_remain} sites remain"
if (( sites_remain > 0 )); then
	echo "More simulation required" 
	if (( sites_remain < cores_max )); then
		echo "We can reduce the number of cores"
		declare -i cores_request=${sites_remain}
		echo "We will now request ${cores_request} cores"
	else 
		echo "We will now request ${cores_request} cores"
	fi
else 
	echo "No more simulations required!"
fi

# Write .sbatch script if more spinup is required
if (( sites_remain > 0 )); then
	rm to_exec_spinup.sbatch
	touch to_exec_spinup.sbatch
	echo "#!/bin/bash" >> to_exec_spinup.sbatch
	echo "" >> to_exec_spinup.sbatch
	echo "#SBATCH --nodes=1" >> to_exec_spinup.sbatch
	echo "" >> to_exec_spinup.sbatch
	echo "#SBATCH --account=ucb164_summit1" >> to_exec_spinup.sbatch
	echo "#SBATCH --time=23:59:00" >> to_exec_spinup.sbatch
	echo "#SBATCH --qos=normal" >> to_exec_spinup.sbatch
	echo "#SBATCH --partition=shas" >> to_exec_spinup.sbatch
	echo "#SBATCH --ntasks=1" >> to_exec_spinup.sbatch
	echo "#SBATCH --array=1-${sites_remain}" >> to_exec_spinup.sbatch
	echo "" >> to_exec_spinup.sbatch
        echo "#SBATCH --job-name=density_profile" >> to_exec_spinup.sbatch
        echo "#SBATCH --output=./sbatch_out_files/%x.%j.out" >> to_exec_spinup.sbatch
        echo "#SBATCH --mail-type=ALL" >> to_exec_spinup.sbatch
        echo "#SBATCH --mail-user=eric.keenan@colorado.edu" >> to_exec_spinup.sbatch
	echo "" >> to_exec_spinup.sbatch
	echo "# purge all existing modules" >> to_exec_spinup.sbatch
        echo "module purge" >> to_exec_spinup.sbatch
        echo "module load proj" >> to_exec_spinup.sbatch
        echo "module load intel" >> to_exec_spinup.sbatch
	echo "" >> to_exec_spinup.sbatch
	echo 'time=$(date '+%s' -d "+23 hours +30 minutes")' >> to_exec_spinup.sbatch
	echo 'export MAX_START_TIME=${time}' >> to_exec_spinup.sbatch
	echo 'command=$(sed -n ${SLURM_ARRAY_TASK_ID}p to_exec_spinup.lst)' >> to_exec_spinup.sbatch
	echo '${command}' >> to_exec_spinup.sbatch
fi	
