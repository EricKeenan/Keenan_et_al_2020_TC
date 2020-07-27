# Keenan_et_al_2020_TC
All software and code required to reproduce SNOWPACK simulations and analysis presented in [*Keenan et. al., 2020 The Cryosphere Discussions*](https://tc.copernicus.org/preprints/tc-2020-175/). 

## SNOWPACK Simulations
SNOWPACK model source code can be accessed at https://github.com/snowpack-model/snowpack, while the precise version used in this study can be accessed at https://doi.org/10.5281/zenodo.3891846. 

**Automatic weather stations:**
```
cd Executables/
bash snowpack_point.sh
sbatch AWS_to_exec.sbatch
```

**Surface temperature proxies:**
```
cd Executables/
bash ice_core_snowpack_point.sh
sbatch ice_core_to_exec.sbatch
```

**SNOWPACK ensemble:**
```
cd SNOWPACK_ensemble/
bash setup.sh
bash run.sh
sbatch job.sbatch
```

**Near-surface density:**
```
cd Executables/
bash profile_snowpack_point.sh
sbatch to_exec_spinup.sbatch
```

**South Pole and West Antarctic Ice Sheet Divide firn properties:**

These simulations are taken from the Near-surface density simulations. 


## Model Ananlysis
Figure 1: Figure created in powerpoint. No code. 

Figure 2: `Model_Analysis/Map_Evaluation_Locations.ipynb`

Figure 3: `Model_Analysis/ice_core_model_comparison.ipynb`

Figure 4: `Model_Analysis/SNOWPACK_ensemble.ipynb`

Figure 5: `Model_Analysis/Plot_Density_Profile_Comparison.ipynb`

Figure 6: `Model_Analysis/Plot_Density_Profile_Comparison.ipynb`

Figure 7: `Model_Analysis/Plot_Density_Profile_Comparison.ipynb`

Figure 8: `Model_Analysis/Plot_Density_Profile_Comparison.ipynb`

Figure 9: `Model_Analysis/SNOWPACK_demo_figure.ipynb`

Figure A1: `Model_Analysis/MERRA2_AWS_ILWR_ISWR.ipynb` 
