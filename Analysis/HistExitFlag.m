function [] = HistExitFlag( result,varargin)
%Plots a Histogram of the function Values of the Run& varargin{1} vector of
%runs to plot




figure



if isempty(varargin)
    
    if length(result.runs)>=1000
    %first 1000 exitflags
    exitflags = [result.runs(1:1000).exitflag];
    else
    exitflags = [result.runs(1:length(result.runs)).exitflag];
    end
    hist(exitflags)
    
    
elseif length(varargin)==1
    
    exitflags = [result.runs(varargin{1}).exitflag];    
    hist(exitflags)


else
   error('toomuch varargin input');

end







title('Exitflags of the best 1000 runs');
xlabel('exitflag');
ylabel('amount');

fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',22);

Exitflagdescription = { '1  function converged to solution';...
                        '2  Change in x was smaller than the specified tolerance';...
                        '3  Change in the residual was smaller than the specified tolerance';...
                        '4  Magnitude of search direction was smaller than the specified tolerance';...
                        '0  Number of iterations exceeded options.MaxIter or number of function evaluations exceeded options.MaxFunEvals.';...
                        '-1 Output function terminated the algorithm';...
                        '-2 Algorithm appears to be converging to a point that is not a root';...
                        '-3 Trust region radius became too small (trust-region-dogleg algorithm)';...
                        '-4 Line search cannot sufficiently decrease the residual along the current search direction';...                     
                        };


% annotation('textbox', [0, 0.5, 0, 0], 'string', Exitflagdescription) 










end

