function [rotm, gT] = gen_static_sample(n, g_const)
% generate static sampling result of accelarator
% num: number of sample
% rotm_series: Ri for sensor frame {T} to inertia {I}
% gT_series: gravity vector in {T}
range = 7/4*pi;
eul = [zeros(n,1), (rand(n,1)-0.5)*range, (rand(n,1)-0.5)*range];
rotm = eul2rotm(eul);
gT = repmat([0,0,-1]' * g_const, [1,n]);
for i = 1:n
    gT(:,i) = rotm(:,:,i)' * gT(:,i);
end
end