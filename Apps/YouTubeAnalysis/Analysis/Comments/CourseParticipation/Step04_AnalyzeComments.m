%Analyze comments.
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/27/25: Created

clear
clc
close all

tic

ChangeWorkingDirectoryToThisLocation();

%% User preferences
step01File = 'Step01_LoadCommentsDatabase.mat';

outputFile = 'Step01_LoadCommentsDatabase.mat';

%% Load data
T = ImportYouTubeCommentsDatabaseSpreadsheet(commentSpreadsheetFile);

%% Save data
save(outputFile,'T');
disp(['Saved to ',outputFile])

toc
disp('DONE!')