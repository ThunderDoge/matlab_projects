function [x,y,z,u,v,w] = genQuiver3Data(P,R)
% Generate data for quiver3 form position series P and Rotation matrix
% series R
% P : 3*n matrix double
% R : 3*3*n matrix double
n = size(P,2);
m = size(R,3);
if n ~= m
    error('P and R has different sample number.');
end
x=P(1,:);
y=P(2,:);
z=P(3,:);
u=squeeze(R(:,1,:));
v=squeeze(R(:,2,:));
w=squeeze(R(:,3,:));
end