function posRotVisualize(Pdata,Rdata,tdata,interval,iszaxisdown)
% Visualize Trasnformation Position-Rotation Matrix.
% interval: decimation.
% iszaxisdown: True if Universal (inertial) frame z-axis points downward.

%% Prepare Source Data
Pdata = squeeze(Pdata);
[d1,d2] = size(Pdata);
if d1 > d2
    Pdata = transpose(Pdata);
end
n = length(tdata);
R = zeros(size(Rdata));
matRevZAxis = diag([1,-1,-1]);

if iszaxisdown
for i = 1:n
    R(:,:,i) = matRevZAxis * Rdata(:,:,i);
    P(:,i) = matRevZAxis * Pdata(:,i);
end
else
    R = Rdata;
    P = Pdata;
end
frameselect = 1:interval:n;
t = squeeze(tdata(frameselect));
nselect = length(frameselect);

%% Graph Data & Config
% set(gcf,'PaperPositionMode','auto');
[x,y,z,u,v,w] = genQuiver3Data(P(:,frameselect),R(:,:,frameselect));
hold on
zv = zeros(2,1); % z3ro vector.
q = quiver3(zv,zv,zv,zv,zv,zv);
q.Color = [0.07,0.62,1.00];
q.Marker = '.';
q.MaxHeadSize = 0.5;
q.AutoScale = true;
q.AutoScaleFactor = 1.0;

qz = quiver3(0,0,0,0,0,0);
qz.Color = [1,0,0];
qz.Marker = '.';
qz.MaxHeadSize = 0.5;
qz.AutoScale = true;
qz.AutoScaleFactor = 1.0;

axis vis3d;
axis([-3, 3, -3, 3, -3, 3]);

% q.XDataSource = 'xi';
% q.YDataSource = 'yi';
% q.ZDataSource = 'zi';
% q.UDataSource = 'ui';
% q.VDataSource = 'vi';
% q.WDataSource = 'wi';
% q.XDataMode = "auto";
% q.YDataMode = "auto";
% q.ZDataMode = "auto";
% q.UDataMode = "auto";
% q.VDataMode = "auto";
% q.WDataMode = "auto";

%% Gen Movie (by edit graph and gen frame)
for i=1:nselect
    xi = repmat(x(i),[2, 1]);
    yi = repmat(y(i),[2, 1]);
    zi = repmat(z(i),[2, 1]);
    ui = u(1:2,i);
    vi = v(1:2,i);
    wi = w(1:2,i);

    q.XData = xi;
    q.YData = yi;
    q.ZData = zi;
    q.UData = ui;
    q.VData = vi;
    q.WData = wi;
    
    qz.XData = x(i);
    qz.YData = y(i);
    qz.ZData = z(i);
    qz.UData = u(3,i);
    qz.VData = v(3,i);
    qz.WData = w(3,i);

    refreshdata
    title(num2str(t(i)),num2str(i))
%     view([-14.761 25.877])
    drawnow limitrate
    %     fc = getframe;
    %     f = print(gcf,'-r0','-image','-RGBImage');
    %     M(i) = struct('cdata',f,'colormap',[]);

end
hold off
end