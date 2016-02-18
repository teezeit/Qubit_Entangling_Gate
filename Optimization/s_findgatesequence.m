function [] =s_findgatesequence(tsteps,Bgradients,amountruns)  
%% s_findgatesequence
% this script tries to find a gate sequence of epsilons for a specified
% 1)amount of timesteps
% 2)magnetic field in [MHz] formatted as a [B21 B32 B43] vector
% 3)amount of starting point values
%
% Further Information:
% uses 6 Dimensional Hamiltonian and the fit suite to minimize


%% Initialization
%get the fitsuite (uncomment if done before or if you have your own copy)
% addpath(genpath('Y:\GaAs\Code\'))
% import util.*
     
%Timestep for Runtime        
formatOut = 'yyyymmdd-HHMM';
begintime=datestr(now,formatOut);







%% Start Parameters

%delta t per timestep in [ns]
nanosec = 2; 
beta_const = nanosec*Bgradients/1000;  %beta = B[MHz]*delta t [ns] {Divide by 1000 to take into account MHz*ns = 10^6*10^-9=10^-3}
  

%Define the Parameters of the optimization
args.paramsStart.nbins       = tsteps;                             %amount of time evolutions
args.paramsStart.nanosec     = 2;                                  %time per evolution
args.paramsStart.beta        = beta_const;                         %beta is the magnetic field gradient
args.paramsStart.eps         = ones(tsteps,3);                     %Input matrix to give dimension to J

%Choose whiche Parameters to fit.(1 means fit)
args.paramsMask.eps         = ones(tsteps*3,1);                    %Fit all epsilons
% args.paramsMask.beta      = ones(3,1);%[1 1 1];                  %Activate to optimize beta as well

%Add Bounds to epsilon
args.lowerBounds.eps        = 0.05*ones(tsteps*3,1);               %0.05 corresponds to 25 MHz since  eps = J*t  
args.upperBounds.eps        = 0.5 *ones(tsteps*3,1);               %0.50 corresponds to 250 MHz since eps = J*t
%Add Bounds to beta
% args.lowerBounds.beta =  beta0_D(:)-0.001;%-1*ones(3,3); %zeros(1,3);%[0 0 0];   
% args.upperBounds.beta =  beta0_D(:)+0.001;% ones(3,3);%[1 1 1];



%% Set up Data and solver

%Objective Functions and Constraints
%Objective Function
F = @(args) ObjFct_Distance(args,'data');  %% F = @(args) ObjFct_Jsquare(args) is also a possibility

%Constraint Functions
% ineq_con = @(X) 0;                                        %-1e-7;%<=0 inequality constraint                               
% eq_con = @(X)  ObjFct_Distance(X,args.paramsStart);       %=0         equality contraint
eq_con          = @(X) 0;
Con             = @(X) deal([[],eq_con(X)]);
args.nonlcon    = Con;

%Optimization Arguments
args.data               = zeros(4,8);                        %our "data"
args.verbosity          = [0 0 0];                           %### text figures warnings
args.optimPlotFcn       = [];                                %Do not plot during optimization
args.nStartPoints       = amountruns;                        %start points
args.parallel           = 1;                                %use parallel computing
args.cluster            = 'local';                          %cluster profile


%Additional arguments to give to fitsuite, see at the end of this file



%Technical Stuff
solver                  = 'fsolve';%'fmincon';%              %solver
%fsolve algorithms: 'trust-region-dogleg','trust-region-reflective', or'levenberg-marquardt'
%fmincon algorithms  interior-point > sqp > active-set
algorithm               = 'levenberg-marquardt';
optimOptions            = optimset(solver);                  %solver
%Tune Specifics
%standard tol 1e-6 'TolCon' = 1e-6;
%standard maximal function evals3600
%standard maxIter 400
optimOptions            = optimset(optimOptions,...
                          'TolX',           1e-15,...
                          'TolFun',         1e-10,...
                          'MaxFunEvals',    50000,...
                          'MaxIter',        5000,...
                          'algorithm',      algorithm);    %options
optimOptions.solverName = solver;                          %solver


%% Perform the Fit


%##########################################################################
import util.*                             %load the package
result = fit_suite(F,optimOptions,args);  %This is where the magic happens
%##########################################################################









%% Postprocessing


%Add additional parameters to the result

result = AlterParameters(result);

%Store Timpestamp
stamp=datestr(now,formatOut);
result.begintime = begintime;
result.endtime = stamp;

%% Save the Result

%Adjust Bgradient input
if size(Bgradients,1)==1
    Bgradient_strings = num2str(Bgradients,'%+.1f_');
else
    Bgradient_strings = '___';
end

%Adjust location to save results
if exist('./../Results/CPHASE/','dir') == 7
    place = './../Results/CPHASE/' ;
else
    place = './';
end




% Save the result of the optimisation
save([place                                             ... %folder
    stamp                                               ... %timestamp
    '-CPHASE-'                                          ... %project
    num2str(args.nStartPoints) '_startpoints-'          ... %amount of startpoints
    num2str(args.paramsStart.nbins) '_bins-'            ... %amount of bins(time evolutions)
    num2str(nanosec) '_ns-_'                            ... %ns per step
    Bgradient_strings 'Bgrads.mat'                      ... %Betas                       
    ],'result');                                        ... %Save only variable result



end




%{
%% Options to pass to fit_suite via struct args.
% --- Setting default options ---------------------------------------------
defaultArgs = struct( ...
  'opt', true, ...
  'sim', false, ...
  'paramsSim', struct(), ...      % struct of params used to simulate model
  'paramsStart', struct(), ...    % struct of params used to start optimization
  'paramsMask', struct(), ...     % which params are variable, struct contains mask with zeros and ones in each field with same names as in paramsSim and paramsStart
  'lowerBounds', struct(),...     % can be struct with same fields as paramsStart 
  'upperBounds', struct(),...     % or simply a number to multiply paramsStart(1) with
  'bounds', 1, ...
  'manual', 0, ... % Show a GUI that helps finding good start values
  'Aeq', [], ... % described in documentation of createOptimProblem
  'Aineq', [], ... % described in documentation of createOptimProblem
  'beq', [], ...  % described in documentation of createOptimProblem
  'bineq', [], ... % described in documentation of createOptimProblem
  'nonlcon', [], ...  % described in documentation of createOptimProblem
  'data', [], ...           % data to which to fit to (same format as output of modelFn)
  'dataMask', [], ...         % which data points to ignore completely
  'dataWeights', [], ...       % weights for each data point (could be 1/sigma^2 for example)
  'parallel', 0, ...        % parallel computation
  'cluster', 'local', ...   % cluster (neede for parallel computation)
  'nStartPoints', 1, ... % bounds need to be specified since random values created within bounds, but by setting bounds = 0 these are only used for starting value creation
  ... % implement addition of random values to paramsStart  
  'optimOutputFcn', [], ...
  'optimPlotFcn', {{@optimplotx; @optimplotfunccount; @optimplotfval; @optimplotresnorm; @optimplotfirstorderopt; @optimplotstepsize; @optimplotresnorm; @optimplotconstrviolation}}, ...
  'sep', nan, ...
  'plotFn', @plot_image, ... % plot function (gets all parameters and data)
  'plotFigs', [1 1 1], ... 
  'multiStart', [], ... % multiStart Object (not for fsolve and nlinfit)
  'globalSearch', [], ... % globalSearch Object (only for fmincon)
  'initFn', {{}}, ... % pass function names as strings if defined in fit_suite
  'figNum', 101, ... % -1 opens new figure every time
  'rngInit', 'shuffle', ...
  'verbosity', [1 1 1] ... % ### = text, figures, warnings
  );
%}




