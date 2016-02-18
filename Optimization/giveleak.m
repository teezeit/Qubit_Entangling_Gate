function [ u] = giveleak( U )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

u1 = U(4,[6 7 10 11]).';
u2 = U(13,[6 7 10 11]).';
u3 = U([6 7 10 11],4);
u4 = U([6 7 10 11],13);
u = [u1 ; u2 ; u3 ; u4];



end
