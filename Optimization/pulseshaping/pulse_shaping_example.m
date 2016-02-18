%% Set up pulse shaping using the previous results
load('\\janeway\User Ag Bluhm\Common\GaAs\Cerfontaine\Gates\awg_rise_times\measured_step_response_reduced.mat', 'dStepMeas');
addpath('\\janeway\User Ag Bluhm\Cerfontaine\Software\Common');

%pulseParams = sin(1:23);
%This is what I put into the Generator [Red Colored]
pulseParams =[0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 0 0];
%The last are zero, to include the decay of the last pulse
pulseParams(end+1:end+2) = [0 0];
nseg = length(pulseParams);
% pulseParams = sin(1:nseg);
pulseParams = pulseParams + 1;

clearvars -global ps
global ps;

ps.timeBase = 1;
%Pulses per Step
ps.nRectpulse = 10; % 1000
%Starting Baseline
ps.epsilonBaseline = 1.5; % in eps0
ps.stepResponse = dStepMeas;

ps.fixedValues = zeros(1, nseg+1);
ps.fixedMask = zeros(1, nseg+1);

% ps.fixedValues(15) = 5.05;
% ps.fixedMask(15) = 1;
% ps.fixedValues(18) = 5.05;
% ps.fixedMask(18) = 1;

origPulseParams = pulseParams;
% pulseParams(15) = [];
% pulseParams(18) = [];

% remove this
% if ps.nRectpulse < 10
%   ps.stepResponse = downsample(ps.stepResponse, 10/ps.nRectpulse);
% elseif ps.nRectpulse > 10
%   ps.stepResponse = upsample(ps.stepResponse, ps.nRectpulse/10);
% end;

ps.pulseScale = 1;% 0.985;
[b, a] = butter(1, 1.5e-1/ps.nRectpulse*10,'low');
% [b, a] = butter(1, 1-1e-8,'low');
ps.filterCoeffs = {a, b};

% [pulseParamsShaped, t] = pulse_shape_filter([pulseParams 1]);
[pulseParamsShaped, t] = pulse_shape_filter_fixed_params([pulseParams 1]);

% pulseParamsShaped = downsample(pulseParamsShaped, ps.nRectpulse/5);
% t = downsample(t, ps.nRectpulse/5);

figure
clf
hold on
plot(cumsum(t)-t(1), pulseParamsShaped(1:end-1), 'b-', 'LineWidth', 1);
plot([0 rectpulse(cumsum(t(2:end))-t(1),2) sum(t)-t(1)], [rectpulse(pulseParamsShaped(1:end-1), 2) ], 'k-', 'LineWidth', 1);
plot([0 rectpulse(1:nseg-1, 2) nseg], [rectpulse(origPulseParams, 2) ], 'r-', 'LineWidth', 1);
plot(0:nseg-1, origPulseParams, 'rx', 'LineWidth', 1);