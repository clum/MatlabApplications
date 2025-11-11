%Load all comments from the database.
%
%The database is created by running
%\PythonApplications\Apps\YouTubeCommentDownloader\YouTubeCommentDownloader.ipynb
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
% commentSpreadsheetFile = [ReturnPathStringNLevelsUp(6),'\PythonApplications\Apps\YouTubeCommentDownloader\CommentsDownloadTest03.xlsx'];
commentSpreadsheetFile = [ReturnPathStringNLevelsUp(6),'\PythonApplications\Apps\YouTubeCommentDownloader\CommentsDownloadTest04.xlsx'];

outputFile = 'Step01_LoadCommentsDatabase.mat';

%% Load data
T = ImportYouTubeCommentsDatabaseSpreadsheet(commentSpreadsheetFile);
disp(['Loaded ',commentSpreadsheetFile])

[M,~] = size(T);
disp(['Num Entries: ',num2str(M)])

%% Save data
save(outputFile,'T');
disp(['Saved to ',outputFile])

toc
disp('DONE!')