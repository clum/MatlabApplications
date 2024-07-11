%Plot the locations using geobubble
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
augmentedTableDataFile              = 'Step01_TableDataAugmented.xlsx';

%Output file(s)
% augmentedTableDataExtraColumnsFile  = 'Step02_TableDataAugmentedExtraColumns.xlsx';

%% Import data
augmentedTable  = readtable(augmentedTableDataFile);

%% geobubble
latitude_deg    = rad2deg(augmentedTable.latitude_rad);
longitude_deg   = rad2deg(augmentedTable.longitude_rad);

geobubble(latitude_deg,longitude_deg, ...
    augmentedTable.views_percentage, ...
    'Basemap','bluegreen')

toc
disp('DONE!')