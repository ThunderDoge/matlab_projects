function [net,tr] = genrbfnet(X, Y, Z, N, StepN)
x1 = reshape(X,1,[]);
x2 = reshape(Y,1,[]);

obsv = [x1;x2];    % observations
resp = reshape(Z,1,[]);    %response

[net,tr] = newrb(obsv,resp,0.0,1,N,StepN);
end