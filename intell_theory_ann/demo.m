% If u wanna train new network then comment these lines!
% Training require around 5GB of RAM in addition to a running MATLAB
load('fnn.mat')
load('rbfnet30n.mat')
load('rbfnet60n.mat')
load("rbfnet90n.mat")
%% Generate Data
x = -6.5:0.1:6.5;
y = x;
[X,Y] = meshgrid(x,y);
Z = f(X,Y);

%% Create & Train Networks
genfnn_script
genrbfnet_script

%% Visualization
tiledlayout(2,3);
nexttile([1,2])
genmesh(@f,x,y);
title('function surface')

nexttile
gennetmesh(net,x,y);
title('fnn surface')


nexttile
gennetmesh(net30,x,y);
title('rbf-net 30 neuron surface')

nexttile
gennetmesh(net60,x,y);
title('rbf-net 60 neuron surface')

nexttile
gennetmesh(net90,x,y);
title('rbf-net 90 neuron surface')

