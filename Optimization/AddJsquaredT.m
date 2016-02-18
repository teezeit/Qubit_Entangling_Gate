function [ result ] =   AddJsquaredT( result )
%Adds the integral over J^2*dt to the result

l = length(result.runs);

jsquared = zeros(l,3);

t=2*10^(-9);%s


%eps = J*t. so if we want sum(J^2)*t=sum(eps^2)/t=sum(J^2*t*2)/t we need to  divide by t after squaring
for i=1:l
    jsquared(i,:) = sum((result.runs(i).params.eps).^2,1)/(t*10^6);
    result.runs(i).jsqrt=jsquared(i,:);
end

%this is for jsquared in MHz


end

