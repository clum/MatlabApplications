%Add a video classification to each video in the large data table.
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/14/23: Created
%09/17/23: Minor update to file names
%07/08/24: Update to support multiple classifications
%07/09/24: Moved folder
%10/01/24: Updating folder structure of data

clear
clc
close all

tic

%% User selections
%Input file(s)
videoInfoFile   = [ReturnPathStringNLevelsUp(2),'\VideoInfo.xlsx'];
tableDataFile   = [ReturnPathStringNLevelsUp(2),'\Data\Content\Views\Content 2010-09-01_2024-07-08 Christopher Lum\Table data.csv'];
classificationInUse = 2;    %which classification column to use for groupings.  1 = full categories, 2 = education/other

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
        temp = videoInfoTable(idx,:);
        s = ['classification = temp.Classification',num2str(classificationInUse),'{1};'];
        eval(s);
    end
    
    Classification{k,1} = classification;
    
    %Find the videoDuration for this video
    idx = find(contains(videoClassificationTableContent,content));
    
    if(isempty(idx))
        error(['Cannot find video ',VideoTitle,' in the file ',videoInfoFile])
    else
        %Get the videoDuration
        temp = videoInfoTable(idx,:);        
        videoDuration = temp.VideoDuration{1};
    end
    
    VideoDuration{k,1} = videoDuration;
end

%Augment tableDataTable
tableDataTable.Classification   = Classification;
tableDataTable.VideoDuration    = VideoDuration;

%% Handle edge cases
for k=1:M
    row = tableDataTable(k,:);
    
    if(isnan(row.Views))
        colIdx = find(strcmp(row.Properties.VariableNames,'Views')==1);
        tableDataTable(k,colIdx) = {0};
    end

    if(isnan(row.WatchTime_hours_))
        colIdx = find(strcmp(row.Properties.VariableNames,'WatchTime_hours_')==1);
        tableDataTable(k,colIdx) = {0};
    end

    if(isnan(row.Subscribers))
        colIdx = find(strcmp(row.Properties.VariableNames,'Subscribers')==1);
        tableDataTable(k,colIdx) = {0};
    end

    if(isnan(row.EstimatedRevenue_USD_))
        colIdx = find(strcmp(row.Properties.VariableNames,'EstimatedRevenue_USD_')==1);
        tableDataTable(k,colIdx) = {0};
    end

    if(isnan(row.Impressions))
        colIdx = find(strcmp(row.Properties.VariableNames,'Impressions')==1);
        tableDataTable(k,colIdx) = {0};
    end

    if(isnan(row.ImpressionsClick_throughRate___))
        colIdx = find(strcmp(row.Properties.VariableNames,'ImpressionsClick_throughRate___')==1);
        tableDataTable(k,colIdx) = {0};
    end
end

%% Write output table
if(isfile(augmentedTableDataFile))
     delete(augmentedTableDataFile)
end

writetable(tableDataTable,augmentedTableDataFile);
disp(['Wrote data to ',augmentedTableDataFile])

toc
disp('DONE!')