function plotEul(eul)
T = zeros(1,3);
Q = eul2quat(eul);
plotTransforms(T,Q);
end