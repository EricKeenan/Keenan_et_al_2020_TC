#!/bin/bash

site=$1
thresh=$2

output_path="../Simulations/density_profile/density_profile_${site}/output/"
tgt_date="1980-01-01T00:00"

# Did the simulation start? Check by seeing if the output directory is empty
if [ -z "$(ls -A ${output_path})" ]; then
	/usr/bin/time -v /projects/erke2265/src/AIS_snowpack/usr/bin/snowpack -r -c ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.ini -e 2017-12-31T23:30:00 >> ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.log 2>&1
	depth_tgt_time=$((0))
	pro_file=$(ls -t ${output_path}*pro | head -1)
else
	pro_file=$(ls -t ${output_path}*pro | head -1)
	depth_tgt_time=$(awk -v d="${tgt_date}" -F, 'BEGIN {p=0} {if(/^0500/ && sprintf("%04d-%02d-%02d", substr($NF,7,4), substr($NF,4,2), substr($NF,1,2))==substr(d,1,10)) {p=1}; if(p==1 && /^0501/) {print $NF; exit}}' ${pro_file})
fi

# Restart a unfinished simulation
sno_file=$(ls -t ${output_path}*sno)
if [ -f "${sno_file}" ]; then
	tmp="blah"
else
	sno_file=$(ls ${output_path}*sno* | tail -1)
	cp ${sno_file} ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.sno
	/usr/bin/time -v /projects/erke2265/src/AIS_snowpack/usr/bin/snowpack -r -c ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.ini -e 2017-12-31T23:30:00 >> ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.log 2>&1
	depth_tgt_time=$(awk -v d="${tgt_date}" -F, 'BEGIN {p=0} {if(/^0500/ && sprintf("%04d-%02d-%02d", substr($NF,7,4), substr($NF,4,2), substr($NF,1,2))==substr(d,1,10)) {p=1}; if(p==1 && /^0501/) {print $NF; exit}}' ${pro_file})
fi

# While snow depth at begining is less than threshold and the simulation did not finish
while (( $(echo "${depth_tgt_time} < ${thresh}" | bc -l) )); do
	# If there is more than 30 minutes left on the wall clock, dont wont to delete stuff if there is not enough time!
	if [ $(date '+%s') -lt "${MAX_START_TIME}" ]; then	
		# Move latest .sno file up one level and rename density_profile_sitenum.sno
		sno_file=$(ls -t ${output_path}*sno)
		if [ -f "${sno_file}" ]; then
			tmp="blah"
		else
			sno_file=$(ls ${output_path}*sno* | tail -1)
		fi

		cp ${sno_file} ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.sno

		# Clear entire output directory if the .sno file copy suceeded
		if [ -f "../Simulations/density_profile/density_profile_${site}/density_profile_${site}.sno" ]; then
			rm ${output_path}/*
		fi

        # Change the dates in the .sno file
		bash shift_profile.sh ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.sno 1980-01-01T00:00 > ../Simulations/density_profile/density_profile_${site}/tmp.sno
		rm ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.sno
		mv ../Simulations/density_profile/density_profile_${site}/tmp.sno ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.sno
	
		# 4. launch SNOWPACK
		/usr/bin/time -v /projects/erke2265/src/AIS_snowpack/usr/bin/snowpack -r -c ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.ini -e 2017-12-31T23:30:00 >> ../Simulations/density_profile/density_profile_${site}/density_profile_${site}.log 2>&1
	
		# Recalcuate snow depth
		depth_tgt_time=$(awk -v d="${tgt_date}" -F, 'BEGIN {p=0} {if(/^0500/ && sprintf("%04d-%02d-%02d", substr($NF,7,4), substr($NF,4,2), substr($NF,1,2))==substr(d,1,10)) {p=1}; if(p==1 && /^0501/) {print $NF; exit}}' ${pro_file})
	
	fi
done

echo "Done with site ${site}"
