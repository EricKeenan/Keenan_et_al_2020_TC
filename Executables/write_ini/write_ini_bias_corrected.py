# This script writes a .ini file with 10m max  simulated snow depth that builds off of base.ini with arguments (station). 

import sys
import xarray as xr

# Define system arguments
site = sys.argv[1]
lat_target = sys.argv[2]
lon_target = sys.argv[3]
sim_notes = sys.argv[4]
path = sys.argv[5]
forcing = sys.argv[6]

# Define path to write file
fname = str(path) + str(site) + ".ini"

# Calculate boundary condition
T_s = xr.open_dataset("/projects/erke2265/1D_Snowpack/Forcing/TS_mean_1980_2017.nc")
T_s = T_s["TS"].sel(lon = float(lon_target), lat = float(lat_target), method = "nearest")
T_s = float(T_s.values)

# Open file
f = open(fname,'w')

# Write Lines
f.write("[GENERAL]\n")
f.write("IMPORT_BEFORE = ./base.ini\n")
f.write("BUFF_CHUNK_SIZE        =       370\n")
f.write("BUFF_BEFORE    =       1.5\n")
f.write("\n")

f.write("[INPUT]\n")
f.write("METEOPATH      =       ./\n")
f.write("STATION1       =       " + str(site) + ".smet\n")
f.write("SNOWPATH       =       ./\n")
f.write("VW_DRIFT::COPY =      VW\n")
f.write("\n")

f.write("[OUTPUT]\n")
f.write("METEOPATH      =       ./output/\n")
f.write("TS_DAYS_BETWEEN =      0.04166667\n")
f.write("\n")

f.write("[SNOWPACKADVANCED]\n")
f.write("MAX_SIMULATED_HS  = 10 \n")
f.write("VARIANT           = POLAR\n")
f.write("SNOW_EROSION      = REDEPOSIT\n")
f.write("REDUCE_N_ELEMENTS = 2\n")
f.write("SNOW_EROSION_FETCH_LENGTH = 10\n")
f.write("\n")

f.write("[GENERATORS]\n")
f.write("TSG::cst::value    =    " + str(T_s))

# Close file 
f.close()

print("Successfully Wrote .ini file!")
