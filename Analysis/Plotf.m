function [] = Plotf( Result_Array)
%Plots a Histogram of the function Values of the Run& varargin bins

figure


hold all
modifycolororder





for j=1:length(Result_Array)
    

fnorms = sqrt(sum(abs([Result_Array{j}.runs.f]).^2,1));

run = 1:length(Result_Array{j}.runs);

percentile = (1:length(Result_Array{j}.runs))*100/length(Result_Array{j}.runs);
plot(percentile,fnorms);



legendentry{j}=[ num2str(Result_Array{j}.runs(1).params.nbins) ' steps'];
end








grid on;
set(gca,'yscale','log')
title('minimization values');
xlabel('percentile');
ylabel('log | f |');
legend(legendentry,'Location','SouthEast');



fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',22);

end

