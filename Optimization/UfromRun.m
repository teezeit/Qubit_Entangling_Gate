function [ U ] = UfromRun( Run )
%Gives the Unitary to the Variables found in given Run


    
    eps_sol = Run.params.eps;
    b_sol = Run.params.beta;
    
    U = UnitHam(eps_sol,b_sol,6) ;
    

end

