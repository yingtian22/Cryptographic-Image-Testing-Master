%Chebyshev混沌
function [outputArg1] = ChebyshevChaos(u,x0,length)
l(1)=x0;
for i=1:length-1
    l(i+1)=cos((u+1)*acos(l(i)));
end
