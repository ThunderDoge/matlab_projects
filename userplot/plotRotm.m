function plotRotm(R)
T = zeros(1,3);
Q = rotm2quat(R);
plotTransforms(T,Q);
end