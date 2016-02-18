Tobias Hoelzer. 2015.

This code finds a 3 dimensional microwave sequence
to perform a CPHASE entangling gate 
with a 6 dimensional hamiltonian
in a 2 qubit singlet-triplet  system
with 4 electrons
using the +util fit suite (not written by me).

Applying those Gate Sequences will entangle two Qubits + add an imaginary phase.
How fucking cool is that?


######## BACKGROUND ########


Hamiltonian per timestep i depends on the microwaves e and the
magnetic field gradients between each quantum dot.
-> H_i([e_12_i,e_23_i,e_34_i],[b_12,b_23,_b_34])
I assume b's to be constant during the experiment
-> H_{i,b_12,b_23,b34}([e_12_i,e_23_i,e_34_i])
I allow different amount of timesteps T. for the experiment
The Unitary Operator can be estimated by assuming a timewise constant Hamiltonian.
So U becomes the Product of all timewise constant Hamiltonians
-> U = PRODUCT_{i=1 to T} [exp(-2*i*pi*H_i)]
I am looking for an Unitary Operator that acts as an Entangler, such as CPHASE
-> CPHASE = sqrt(2)/2* [1+1i 0 0 0; 0 1+1i 0 0 ; 0 0 1+1i 0 ; 0 0 0 -1-1i];


tldr;
For a given amount of timesteps T and a given Magnetic Field [b_12,_b23_b34], I am looking for 
a Tx3 dimensional vector of [e_12, e_23, e_34] that solves:

U = PRODUCT_{i=1 to T} [exp(-2*i*pi*H_{i,[b_12,_b23_b34]}(e_12_i,e_23_i,e_34_i))] = CPHASE = sqrt(2)/2* [1+1i 0 0 0; 0 1+1i 0 0 ; 0 0 1+1i 0 ; 0 0 0 -1-1i];



######## QUICKSTART GUIDE ########

1) Run ./Optimization/s_MAIN_RUN_OPTIMIZATION.m
[set magnetic field and allow different amount of timesteps]

2) Load the Solution from ./Results

3) Analyze the Data with ./Analysis/ShowRun.m

4) See the Real and Imaginary part of the CPHASE Matrix in ./Plots


