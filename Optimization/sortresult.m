function [ result ] = sortresult( result )
%sorts results by norm of f vector



%sort all the norms
[~ , index] = sort(sum(abs([result.runs.f]),1));



sortedruns(length(result.runs))=result.runs(1);


for i=1:length(result.runs)
   sortedruns(i)=result.runs(index(i)); 
end

result.runs = [];
result.runs = sortedruns;











end

