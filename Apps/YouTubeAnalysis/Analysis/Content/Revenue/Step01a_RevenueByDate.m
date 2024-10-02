%Analyze revenue by date
%
%Christopher Lum
%lum@uw.edu

%Version History
%10/01/24: Created

clear
clc
close all

tic

ChangeWorkingDirectoryToThisLocation();

%% User selections
%Input file(s)
totalsDataFile   = [ReturnPathStringNLevelsUp(3),'\Data\Content\Revenue\Content 2010-09-01_2024-10-01 Christopher Lum\Totals.csv'];

%Output file(s)
revenueDataFile = 'Step01a_RevenueByDate.xlsx';

%Start date (dates before this have no revenue)
startDate = datetime(2019,4,7);

%% Import data
% videoInfoTable  = readtable(videoInfoFile);
totalsDataTable  = readtable(totalsDataFile);

%% Analysis
%Find all date on or after startDate;
[~,indices] = DatetimeManipulator.FindDatesOnOrAfter(totalsDataTable.Date,startDate);
T = totalsDataTable(indices,:);
T = sortrows(T,'Date');

dates = T.Date;
revenue_USD = T.EstimatedRevenue_USD_;

%Total revenue
totalRevenue_USD = sum(revenue_USD);
disp(['Total Revenue: ',num2str(totalRevenue_USD)])

%% Plot

figure;
plot(dates,revenue_USD,'LineWidth',2,'DisplayName',['Total Revenue = ',num2str(totalRevenue_USD)])
grid on
xlabel('Date')
ylabel('Revenue (USD)')
legend()

%% Write output table
writetable(T,revenueDataFile);
disp(['Wrote data to ',revenueDataFile])

toc
disp('DONE!')