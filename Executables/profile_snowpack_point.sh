#!/bin/bash
source activate 1D_Snowpack

# The purpose of this script is to run snowpack at locations with availabile observed density profiles. 

########################################### Start user configuration

sim_note="density_profile"
tgt_txt_file="/projects/erke2265/1D_Snowpack/Data/Density_Profile_Lat_Lon_Elevation.txt"

start="1980-01-01T00:00:00"
end="2017-12-31T23:30:00"


########################################### End user configuration

> to_exec.lst

# Define timing tool and working directory
tool="/usr/bin/time -v"
bin_path="/projects/erke2265/src/AIS_snowpack/usr/bin/snowpack"
working_dir="/projects/erke2265/1D_Snowpack/"

# Calculate number of sites
num_sites=$(wc -l < "$tgt_txt_file")

# Loop through each site
for site in $(seq 1 $num_sites)
#for site in $(seq 1 2)
do
	echo working on site: ${site}
	
	# Get site variables (lat,lon,elevation)
	site_line=$(cat $tgt_txt_file | head -${site} | tail -1)
	lat=$(echo $site_line | cut -d " " -f 1)
	lon=$(echo $site_line | cut -d " " -f 2)
	elevation=$(echo $site_line | cut -d " " -f 3)
	
	# Make simulation folder and clear previous runs
	folder="../Simulations/${sim_note}/${sim_note}_${site}/"
	rm -r ${folder}
	mkdir -p ${folder}
	mkdir -p ${folder}/output/
	mkdir -p ${folder}/current_snow/
	log="${folder}${sim_note}_${site}.log"
	> ${log}

	# Copy base.ini
	cp ../Forcing/base.ini ${folder}

	#Write Initial .sno  and .ini files 
	python3 ./write_sno/write_sno.py ${sim_note}_${site} ${lon} ${lat} ${elevation} ${start} ${working_dir}/Simulations/${sim_note}/${sim_note}_${site}/ >> ${log} 2>&1
	python3 ./write_ini/write_ini_generalized.py ${site} ${lat} ${lon} ${sim_note} ${working_dir} >> ${log} 2>&1

        # Write Snowpack Commands to to_exec.lst
        echo "${tool} ${bin_path} -r -c ${folder}${sim_note}_${site}.ini -e ${end[$i]} >> ${log} 2>&1" >> to_exec.lst

        # Copy this script and the to_exec.lst file  to simulation folder       
	cp ./profile_snowpack_point.sh ${folder}
        cp ./to_exec.lst ${folder}

	# Copy .ini and .sno creation scripts
	cp ./write_sno/write_sno.py ${folder}
	cp ./write_ini/write_ini_generalized.py ${folder}
done






