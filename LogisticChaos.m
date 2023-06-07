%Logistic混沌
function [outputArg1] = LogisticChaos(u,x0,length)
l(1)=x0;
for i=1:length-1
    l(i+1)=u*l(i)*(1-l(i));
end
