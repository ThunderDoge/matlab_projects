% parameters.
load('test_parameter.mat');
n_origin_data = 10;
g_const = 9.800;

n_repeat = 50;
g = [0,0,-1]' * g_const;

% create model.
mdl = accel_model(F,F2,b,r,g_const);
est = accel_estimator();

err = zeros(n_repeat, 3);
for i = 1:n_repeat
% rotation samplings [rotm].
% reality [gT] and model output [am].
[rotm, gT] = gen_static_sample(n_origin_data, g_const);
[am, a, ~] = mdl.gen_static_measure(rotm);
err_measure = am - (-gT); % error between reality and model

% parameter estimation
[estF, estF2, estb] = est.estimate(am, rotm);

% verification
[rotm, ~] = gen_static_sample(200, g_const);
obs = accel_model(estF, estF2, estb,r,g_const);
[amo, ao, ~] = obs.gen_static_measure(rotm);
[am, a, ~] = mdl.gen_static_measure(rotm);
err_observe = amo - am; % error between model and observor
% plotVec(err_observe);
% title("err observe");

%relative errors
errF = F - estF;
errF2 = F2 - estF2;
errb = b - estb;

rerrF = det(errF)/det(F);
rerrF2 = det(errF2)/det(F2);
rerrb = norm(errb)/norm(b);

err(i,:) = [rerrF rerrF2 rerrb];
end