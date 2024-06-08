%Group data/stats by classification
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/15/23: Created
%09/17/23: Minor update to file names

clear
clc
close all

tic

%% User selections
%Input file(s)
augmentedTableDataExtraColumnsFile  = 'Step02_TableDataAugmentedExtraColumns.xlsx';

%Output file(s)
GroupByClassificationFile = 'Step03_GroupByClassification.xlsx';

%% Import data
Tin    = readtable(augmentedTableDataExtraColumnsFile);

%% Find all classifications
classifications = unique(Tin.Classification);

%% Group by classifications
Classification = Tin.Classification;

for k=1:length(classifications)
    classification = classifications{k};
    
    indices = contains(Classification,classification);
    
    %Display information
    disp(classification)
    Tin.VideoTitle(indices)
       
    %Containers for columns
    ClassNumberVideos{k,1}      = sum(indices);
    ClassViews{k,1}             = sum(Tin.Views(indices));
    ClassWatchTime_hr{k,1}      = sum(Tin.WatchTime_hours_(indices));
    ClassSubscribers{k,1}       = sum(Tin.Subscribers(indices));
    ClassRevenue_USD{k,1}       = sum(Tin.EstimatedRevenue_USD_(indices));
    ClassImpressions{k,1}       = sum(Tin.Impressions(indices));
    ClassVideoDuration_hr{k,1}  = sum(Tin.VideoDuration_sec(indices))/60/60;
end

%Create table
Classification = classifications;   %change variable name to be consistent
Tout = table(Classification,...
    ClassNumberVideos,...
    ClassViews,...
    ClassWatchTime_hr,...
    ClassSubscribers,...
    ClassRevenue_USD,...
    ClassImpressions,...
    ClassVideoDuration_hr);

%% Write output table
if(isfile(GroupByClassificationFile))
    delete(GroupByClassificationFile)
end

writetable(Tout,GroupByClassificationFile);
disp(['Wrote data to ',GroupByClassificationFile])

toc
disp('DONE!')