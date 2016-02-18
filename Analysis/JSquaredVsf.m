function [] = JSquaredVsf( resultarray,varargin)
%Plots a Histogram of the function Values of the Run& varargin{1} begin of
%run to plot varargin{2} end of run to plot
%Enter results as an array {result1, result2,...}




figure


hold all
modifycolororder

for j=1:length(resultarray)


fnorms = sqrt(sum(abs([resultarray{j}.runs.f]).^2,1));

if isempty(varargin)
    
    %best 1000 runs
    %if less than 1000 take max runs
    if length(resultarray{j}.runs) >= 1000
        amount = 1000;
    else
        amount = length(resultarray{j}.runs);
    end
        
   
        jsquared =zeros(amount,1);
        for i=1:amount
            jsquared(i)=sum(resultarray{j}.runs(i).jsqrt)/3;
        end

        x = jsquared;
        y = fnorms(1:amount);
    
   
        
       
   
    
elseif length(varargin)==2
    
    beginrun = varargin{1};
    endrun   = varargin{2};
    dif = endrun-beginrun+1;
    
    
    jsquared = zeros(dif,1);
    
    for i=1:dif
        jsquared(i)=resultarray{j}.runs(beginrun).jsqrt/3;
        beginrun=beginrun+1;
    end
      
    x = jsquared;
    y = fnorms([varargin{1}:varargin{2}]);
       
        
   

    
else
   error('too much varargin input');

end


legendentry{j}=[ num2str(resultarray{j}.runs(1).params.nbins) ' steps'];

   plot(x,y,'.');

   
end

set(gca,'yscale','log')

grid on;
title('Jsquared*t VS. log | f | ');
xlabel('Jsquared*t/3 [MHz]');
ylabel('log | f |');

legend(legendentry,'Location','NorthEast');


fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',24);




end

