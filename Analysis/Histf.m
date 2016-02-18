function [] = Histf( result,varargin)
%Plots a Histogram of the function Values of the Run& varargin bins

figure

fnorms = sqrt(sum(abs([result.runs.f]).^2,1));


if isempty(varargin)
    hist(fnorms)
else
    hist(fnorms,varargin{1})
end

title('minimization values');
xlabel('log | f |');
ylabel('amount');

set(gca,'xscale','log')

fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',22);


end

