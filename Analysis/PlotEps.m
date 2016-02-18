function [  ] = PlotEps( run )
% Plots the proposed solutions of the epsilons doing the gate


figure
hold all




steps = [];
eps1 = [];
eps2 = [];
eps3 = [];
for i=1:run.params.nbins

steps = [steps i i+0.9999 ];
eps1  = [eps1 ; run.params.eps(i,1) ; run.params.eps(i,1)];
eps2  = [eps2 ; run.params.eps(i,2) ; run.params.eps(i,2)];
eps3  = [eps3 ; run.params.eps(i,3) ; run.params.eps(i,3)];

if i == run.params.nbins
   steps(end+1) = i+1;
   eps1(end+1)  = 0;
   eps2(end+1)  = 0; 
   eps3(end+1)  = 0;
end


end


lw = 2;

plot(steps,eps1,'--ob','LineWidth',lw);
plot(steps,eps2+0.5,'--*k','LineWidth',lw);
plot(steps,eps3+1,'--xr','LineWidth',lw);




ylim([0 2]);
grid on;



if size(run.params.beta,1)==1
b1 = num2str(run.params.beta(1),'%1.3G');
b2 = num2str(run.params.beta(2),'%1.3G');
b3 = num2str(run.params.beta(3),'%1.3G');
end

lentry1 = ['      \epsilon_{12} = Left.     |  \beta_{12} = ' b1 ];
lentry2 = ['0.5+\epsilon_{23} = Middle. |  \beta_{23} = ' b2 ];
lentry3 = ['1+   \epsilon_{34} = Right.   |  \beta_{34} = ' b3 ];


title('J \cdot t = \epsilon - Pulses','FontSize',24);



xlabel('timesteps','FontSize',24);
ax.YTick = [];
ylabel('\epsilon = J \cdot t','FontSize',24);
legend(lentry1,lentry2,lentry3);

jsquared= num2str(run.jsqrt,'%.0f ');

annotation('textbox',[0.15 0.8 0.1 0.1],'String',['[\Sigma J^2 t]_{21,32,43} = [' jsquared '] MHz' ],'FontSize',24);


fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',26);



end

