#!/bin/bash
source activate 1D_Snowpack

################### Multiple Sites: Define Variables ################### 
site=("Brooke_1" "Brooke_2" "Brooke_3" "WAIS" "AWS_4" "AWS_5" "AWS_6" "AWS_8" "AWS_9" "AWS_10" "AWS_11" "AWS_12" "AWS_16")
# start=("1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00" "1980-01-02T00:00:00")
snow_start="1980-01-01T00:30:00"
end=("2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00" "2017-12-31T23:30:00")
lon=(-95.962 -121.22 -101.738 -112.08833 -15.4833  -13.167 -11.517 -8.05 0 -45.783 -6.8 35.633 23.333)
lat=(-77.957 -76.952 -76.77 -79.48278 -72.75 -73.1 -74.467 -76 -75 -79.567 -71.167 -78.65 -71.95)
altitude=(1593 2020 1329 1797 35 360 1160 2400 2900 890 690 3620 1300)
sim_notes="not_bias_corrected_radiation"
tool="/usr/bin/time -v"
bin="/projects/erke2265/src/AIS_snowpack/usr/bin/snowpack"
working_dir="/projects/erke2265/1D_Snowpack/"

################### Launch Loop To Write to_exec.lst ################### 
> to_exec.lst
len=${#site[@]}
#len=1
for (( i=0; i<$len; i++ ))
do
    echo ${site[$i]}
	# Make simulation folder and clear previous runs
	folder="../Simulations/${sim_notes}/${site[$i]}/"
	rm -r ${folder}
	mkdir ${folder}
    	mkdir ${folder}/output/
	log="${site[$i]}.log"
	> ${folder}${log}

	# Copy base.ini and forcing .smet into simulation folder
	cp ../Forcing/base.ini ${folder}
    	cp ../Forcing/not_bias_corrected_smet/${site[$i]}.smet ${folder}

	#Write Initial .sno  and .ini files 
	python3 ./write_sno/write_sno.py ${site[$i]} ${lon[$i]} ${lat[$i]} ${altitude[$i]} ${snow_start} ${folder}  >> ${folder}${log} 2>&1
	python3 ./write_ini/write_ini_not_bias_corrected.py ${site[$i]} ${lat[$i]} ${lon[$i]} ${sim_notes} ${folder} ${site[$i]}.smet >> ${folder}${log} 2>&1

    # Write Snowpack Commands to to_exec.lst
	echo "pushd ${folder}" >> to_exec.lst
	echo "${tool} ${bin} -r -c ${site[$i]}.ini -e ${end[$i]} >> ${site[$i]}.log 2>&1" >> to_exec2.lst
	echo "popd" >> to_exec3.lst

	# Copy this script, to_exec.lst, and the write ini and sno file scripts  to simulation folder
	cp ./snowpack_point.sh ${folder}
	cp ./to_exec.lst ${folder}
	cp ./to_exec.sbatch ${folder}
    	cp ./write_sno/write_sno.py ${folder}
    	cp ./write_ini/write_ini_not_bias_corrected.py ${folder}
done




