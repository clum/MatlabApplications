%Execute the workflow for course participation analysis
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/06/25: Created

clear
clc
close all

ChangeWorkingDirectoryToThisLocation();

Step01_LoadCommentsDatabase

Step02_FilterComments

Step03_GenerateYouTubeIdSubstring

Step04_FlattenComments