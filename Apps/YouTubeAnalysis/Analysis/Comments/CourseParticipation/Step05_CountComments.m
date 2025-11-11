%Count comments for each student
%
%Christopher Lum
%lum@uw.edu

%Version History
%11/06/25: Created

clear
clc
close all

tic

ChangeWorkingDirectoryToThisLocation();

%% User preferences
classListFile   = 'C:\Users\chris\OneDrive\Documents\teaching\ae501_25\class_list_ae501_25.xlsx';

Step04File = 'Step04_FlattenComments.xlsx';

outputFile = 'Step05_CountComments.xlsx';

%% Load data
T = ImportClassListSpreadsheet(classListFile)

return
% T = readtable(Step04File);

%% Process data
%Remove empty entries
indices = find(cellfun(@strlength,T.Name)>0);
T2 = T(indices,:);

[M,~] = size(T2);
disp(['Num Students: ',num2str(M)])

%For each student, search for their comments.  The output of the process is
%a flat table with each row of TCommentsFiltered appended
NameFlat = {};

T_total = table();
for k=1:M
    Name_k                      = T2.Name{k};
    YouTubeCommentSubstring_k   = T2.YouTubeCommentSubstring{k};

    if(strcmp(YouTubeCommentSubstring_k,'AE501_KC'))
        d = 1;
    end

    %filter to only comments which have the substring inside of T2
    indicesB = contains(TCommentsFiltered.Comment,YouTubeCommentSubstring_k);
    TStudentComment = TCommentsFiltered(indicesB,:);

    [N,~] = size(TStudentComment);

    if(N>0)
        d = 1;
    end

    T_k = table('Size',[N,1],...
        'VariableTypes', {'string'}, ...
          'VariableNames', {'Name'});

    T_k.Name(:) = Name_k;

    T_StudentComment_k = [T_k TStudentComment];
    
    T_total = [T_total;
        T_StudentComment_k];    
end

%% Save data
delete(outputFile)
writetable(T_total,outputFile);
disp(['Saved to ',outputFile])

toc
disp('DONE!')