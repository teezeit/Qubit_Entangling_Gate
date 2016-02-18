%SCRIPT MAIN RUN OPTIMIZATION
%Running this script runs an optimization looking for Microwave Gate Sequences
%which entangle two qubits of a Singlet-Triplet Electron System

%Tobias Hoelzer. 2015


%MAIN: Runs the Minimization for different steps, betas and amountofruns
%Steps is the amount of time evolutions allowed for the Hamiltonian
%Betas correspond to the Magnetic Field at the Qubits
%Amountruns is the amount of startpoints for the optimization

%Details of the optimization are specified in s_findgatesequence

close all
clear all vars



% Magnetic Field big - + -

%1
Analyse(1).steps      = 8;
Analyse(1).betas      = [0.125 -0.125 0.125];
Analyse(1).amountruns = 1000;
% 
% %2
% Analyse(end+1).steps     = 10;
% Analyse(end).betas       = [0.125 -0.125 0.125];
% Analyse(end).amountruns  = 1500;
% 
% %3
% Analyse(end+1).steps     = 12;
% Analyse(end).betas       = [0.125 -0.125 0.125];
% Analyse(end).amountruns  = 2000;
% 
% %4
% Analyse(end+1).steps     = 14;
% Analyse(end).betas       = [0.125 -0.125 0.125];
% Analyse(end).amountruns  = 2500;

%5
Analyse(end+1).steps     = 16;
Analyse(end).betas       = [0.125 -0.125 0.125];
Analyse(end).amountruns  = 1000;

% %6
% Analyse(end+1).steps     = 18;
% Analyse(end).betas       = [0.125 -0.125 0.125];
% Analyse(end).amountruns  = 3000;
% 
% %7
% Analyse(end+1).steps     = 20;
% Analyse(end).betas       = [0.125 -0.125 0.125];
% Analyse(end).amountruns  = 3000;
% 
% %8
% Analyse(end+1).steps     = 24;
% Analyse(end).betas       = [0.125 -0.125 0.125];
% Analyse(end).amountruns  = 3000;





    %Open Parallel
    parpool('local');
    %Parallel For
    parfor i = 1:size(Analyse,2)
                s_findgatesequence(Analyse(i).steps,Analyse(i).betas,Analyse(i).amountruns);
    end
    %Close Parallel
    delete(gcp);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
