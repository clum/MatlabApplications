%Perform the entire workflow to analyze the Content folder
%
%Christopher Lum
%lum@uw.edu

%Version History
%07/09/24: Created

clear
clc
close all

Step01_CombineInputs;
Step02_AddColumns;
Step03_GroupDataByClassification;
Step04_VisualizeStats;