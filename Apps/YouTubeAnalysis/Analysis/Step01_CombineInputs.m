%Add a video classification to each video in the large data table.
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/14/23: Created
%09/17/23: Minor update to file names

clear
clc
close all

tic

%% User selections
%Input file(s)
% videoInfoFile   = [ReturnPathStringNLevelsUp(1),'\VideoInfo.xlsx'];
videoInfoFile   = [ReturnPathStringNLevelsUp(1),'\VideoInfo_TEMP.xlsx'];
tableDataFile   = [ReturnPathStringNLevelsUp(1),'\Content 2010-09-01_2023-09-08 Christopher Lum\Table data.csv'];

%Output file(s)
augmentedTableDataFile  = 'Step01_TableDataAugmented.xlsx';

%% Import data
videoInfoTable  = readtable(videoInfoFile);
tableDataTable  = readtable(tableDataFile);

%% Combine data
%Remove the first row from tableDataTable
[M,N] = size(tableDataTable);
tableDataTable = tableDataTable(2:M,:);

videoClassificationTableContent = videoInfoTable.Content;
videoVideoDurationTableContent  = videoInfoTable.VideoDuration;

[M,N] = size(tableDataTable);
for k=1:M
    row = tableDataTable(k,:);
    
    content     = row.Content{1};
    VideoTitle  = row.VideoTitle{1};
    
    %Find classification for this video
    idx = find(contains(videoClassificationTableContent,content));
    
    if(isempty(idx))
        error(['Cannot find video ',VideoTitle,' in the file ',videoInfoFile])
    else
        %Get the classification
        temp = videoInfoTable(idx,3);
        classification = temp.Classification{1};
    end
    
    Classification{k,1} = classification;
    
    %Find the videoDuration for this video
    idx = find(contains(videoClassificationTableContent,content));
    
    if(isempty(idx))
        error(['Cannot find video ',VideoTitle,' in the file ',videoInfoFile])
    else
        %Get the videoDuration
        temp = videoInfoTable(idx,4);
        videoDuration = temp.VideoDuration{1};
    end
    
    VideoDuration{k,1} = videoDuration;
end

%Augment tableDataTable
tableDataTable.Classification   = Classification;
tableDataTable.VideoDuration    = VideoDuration;

%% Write output table
if(isfile(augmentedTableDataFile))
     delete(augmentedTableDataFile)
end

writetable(tableDataTable,augmentedTableDataFile);
disp(['Wrote data to ',augmentedTableDataFile])

toc
disp('DONE!')