function lambda = arg(R)
% Rotation matrix to Z-Y-X euler angle.
theta = atan2(-R(3,1), sqrt(R(1,1)^2+R(2,1)^2));
phi = atan2(R(3,2),R(3,3));
psi = atan2(R(2,1),R(1,1));

lambda = [phi;theta;psi];
end