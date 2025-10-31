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

Step02File = 'Step02_FilterComments.mat';   %get the substring
outputFile = 'Step03_GenerateYouTubeIdSubstring.xlsx';

%% Load data
T = ImportClassListSpreadsheetNames(classListFile);

temp = load(Step02File);
substring = temp.substring;

%% Process data
%Remove empty entries
indices = find(cellfun(@strlength,T.Name)>0);
T2 = T(indices,:);

[M,~] = size(T2);
disp(['Num Students: ',num2str(M)])

%Create a string for each student name
stringIds               = cell(M,1);
manualReviewRequired    = zeros(M,1);
comment                 = cell(M,1);
for k=1:M
    name_k = char(T2.Name{k});

    words = SplitOnDesiredChar(name_k,' ' );

    manualReviewRequired_k = false;
    comment_k = '';
    if(length(words)>=2)
        firstName   = words{1};
        lastName    = words{2};

    elseif(length(words)==1)
        firstName   = words{1};
        lastName    = '';

        manualReviewRequired_k = true;
        comment_k = 'Only 1 word in the name cell';

    else
        firstName   = '';
        lastName    = '';

        manualReviewRequired_k = true;
        comment_k = '0 words in the name cell';
        
    end

    initials_k = [firstName(1),lastName(1)];
    str_k = [substring,initials_k];

    stringIds{k}            = str_k;
    manualReviewRequired(k) = manualReviewRequired_k;
    comment{k}              = comment_k;
end

%Assess if there are duplicates
for k=1:M
    str_k = stringIds{k};

    numMatches = sum(strcmp(stringIds,str_k));

    if(numMatches==0)
        error(['Something went wrong with ',str_k]);

    elseif(numMatches==1)
        %Single match, a unique entry
    else
        %multiple matches
        manualReviewRequired(k) = true;
        comment{k}              = [comment{k},'Not a unique string ID'];
    end
end

stringIdsUnique = unique(categorical(stringIds));
disp(['Number of non-unique entries: ',num2str(length(stringIds)-length(stringIdsUnique))])

%Create an output table
TClassList = table(T2.Name,stringIds,manualReviewRequired,comment);
TClassList.Properties.VariableNames = {
    'Name',
    'StringID',
    'ManualReviewRequired',
    'Comment'
    };

disp('Please review the StringID column, modify if necessary, and input into class list spreadsheet')

%% Save data
delete(outputFile)
writetable(TClassList,outputFile);
disp(['Saved to ',outputFile])

toc
disp('DONE!')