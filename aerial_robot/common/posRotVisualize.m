function posRotVisualize(Pdata,Rdata,tdata,interval)
% 'out' is Simulink output variable.
%% Prepare Source Data
P = squeeze(Pdata);
[d1,d2] = size(P);
if d1 > d2
    P = transpose(P);
end
n = length(tdata);
R = zeros(size(Rdata));

zaxis_down = false;
if zaxis_down
for i = 1:n
    R(:,:,i) =-1 * eye(3) * Rdata(:,:,i);
end
else
    R = Rdata;
end
frameselect = 1:interval:n;
t = squeeze(tdata(frameselect));
nselect = length(frameselect);

%% Graph Data & Config
% set(gcf,'PaperPositionMode','auto');
[x,y,z,u,v,w] = genQuiver3Data(P(:,frameselect),R(:,:,frameselect));
zv = zeros(3,1); % z3ro vector.
q = quiver3(zv,zv,zv,zv,zv,zv);
q.Marker = '.';
q.MaxHeadSize = 0.5;
q.AutoScale = true;
q.AutoScaleFactor = 1.0;
axis vis3d;
axis([-1, 3, -1, 3, -1, 3]);

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
    disp(i)
    xi = repmat(x(i),[3, 1]);
    yi = repmat(y(i),[3, 1]);
    zi = repmat(z(i),[3, 1]);
    ui = u(:,i);
    vi = v(:,i);
    wi = w(:,i);

    q.XData = xi;
    q.YData = yi;
    q.ZData = zi;
    q.UData = ui;
    q.VData = vi;
    q.WData = wi;
    refreshdata
    title('time = ',num2str(t(i)))
%     view([-14.761 25.877])
    drawnow limitrate
    %     fc = getframe;
    %     f = print(gcf,'-r0','-image','-RGBImage');
    %     M(i) = struct('cdata',f,'colormap',[]);

end
end