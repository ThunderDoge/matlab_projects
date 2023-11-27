% If u wanna train new network then comment these lines!
% Training require around 5GB of RAM in addition to a running MATLAB
load('fnn.mat')

%% Generate Data
x = -6.5:0.1:6.5;
y = x;
[X,Y] = meshgrid(x,y);
Z = f(X,Y);

%% Create & Train Networks
genfnn_script

%% Visualization
tiledlayout(1,2);
nexttile()
[~,~,zf]=genmesh(@f,x,y);
title('function surface',FontSize=18)

nexttile
[~,~,znet]=gennetmesh(net,x,y);
title('fnn surface',FontSize=18)

nexttile
mesh(X,Y,zf - znet)
title('surface error')
axis tight


