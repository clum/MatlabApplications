%Analyze the 'Table Data.csv' file that contains geography information and
%add extra information/columns to the data.
%
%Christopher Lum
%lum@uw.edu

%Version History
%07/09/24: Created

clear
clc
close all

tic

%% User selections
%Input file(s)
tableDataFile   = [ReturnPathStringNLevelsUp(2),'\Data\Geography 2010-09-01_2024-07-08 Christopher Lum\Table data.csv'];

%Output file(s)
augmentedTableDataFile  = 'Step01_TableDataAugmented.xlsx';

%% Import data
tableDataTable  = readtable(tableDataFile);

%% Add Extra Columns
%Remove the first row from tableDataTable (this only contains totals)
[M,N] = size(tableDataTable);
tableDataTable = tableDataTable(2:M,:);

totalViews          = sum(tableDataTable.Views);
totalWatchTime_hrs  = sum(tableDataTable.WatchTime_hours_);

views_percentage            = tableDataTable.Views./totalViews*100;
watchTime_hrs_percentage    = tableDataTable.WatchTime_hours_./totalWatchTime_hrs*100;

%Expand the geography code to a full country name
[M,N] = size(tableDataTable);

country = {};
latitude_rad = [];
longitude_rad = [];
for k=1:M
    row = tableDataTable(k,:);
    
    geography     = row.Geography{1};

    %Obtain country name, lat, lon
    country{k,1} = CountryCodeToName(geography);

    [lat_rad,lon_rad] = CountryCodeToLatLon(geography);
    
    latitude_rad(k,1) = lat_rad;
    longitude_rad(k,1) = lon_rad;
end

%% Create an augmented table
extraColumnsTable = table(views_percentage,...
    watchTime_hrs_percentage, ...
    country, ...
    latitude_rad, ...
    longitude_rad);

augmentedTableData = [tableDataTable extraColumnsTable];

%% Write output table
if(isfile(augmentedTableDataFile))
     delete(augmentedTableDataFile)
end

writetable(augmentedTableData,augmentedTableDataFile);
disp(['Wrote data to ',augmentedTableDataFile])

toc
disp('DONE!')