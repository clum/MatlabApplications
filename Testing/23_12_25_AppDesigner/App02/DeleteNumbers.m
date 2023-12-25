function [CorrectNumbers] = DeleteNumbers(WrongNumber,NumbersCalled)

%Delete numbers that weren't supposed to be there
%Started 12/23/23

keepIndices = [];
for k=1:length(NumbersCalled)
    CurrentNum=NumbersCalled(k);
    
    %Checking if the current number is the wrong one
    if (CurrentNum==WrongNumber)
        %delete wrong number
    else
        %keep current number, it's correct.
        keepIndices(end+1) = k;
    end
   
end

%Translate from indices back to values
CorrectNumbers = NumbersCalled(keepIndices);