function [] = HistIterations( result,varargin)
%Plots a Histogram of the function Values of the Run& varargin{1} begin of
%run to plot varargin{2} end of run to plot




figure



if isempty(varargin)
    
    
    if length(result.runs)>=1000
    %first 1000 exitflags
        amount = 1000;
    else
        amount = lenght(result.runs);
    end
    
    it =zeros(amount,1);
    for i=1:amount
        it(i)=result.runs(i).output.iterations;
    end
    
    
       
    hist(it)
    
elseif length(varargin)==2
    
    it = zeros(varargin{2}-varargin{1},1);
    for i=varargin{1}:varargin{2}
        it(i)=result.runs(i).output.iterations;
    end
      
       
    hist(it)

elseif length(varargin)==3
    
    it = zeros(varargin{2}-varargin{1},1);
    for i=varargin{1}:varargin{2}
        it(i)=result.runs(i).output.iterations;
    end
      
       
    hist(it,varargin{3})
    
    
    
else
   error('too much varargin input');

end







title('Number of Iterations of the Optimization');
xlabel('iterations');
ylabel('amount');


fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',22);




end

