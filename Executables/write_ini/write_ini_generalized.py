import sys
import xarray as xr

# Define system arguments
site = sys.argv[1]
lat_target = sys.argv[2]
lon_target = sys.argv[3]
sim_note = sys.argv[4]
path = sys.argv[5]

# Define path to write file
tmp_path = str(path) + "Simulations/" + str(sim_note) + "/" + str(sim_note) + "_" + str(site) + "/"
fname = tmp_path + str(sim_note) + "_" + str(site) + ".ini"

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
f.write("METEOPATH      =      /projects/erke2265/1D_Snowpack/Forcing/bias_corrected_redeposit_density_profile/\n")
f.write("STATION1       =      LAT_" + str(float(lat_target)) + "_LON_" + str(float(lon_target)) + "_MERRA2.smet "  + "\n")
f.write("SNOWPATH       =      /projects/erke2265/1D_Snowpack/Simulations/" + str(sim_note) + "/" + str(sim_note) + "_" + str(site) + "/" +  "\n")
f.write("SNOWFILE1      =      " + str(sim_note) + "_" + str(site) + ".sno\n")
f.write("VW_DRIFT::COPY =      VW\n")
f.write("\n")

f.write("[OUTPUT]\n")
f.write("METEOPATH      =       /projects/erke2265/1D_Snowpack/Simulations/" + str(sim_note) + "/" + str(sim_note) + "_" + str(site) + "/output/\n")
f.write("\n")

f.write("[SNOWPACKADVANCED]\n")
f.write("VARIANT        =       POLAR\n")
f.write("SNOW_EROSION   =       REDEPOSIT\n") 
f.write("MAX_SIMULATED_HS = 10 \n")
f.write("REDUCE_N_ELEMENTS = 2 \n")
f.write("SNOW_EROSION_FETCH_LENGTH = 10 \n")
#f.write("HN_DENSITY_PARAMETERIZATION = ZWART\n")
f.write("\n")

f.write("[GENERATORS]\n")
f.write("TSG::cst::value    =    " + str(T_s))

# Close file 
f.close()

print("Successfully Wrote .ini file!")
