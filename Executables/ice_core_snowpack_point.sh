#!/bin/bash
source activate 1D_Snowpack

# The purpose of this script is to run snowpack at 55 ice cores between 1980-2017. 

# Variables
ice_core_data_path="/projects/erke2265/1D_Snowpack/Data/Ts_Obs_MvdB.txt"
start="1980-01-01T00:00:00"
end="2017-12-31T23:30:00"
sim_notes="_not_bias_corrected_radiation"
tool="/usr/bin/time -v"
bin_path="/projects/erke2265/src/AIS_snowpack/usr/bin/snowpack"
working_dir="/projects/erke2265/1D_Snowpack/"

# Create variables by reading ice core data text file
> to_exec.lst
num_sites=$(wc -l < "$ice_core_data_path")
for site in $(seq 1 $num_sites)
#for site in $(seq 1 3)
do
	echo working on site: ${site}
	
	# Get site variables
	site_line=$(cat $ice_core_data_path | head -${site} | tail -1)
	lat=$(echo $site_line | cut -d " " -f 1)
	lon=$(echo $site_line | cut -d " " -f 2)
	altitude=$(echo $site_line | cut -d " " -f 3)
	
	# Make simulation folder and clear previous runs
	folder="../Simulations/ice_core/ice_core_${site}${sim_notes}/"
	rm -r ${folder}
	mkdir ${folder}
	mkdir ${folder}/output
	log="${folder}/ice_core_${site}.log"
	> ${log}

	# Copy base.ini into simulation folder
	cp ../Forcing/base.ini ${folder}

	#Write Initial .sno  and .ini files 
	python3 ./write_sno/write_sno.py ice_core_${site} ${lon} ${lat} ${altitude} ${start} ${folder} >> ${log} 2>&1
	python3 ./write_ini/write_ini_ice_core.py ${site} ${lat} ${lon} ${sim_notes} ${working_dir} ${site}.smet >> ${log} 2>&1

        # Write Snowpack Commands to to_exec.lst
        echo "${tool} ${bin_path} -r -c ${folder}ice_core_${site}.ini -e ${end[$i]} >> ${log} 2>&1" >> to_exec.lst

        # Copy this script and to_exec.lst and to_exec.sbatch to simulation folder
        cp ./ice_core_snowpack_point.sh ${folder}
	cp ./to_exec.sbatch ${folder}
	
	# Copy .ini and .sno creation scripts
	cp ./write_sno/write_sno.py ${folder}
	cp ./write_ini/write_ini_ice_core.py ${folder}
done






