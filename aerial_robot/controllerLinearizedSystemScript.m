% x: R^4 := [dpe; dve; d_lambda_e; d_omega_e]
% u: R^4 := [-B_f; B_n(3-element)];
IB = diag([1e-4,1e-4,1e-3]);
I3 = eye(3);
Z3 = zeros(3);
vc = [0.75;0.75;0.75];
m =0.1;

R = [0.707 -0.707   0;
     0.707  0.707   0;
     0      0       1];
gvec = transpose([0,0,9.807]);

A = [   Z3, I3, -skew(vc),      Z3;
        Z3, Z3, skew(R'*gvec),  Z3;
        Z3, Z3, Z3,             I3;
        zeros(3,12)];

B = zeros(12,4);
B(4:6,1) = [0,0, -1/m]';
B(10:12,2:4) = IB^-1;

vq = ones(1,12);
Q =diag(vq);

vr = ones(1,4);
R = diag(vr);

K = lqr(A,B,Q,R,0);

