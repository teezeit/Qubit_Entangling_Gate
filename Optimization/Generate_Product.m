function [ U ] = Generate_Product( H_i,eps,beta,varargin)
%Generate_H Generates the Matrix Hamiltonian of H_i to beta and epsilon vectors
% varargin{1} is the input  dimension, 16(default), 6 or 4
% varargin{2} is the output dimension, 16(default), 6 or 4


nVarargs = length(varargin);

if isempty(varargin)      
                indim  = 16;
                outdim = 16;
elseif nVarargs == 1    
                indim = varargin{1};  
                outdim = indim;
elseif nVarargs == 2
                indim = varargin{1};  
                outdim = varargin{2};
elseif nVarags > 2
                error('too much variable input');
end

%This will be the Final Matrix Hamiltonian

%Initialize a Matrix (this is goint to be the unitary time evolution
%operator)
U=eye(indim);

if size(beta,2)==2

                for i = 1 : length(eps(:,1))  
                   Ui = Return_expm(H_i(eps(i,1),eps(i,2),eps(i,3),beta(i,1),beta(i,2)));
                   U = Ui * U;
                end
    
elseif size(beta,2)==3
      
    %If there is a single input, all the betas are the same
    if size(beta,1)== 1
                 for i = 1 : length(eps(:,1)) 
                            Ui = Return_expm(H_i(eps(i,1),eps(i,2),eps(i,3),beta(1,1),beta(1,2),beta(1,3)));
                            U = Ui * U;
                 end
    %otherwise they change in the loop             
    else
                for i = 1 : length(eps(:,1)) 
                    Ui = Return_expm(H_i(eps(i,1),eps(i,2),eps(i,3),beta(i,1),beta(i,2),beta(i,3)));
                    U = Ui * U;
                end
    end
    
else
                error('Size of beta seems to be wrong');
end


if indim ~= outdim
    %cut of the non computational dimensions
    if outdim == 4   
        U = givecomp(U);
    elseif outdim == 6
        U = ReduceDim(U,6);
    end
end


%And remove the phase
U = RemovePhase(U);
    
    
    
    
    
end

