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
genrbfnet_script

%% Visualization
tiledlayout(2,3);
% nexttile()
% genmesh(@f,x,y);
% title('function surface')

nexttile
[~,~,z30] = gennetmesh(net30,x,y);
title('rbf-net 30 neuron surface',FontSize=18)
axis tight

nexttile
[~,~,z60] = gennetmesh(net60,x,y);
title('rbf-net 60 neuron surface',FontSize=18)
axis tight
nexttile
[~,~,z90] = gennetmesh(net90,x,y);
title('rbf-net 90 neuron surface',FontSize=18)
axis tight

nexttile
mesh(X,Y,Z-z30)
title('surface error',FontSize=18)

nexttile
mesh(X,Y,Z-z60)
title('surface error',FontSize=18)

nexttile
mesh(X,Y,Z-z90)
title('surface error',FontSize=18)
