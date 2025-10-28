%Pull information from class list file to generate strings that are unique
%to each student.
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
classListFile = 'C:\Users\chris\OneDrive\Documents\teaching\ae501_25\class_list_ae501_25.xlsx';

outputFile = 'Step03_ProcessClassList.xlsx';

%% Load data
T = ImportClassListSpreadsheetNames(classListFile);

%% Process data
%Remove empty entries
indices = find(cellfun(@strlength,T.Name)>0);
T2 = T(indices,:);

[M,~] = size(T2);
disp(['Num Students: ',num2str(M)])

%Create a string for each student name
for k=1:M
    name_k = 
end



%% Save data
save(outputFile,'Tf');
disp(['Saved to ',outputFile])

toc
disp('DONE!')