function [] = Plotf_withdeltabeta( Result_Array)
%Plots a Histogram of the function Values of the Run& varargin bins

figure


hold all
modifycolororder





for j=1:length(Result_Array)
   
    for k=1:length(Result_Array{j}.runs)
    
  args=Result_Array{j}.runs(k).params;  
  args.beta=args.beta+0.5*[0.0125 0 0];
  Result_Array{j}.runs(k).fdeltas(1)= ObjFct_Distance(args,'singlevalue');
  args=Result_Array{j}.runs(k).params;  
  args.beta=args.beta-0.5*[0.0125 0 0];
  Result_Array{j}.runs(k).fdeltas(2)= ObjFct_Distance(args,'singlevalue');
  
  args=Result_Array{j}.runs(k).params;  
  args.beta=args.beta+0.5*[0 0.0125 0];
  Result_Array{j}.runs(k).fdeltas(3)= ObjFct_Distance(args,'singlevalue');
  args=Result_Array{j}.runs(k).params;  
  args.beta=args.beta-0.5*[0 0.0125 0];
  Result_Array{j}.runs(k).fdeltas(4)= ObjFct_Distance(args,'singlevalue');  
  
  args=Result_Array{j}.runs(k).params;  
  args.beta=args.beta+0.5*[0 0 0.0125];
  Result_Array{j}.runs(k).fdeltas(5)= ObjFct_Distance(args,'singlevalue');
  args=Result_Array{j}.runs(k).params;  
  args.beta=args.beta-0.5*[0 0 0.0125];
  Result_Array{j}.runs(k).fdeltas(6)= ObjFct_Distance(args,'singlevalue');  
    
    
    Result_Array{j}.runs(k).fdmax= max(Result_Array{j}.runs(k).fdeltas);
%     Result_Array{j}.runs(k).fdmaxdelta = abs(Result_Array{j}.runs(k).fdmax-sqrt(sum(abs([Result_Array{j}.runs(k).f]).^2,1)));
    end

fnorms = [Result_Array{j}.runs.fdmax];

run = 1:length(Result_Array{j}.runs);

percentile = (1:length(Result_Array{j}.runs))*100/length(Result_Array{j}.runs);
plot(percentile,fnorms,'.');



legendentry{j}=[ num2str(Result_Array{j}.runs(1).params.nbins) ' steps'];
end








grid on;
% set(gca,'yscale','log')
title('minimization values');
xlabel('percentile');
ylabel('max | f | with \Delta\beta=5%');
legend(legendentry,'Location','SouthEast');



fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',22);

end

