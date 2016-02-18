function [ UHam ] = UnitHam( eps, beta, dim )
%Returns dim dimensional Unitary time Evolution to given epsilon and beta
%AND the Hamiltonian used

% Physics: Hamiltonian
  
%This is the Hamiltonian we work with
% Magnetic Field is always on, there is arbitrary interaction between 12, 23, 34
%this needs to change if we have another hamiltonian
%DB ca 30-80 MHz ca a few mT

M_B21 = 4*eye(6);
M_B21(1:3,1:3) = -1*M_B21(1:3,1:3);

M_B32 = zeros(6);
M_B32(1,1)=-4;
M_B32(6,6)=4;

M_B43 = 4*eye(6);
M_B43(1:2,1:2) = -1*M_B43(1:2,1:2);
M_B43(4,4)=-1*M_B43(4,4);

M_J21 = zeros(6);
M_J21(2:3,2:3)=-[2 0;0 2];
M_J21(2:3,4:5)=[2 0;0 2];
M_J21(4:5,2:3)=[2 0;0 2];
M_J21(4:5,4:5)=-[2 0;0 2];

M_J32= zeros(6);
M_J32(1:2,1:2)=[-2 2;2 -2];
M_J32(5:6,5:6)=[-2 2;2 -2];

M_J43= zeros(6);
M_J43(2:3,2:3)=[-2 2;2 -2];
M_J43(4:5,4:5)=[-2 2;2 -2];





%Components
%Magnetic Component
H6_beta = @(DB21, DB32, DB43)  1/2*(DB21/4  * M_B21 + DB32/2  * M_B32 + DB43/4  * M_B43);%/2 because beta/2 in Bz
%J Component
H6_eps = @(e12,e23,e34) (e12/4 * M_J21 + e23/4 * M_J32 + e34/4 * M_J43);



%Full i-th timestep Hamiltonian (Just add Components)
H6_i = @(e12,e23,e34,DB21,DB32,DB43) H6_beta(DB21,DB32,DB43)+H6_eps(e12,e23,e34);


%if this condition is fulfilled, it just means i want to know which
%hamiltonian i use
if isempty(eps)  && isempty(beta) && dim == -1   
    UHam = H6_i;
    return    
end











%this needs to change if we determine the unitaries differently
%for now, I use expm
%Create Hamiltonian from the beta,epsilon matrices with 
%H_i is the per timestep constant hamiltonian(will be the H6_i hamiltonian)
%inputs eps und beta
%input dimension 6 output dimension 4,6 respectively
UnitaryHam = @(H_i,eps,beta,dim) Generate_Product(H_i,eps,beta,6,dim);



%Now, lets actually compute the Full Unitary to the Hamiltonian

if dim == 4 || dim == 6
    UHam = UnitaryHam(H6_i,eps,beta,dim);
else
    error('wrong dimension input to generate hamiltonian')
    
end






end

