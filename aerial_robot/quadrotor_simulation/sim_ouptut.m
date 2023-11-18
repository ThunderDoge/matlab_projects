% 'out' is Simulink output variable.
P = out.P.Data;
tP = out.P.Time;
R = out.R.Data;
tR = out.R.Time;

[x,y,z,u,v,w] = genQuiver3Data(P',R);
q = quiver3(x,y,z,u(1,:),v(1,:),w(1,:));
q.Marker = '.';