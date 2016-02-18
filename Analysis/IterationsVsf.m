function [] = IterationsVsf( resultarray,varargin)
%Plots a Histogram of the function Values of the Run& varargin{1} begin of
%run to plot varargin{2} end of run to plot




figure


hold all
modifycolororder

for j=1:length(resultarray)


fnorms = sqrt(sum(abs([resultarray{j}.runs.f]).^2,1));

if isempty(varargin)
    
    if length(resultarray{j}.runs)>=1000
        amount=1000;
    else
        amount = length(resultarray{j}.runs);
    end
    
    
    %best 1000 runs
    it =zeros(amount,1);
    for i=1:amount
        it(i)=resultarray{j}.runs(i).output.iterations;
    end
    
    x = it;
    y = fnorms(1:amount);
       
   
    
elseif length(varargin)==2
    
    beginrun = varargin{1};
    endrun   = varargin{2};
    dif = endrun-beginrun+1;
    
    
    it = zeros(dif,1);
    
    for i=1:dif
        it(i)=resultarray{j}.runs(beginrun).output.iterations;
        beginrun=beginrun+1;
    end
      
    x = it;
    y = fnorms([varargin{1}:varargin{2}]);
       
        
   

    
else
   error('too much varargin input');

end


legendentry{j}=[ num2str(resultarray{j}.runs(1).params.nbins) ' steps'];

   plot(x,y,'.');


   
end

set(gca,'yscale','log')

grid on;
title('Number of Iterations VS. log | f | ');
xlabel('iterations');
ylabel('log | f |');

legend(legendentry,'Location','SouthEast');


fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',22);




end

