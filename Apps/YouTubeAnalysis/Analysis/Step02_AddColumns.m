%Add columns to the data
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
augmentedTableDataFile              = 'Step01_TableDataAugmented.xlsx';

%Output file(s)
augmentedTableDataExtraColumnsFile  = 'Step02_TableDataAugmentedExtraColumns.xlsx';

%% Import data
augmentedTable  = readtable(augmentedTableDataFile);

%% Add columns
%Estimate the date the data was obtained as the latest published video date
videoDates = sort(augmentedTable.VideoPublishTime);
for k=1:length(videoDates)
    d = videoDates(end-k+1);
    if(~isnat(d))
        latestDate = d;
        break
    end
end

%Compute data
[M,N] = size(augmentedTable);
for k=1:M
    row = augmentedTable(k,:);
    
    Content                         = row.Content{1};
    VideoTitle                      = row.VideoTitle{1};
    VideoPublishTime                = row.VideoPublishTime;
    Views                           = row.Views;
    WatchTime_hours                 = row.WatchTime_hours_;
    Subscribers                     = row.Subscribers;
    EstimatedRevenue_USD            = row.EstimatedRevenue_USD_;
    Impressions                     = row.Impressions;
    ImpressionsClick_throughRate    = row.ImpressionsClick_throughRate___;
    Classification                  = row.Classification;
    VideoDuration                   = row.VideoDuration{1};

    %Compute data
    videoAge_days       = days(latestDate - VideoPublishTime);
    
    t = SplitOnDesiredChar(VideoDuration,':');
    switch(length(t))
        case 3
            hours   = str2num(t{1});
            minutes = str2num(t{2});
            seconds = str2num(t{3});
            
        case 2
            hours   = 0;
            minutes = str2num(t{1});
            seconds = str2num(t{2});
            
        otherwise
            error('Unsupported format')
    end
    
    videoDuration_sec   = seconds + minutes*60 + hours*60*60;
    
    %Containers for extra columns
    VideoAge_days{k,1}                  = videoAge_days;
    VideoDuration_sec{k,1}              = videoDuration_sec;
    
    AverageWatchTimePerView_min{k,1}    = WatchTime_hours*60/Views;
    AverageSubscribersPerView{k,1}      = Subscribers/Views;
    AverageRevenuePerView_USD{k,1}      = EstimatedRevenue_USD/Views;
    
    AverageViewsPerDay{k,1}             = Views/videoAge_days;
    AverageWatchTimePerDay_hours{k,1}   = WatchTime_hours/videoAge_days;
    AverageSubscribersPerDay{k,1}       = Subscribers/videoAge_days;
    AverageRevenuePerDay_USD{k,1}       = EstimatedRevenue_USD/videoAge_days;
    
    AverageRevenuePerMinuteWatched_USDpm{k,1}   = EstimatedRevenue_USD/(WatchTime_hours/60);
    AverageFractionVideoViewed{k,1}             = AverageWatchTimePerView_min{k,1}/(videoDuration_sec/60);
end

%Augment tableDataTable
augmentedTableExtraColumns = augmentedTable;

augmentedTableExtraColumns.VideoAge_days                        = VideoAge_days;
augmentedTableExtraColumns.VideoDuration_sec                    = VideoDuration_sec;
augmentedTableExtraColumns.AverageWatchTimePerView_min          = AverageWatchTimePerView_min;
augmentedTableExtraColumns.AverageSubscribersPerView            = AverageSubscribersPerView;
augmentedTableExtraColumns.AverageRevenuePerView_USD            = AverageRevenuePerView_USD;
augmentedTableExtraColumns.AverageViewsPerDay                   = AverageViewsPerDay;
augmentedTableExtraColumns.AverageWatchTimePerDay_hours         = AverageWatchTimePerDay_hours;
augmentedTableExtraColumns.AverageSubscribersPerDay             = AverageSubscribersPerDay;
augmentedTableExtraColumns.AverageRevenuePerDay_USD             = AverageRevenuePerDay_USD;
augmentedTableExtraColumns.AverageRevenuePerMinuteWatched_USDpm = AverageRevenuePerMinuteWatched_USDpm;
augmentedTableExtraColumns.AverageFractionVideoViewed           = AverageFractionVideoViewed;

%% Write output table
if(isfile(augmentedTableDataExtraColumnsFile))
     delete(augmentedTableDataExtraColumnsFile)
end

writetable(augmentedTableExtraColumns,augmentedTableDataExtraColumnsFile);
disp(['Wrote data to ',augmentedTableDataExtraColumnsFile])

toc
disp('DONE!')