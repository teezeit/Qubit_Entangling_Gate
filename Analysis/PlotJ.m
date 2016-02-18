function [  ] = PlotJ( run )
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

%Map eps auf J in MHz
J1=1000/run.params.nanosec*eps1;
J2=1000/run.params.nanosec*eps2;
J3=1000/run.params.nanosec*eps3;
end

steps=steps*run.params.nanosec;

ylim([0 1000]);
lw = 2;

plot(steps,J1,'--ob','LineWidth',lw);
plot(steps,250+J2,'--*k','LineWidth',lw);
plot(steps,500+J3,'--xr','LineWidth',lw);





grid on;



if size(run.params.beta,1)==1
b1 = num2str(1/run.params.nanosec*1000*run.params.beta(1),'%1.3G');
b2 = num2str(1/run.params.nanosec*1000*run.params.beta(2),'%1.3G');
b3 = num2str(1/run.params.nanosec*1000*run.params.beta(3),'%1.3G');
end

lentry1 = ['J_{12} [MHz] = Left.     |  Bg_{12} = ' b1 ' [MHz]'];
lentry2 = ['250+J_{23} [MHz] = Middle. |  Bg_{23} = ' b2 ' [MHz]'];
lentry3 = ['500+J_{34}  [MHz] = Right.   |  Bg_{34} = ' b3 ' [MHz]'];


title('J  - Pulses','FontSize',24);



xlabel('timesteps [ns]','FontSize',24);
ax.YTick = [];
ylabel('J [MHz]','FontSize',24);
legend(lentry1,lentry2,lentry3);

jsquared= num2str(run.jsqrt,'%.0f ');

annotation('textbox',[0.15 0.8 0.1 0.1],'String',['[\Sigma J^2 t]_{21,32,43} = [' jsquared '] MHz' ],'FontSize',24);


fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',26);



end

