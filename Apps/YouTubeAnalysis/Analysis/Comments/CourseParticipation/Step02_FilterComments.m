%Filter comments to isolate only appropriate commments.
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
Tf = T2(indicesB,:);

[M,~] = size(Tf);
disp(['Num Entries: ',num2str(M)])

%% Save data
save(outputFile,'Tf');
disp(['Saved to ',outputFile])

toc
disp('DONE!')