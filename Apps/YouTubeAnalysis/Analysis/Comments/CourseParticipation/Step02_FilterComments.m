%Filter comments to isolate only appropriate commments.
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/27/25: Created
%11/06/25: Added display about date ranges

clear
clc
close all

tic

ChangeWorkingDirectoryToThisLocation();

%% User preferences
step01File  = 'Step01_LoadCommentsDatabase.mat';

startDateTime   = datetime('06/01/2021','InputFormat','MM/dd/yyyy');
endDateTime     = datetime('07/01/2021','InputFormat','MM/dd/yyyy');

substring = 'AE501_';

outputFile = 'Step02_FilterComments.mat';

%% Load data
temp = load(step01File);
T = temp.T;

%% Filter data
%filter to appropriate dates
indicesAbove = find(T.Timestamp>=startDateTime);
indicesBelow = find(T.Timestamp<=endDateTime);

indicesA = intersect(indicesAbove,indicesBelow);

T2 = T(indicesA,:);

%filter to only comments which have the substring inside of T2
indicesB = contains(T2.Comment,substring);
TCommentsFiltered = T2(indicesB,:);

[M,~] = size(TCommentsFiltered);

%% Display stats
disp(['Filtered to the following date range'])
disp(['Start Date:            ',char(startDateTime)])
disp(['End Date:              ',char(endDateTime)])
disp(['Duration (weeks):      ',num2str(days(endDateTime - startDateTime)/7)])
disp(' ')
disp(['Num Filtered Comments: ',num2str(M)])
disp(' ')

%% Save data
save(outputFile,'TCommentsFiltered','substring');
disp(['Saved to ',outputFile])
disp(' ')

toc
disp('DONE!')