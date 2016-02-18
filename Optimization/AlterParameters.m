function [ result ] = AlterParameters( result )
% AlterParameters
% Alters parameters of the result.
% Removes pAll because it is to 
% Adds the Matrix found by the solution
% Adds the nice formatted Matrix(without phase) found by the solution
% Adds the epsilon in proper format
% Sorts the results by their function value



% remove pAll because its too big to store (just for fmincon i think)
if isfield(result.runs,'pAll')
     for i = 1:length(result.runs)
        result.runs(i).pAll= [];
     end
end


%for all runs
for i = 1:length(result.runs)
    %Calculate the  Unitaries 
    result.runs(i).U = UfromRun(result.runs(i)); 
    %and the unitary with the phase removed from the 2,2 element
    result.runs(i).Unice = RemovePhase(result.runs(i).U,'second');
          
end

%Add jsquared to to all the runs
result= AddJsquaredT( result );

%sort runs
result = sortresult(result);






end

