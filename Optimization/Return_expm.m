function [ U ] = Return_expm( M )
%Return_expm Returns the Unitary Matrix exponential of M
U = expm(-2*pi*1i*M);

%exp(-i*H*t) = (1-1/2*i*H*t)(1+1/2*i*H*t)^-1
% U = (1-1/2*1i*M*2*pi)*(1+1/2*1i*M*2*pi)^(-1);
end

