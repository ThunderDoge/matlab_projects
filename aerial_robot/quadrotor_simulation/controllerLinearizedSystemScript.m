% x: R^4 := [dpe; dve; d_lambda_e; d_omega_e]
% u: R^4 := [-B_f; B_n(3-element)];
IB = diag([1e-4,1e-4,1e-3]);
I3 = eye(3);
Z3 = zeros(3);
Z34 = zeros(3,4);
vc = [0.75;0.75;0];
m =0.1;

R = [0.707 -0.707   0;
     0.707  0.707   0;
     0      0       1];
gvec = transpose([0,0,9.807]);

A = [   Z3, I3, -skew(vc),      Z3;
        Z3, Z3, skew(R'*gvec),  Z3;
        Z3, Z3, Z3,             I3;
        zeros(3,12)               ];

B = zeros(12,4);
B(4:6,1) = [0,0, -1/m]';
B(10:12,2:4) = IB^-1;

A1 = [  Z3, I3, -skew(vc),      Z3, Z34;
        Z3, Z3, skew(R'*gvec),  Z3, Z34;
        Z3, Z3, Z3,             I3, Z34;
        zeros(3,16);
        I3, zeros(3,13);
        [0,0,0],[0,0,0],[0,0,1],zeros(1,7)];

vq = ones(1,12);
Q =diag(vq);

vr = ones(1,4);
R = diag(vr);

K = lqr(A,B,Q,R,0);

% System output. 
% x = [dPe, dVe, dLe, dOmega_e, xI]
% y = [dPe, dLe, dOmega_e, xI]
C = [I3, Z3, Z3, Z3, Z3;
     Z3, Z3, I3, Z3, Z3;
     Z3, Z3, Z3, I3, Z3;
     Z3, Z3, Z3, Z3, I3];

clear I3 Z3 Z34 vc R gvec vq vr
