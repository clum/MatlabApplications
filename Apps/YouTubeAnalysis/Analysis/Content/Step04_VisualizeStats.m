%Visualize stats/data
%
%Christopher Lum
%lum@uw.edu

%Version History
%09/17/23: Created
%07/10/24: Added stats

clear
clc
close all

tic

%% User selections
%Input file(s)
augmentedTableDataExtraColumnsFile  = 'Step02_TableDataAugmentedExtraColumns.xlsx';
GroupByClassificationFile           = 'Step03_GroupByClassification.xlsx';

%Output file(s)

%% Import data
Tin_data    = readtable(augmentedTableDataExtraColumnsFile);
Tin_grouped = readtable(GroupByClassificationFile);

%% General stats
[M,~] = size(Tin_data);

disp(['Number videos:                ',num2str(M)])
disp(['Total views (millions):       ',num2str(sum(Tin_data.Views/1000000))])
disp(['Total watch time (years):     ',num2str(sum(Tin_data.WatchTime_hours_)/24/365)])
disp(['Total subscribers:            ',num2str(sum(Tin_data.Subscribers))])
disp(['Total revenue (USD):          ',num2str(sum(Tin_data.EstimatedRevenue_USD_))])
disp(['Total impressions (millions): ',num2str(sum(Tin_data.Impressions/1000000))])
disp(['Total video duration (days):  ',num2str(sum(Tin_data.VideoDuration_sec/60/60/24))])

%% Plots
%Pie charts showing channel content
classifications = Tin_grouped.Classification;

% Create pie charts
t = tiledlayout(3,3,'TileSpacing','compact');
ax1 = nexttile;
pie(ax1,Tin_grouped.ClassNumberVideos)
title('Number Videos')

ax2 = nexttile;
pie(ax2,Tin_grouped.ClassViews)
title('Views')

ax3 = nexttile;
pie(ax3,Tin_grouped.ClassWatchTime_hr)
title('Watch Time')

ax4 = nexttile;
pie(ax4,Tin_grouped.ClassSubscribers)
title('Subscribers')

ax5 = nexttile;
pie(ax5,Tin_grouped.ClassRevenue_USD)
title('Revenue')

ax6 = nexttile;
pie(ax6,Tin_grouped.ClassImpressions)
title('Impressions')

ax7 = nexttile;
pie(ax7,Tin_grouped.ClassVideoDuration_hr)
title('Video Duration')

lgd = legend(classifications);
lgd.Layout.Tile = 'east';

%% Create a temporary Table for display purposes only
numVideos_percentage        = Tin_grouped.ClassNumberVideos_percentage;
views_percentage            = Tin_grouped.ClassViews_percentage;
watchTimeHr_percentage      = Tin_grouped.ClassWatchTime_hr_percentage;
subscribers_percentage      = Tin_grouped.ClassSubscribers_percentage;
revenue_percentage          = Tin_grouped.ClassRevenue_USD_percentage;
impression_percentage       = Tin_grouped.ClassImpressions_percentage;
videoDurationHr_percentage  = Tin_grouped.ClassVideoDuration_hr_percentage;

T = table(classifications,...
    numVideos_percentage,...
    views_percentage,...
    watchTimeHr_percentage,...
    subscribers_percentage,...
    revenue_percentage,...
    impression_percentage,...
    videoDurationHr_percentage)