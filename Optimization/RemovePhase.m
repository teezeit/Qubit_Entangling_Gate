function [ H ] = RemovePhase( H,varargin )
%Remove Phase from varargin
%'det' Determinant (default)
%or
%'first' First Column Entry



nVarargs = length(varargin);

if nVarargs == 0
       
    where = 'det';
elseif nVarargs ==1
    
    where = varargin{1};
    
else
    error('too much variable input');
end



if strcmp(where,'det')
    
    
    %this removes phase of determinat
    %normalize H so that it has
    %unit determinant. 
    
    %only works for rows=columns
    n = size(H,1);
    
    rootnth = det(H)^(1/n);
    if(abs(rootnth-1)>1e-8)
        H = H/rootnth;
    end

elseif strcmp(where,'first')
     
    %this removes the phase of the first element (useful for the 4x4 matrices)
    H= H/exp(1i*angle(H(1,1)));
    
elseif strcmp(where,'second')
    
    %this removes the phase of the second element (useful for the 6x6 matrices)
    H= H/exp(1i*angle(H(2,2)));
        
else
    error('wrong entry to remove phase')
    
end




end

