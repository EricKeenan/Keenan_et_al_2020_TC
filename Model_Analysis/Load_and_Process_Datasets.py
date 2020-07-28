import pandas as pd
import numpy as np
from datetime import datetime

# Class for manipulating IMAU AWS datasets
class AWS:
    
    # Create Function that returns time series of AWS acoustic snow depth [m], where 
    # the function arguments are the station number. Station number 
    # needs to be a string of the form "04" for station 4. 
    def import_aws_snow_depth_timeseries(station_number):

        # Determine file path
        file = "ant_aws" + station_number + "_ACCDAY.txt"
        directory = "/pl/active/nasa_smb/Data/AWS_Daily_Snow_Depth/"
        file_path = directory + file

        # Load file to pandas data frame
        snow_depth = np.loadtxt(file_path, skiprows = 1, usecols = 2)
        
        with open(file_path, 'r') as myfile:
            data = myfile.read() 
        first_time_stamp = data[26:36]

        date_range = pd.date_range(first_time_stamp, periods = snow_depth.size, freq = 'D')
        time_series = pd.DataFrame(snow_depth, index = date_range)
        
        # QC values that do not meet a certain threshold 
        time_series = time_series.replace(-999.500000, np.nan)

        return time_series

    # Function to return time series of AWS variable given by column_num
    # Column_num = 4 # 2m Air Temperature. 
    # Column_num = 5 # Surface Temperature. 
    # Column_num = 7 # Measured Wind Speed. 
    # Column_num = 8 # 10M Adjusted Wind Speed. 
    # Column_num = 9 # Wind direction (degrees). 
    # Column_num = 11 # Incoming shortwave radiation. 
    # Column_num = 12 # Outgoing shortwave radiation. 
    # Column_num = 13 # Incoming longwave radiation. 
    # Column_num = 14 # Outgoing longwave radiation. 
    def get_IMAU_timeseries(file_path, column_num):
        
        # File Path (absolute path)
        file_path = file_path

        # Get number of timesteps
        with open(file_path, 'r') as myfile:
            data = myfile.readlines()
        rows = len(data)
        
        # Get data
        time = []
        value = []
        for j in range(0, rows):
            line = data[j][:]
            # Parse the line
            line = line.split()
            time.append(datetime.strptime(line[0],'%Y/%m/%d'))
            value.append(float(line[column_num]))
        
        # Convert to Data Frame
        time_series = pd.DataFrame(value, index = time)
        time_series = time_series.replace(-999.50000, np.nan)
            
        return time_series


# Class for manipulating 1-D Snowpack model datasets. 
class snwpck_1D:

    # Returnes datetime series corresponding to .sno file and the loaded in data file
    def get_time(file_path):
        # Open file and read
        with open(file_path, 'r') as myfile:
            data = myfile.readlines()  

        # Get dates and append to datetime series
        dates = []
        count = 0 
        for j in range(0,len(data)):
            line = data[j]
            code = line[0:4]
            if code == '0500':
                count = count + 1
                if count > 1:
                    time = datetime.strptime(line[5:24], '%d.%m.%Y %H:%M:%S')
                    dates.append(time)
                
        return dates, data

    # Returnes profile time series of variable defined by the string "code_string" as a pandas dataframe. 
    def get_profile(file_path, code_string):

        # Get time and data
        time, data = snwpck_1D.get_time(file_path)

        # Get profile at each time stamp. 
        profile = []
        count = 0 
        for j in range(0,len(data)):
            line = data[j]
            code = line[0:4]
            if code == code_string:
                count = count + 1
                if count > 1:
                    profile.append(line)

        # Get profile into numbers instead of strings
        var_profile = []
        for j in range(0,len(profile)):
            line = profile[j]
            line = line.strip(code_string)
            line = line.strip('\n')
            line = line.replace(","," ")
            line = [float(x) for x in line.split()]
            var_profile.append(line[1:])
        
        # Append empty array to profile timeseries if the first timestamp has zero snow depth and thus no profile
        # information. 
        while len(var_profile) < len(time):
            var_profile.insert(0,[])

        # Create Profile Timeseries
        time_series = pd.Series(var_profile, index = time)

        return time_series

    # Returns profile (depth and value) at a time specified by timestamp (yyyy-mm-dd hh:mm:ss, 
    # ex: '1980-02-18 12:00:00') of the variable defined by code_string. 
    def get_profile_timestamp(file_path, code_string, timestamp):
        
        profile_timeseries = snwpck_1D.get_profile(file_path, code_string)
        profile_depth = snwpck_1D.get_profile(file_path, "0501")

        profile = profile_timeseries[timestamp]
        profile_depth = profile_depth[timestamp]

        # Depth defined as bottom of element

        # Convert to numpy arrays and calculate depth
#         profile = np.asarray(profile[0])
        profile = np.asarray(profile)
#         profile_depth = np.asarray(profile_depth[0])
        profile_depth = np.asarray(profile_depth)
#         profile_depth = profile_depth[-1] - profile_depth
        profile_depth = profile_depth[-1] - profile_depth
        profile_depth = profile_depth / 100

        return profile, profile_depth

    # Returns data frame of variable defined by var_str
    # Possible var_str arguments include: 
    # Qs Ql Qg TSG Qg0 Qr OLWR ILWR LWR_net 
    # OSWR ISWR Qw pAlbedo mAlbedo ISWR_h ISWR_dir ISWR_diff TA TSS_mod TSS_meas 
    # T_bottom RH VW VW_drift DW MS_Snow HS_mod HS_meas hoar_size wind_trans24 
    # HN24 HN72_24 SWE MS_Water MS_Wind MS_Rain MS_SN_Runoff MS_Soil_Runoff 
    # MS_Sublimation MS_Evap MS_Sublimation_dHS MS_Settling_dHS MS_Redeposit_dHS 
    # MS_Redeposit_dRHO Sclass1 Sclass2 zSd Sd zSn Sn zSs Ss zS4 S4 zS5 S5
    def get_smet_timeseries(file_path, var_str):
        
        # Identify which row data begins in
        n = 100 # Only check the first 100 rows
        column_var = pd.read_csv(file_path, nrows = n)
        first_data_row = np.nan
        for j in range(1, n):
            if (column_var.iloc[j] == '[DATA]').all():
                first_data_row = j + 2 # Addhock solution
                break

        # Identify which columns to retrieve
        field_row =  np.loadtxt(file_path, skiprows = first_data_row - 2, max_rows = 1, dtype = 'str') 
        data_col = np.where(field_row == var_str)[0][0]
        data_col = data_col - 2 # Account for extra strings (Addhock)

        # Load data 
        time = np.loadtxt(file_path, skiprows = first_data_row, usecols = 0, dtype = 'str') 
        time = pd.to_datetime(time, format = '%Y-%m-%dT%H:%M:%S')
        ts = np.loadtxt(file_path, skiprows = first_data_row, usecols = data_col)
        
        # Create dataframe and set no data value to np.nan (0 if looking at MS_Redeposit_dHS)
        ts = pd.DataFrame(ts, index = time)
        if var_str == "MS_Redeposit_dHS" or var_str == "MS_Redeposit_dRHO":
            ts[ts == -999] = 0
        else:
            ts[ts == -999] = np.nan
        
        return ts
    
# Class for basic data set operations
class utilities:
    
    # Calculate bias
    def calc_bias(x, y):
        diff = y - x
        bias = np.nanmean(diff)
        return bias
    
    # Calculate root mean squared error
    def calc_rmse(x, y):
        squared_diff = (y - x) ** 2
        mean_squared_diff = np.nanmean(squared_diff)
        rmse = np.sqrt(mean_squared_diff)
        return rmse

 