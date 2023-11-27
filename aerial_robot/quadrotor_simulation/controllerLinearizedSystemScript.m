Oc = [0;0;0];
Vc = [2;0;0];
J = 1e-3 * diag([0.1,0.1,1]);
g = 9.807;
m = 0.25;
Rcu = eye(3);

ddvdt_dv = 0*eye(3);
ddvdt_dw = 0*eye(3);
ddwdt_dw = 0*eye(3);

A = [-skew(Oc) ,eye(3),-skew(Vc),zeros(3);
    zeros(3),ddvdt_dv,skew(Rcu*[0;0;g]),ddvdt_dw;
    zeros(3),zeros(3),-skew(Oc),eye(3);
    zeros(3),zeros(3),zeros(3),ddwdt_dw;];

B = [[0;0;0],zeros(3);
     [0;0;-1/m],zeros(3);
     [0;0;0],zeros(3);
     [0;0;0],J^-1;];

A1 = [-skew(Oc) ,eye(3),-skew(Vc),zeros(3),zeros(3,4);
    zeros(3),ddvdt_dv,skew(Rcu*[0;0;g]),ddvdt_dw,zeros(3,4);
    zeros(3),zeros(3),-skew(Oc),eye(3),zeros(3,4);
    zeros(3),zeros(3),zeros(3),ddwdt_dw,zeros(3,4);
    eye(3),zeros(3),zeros(3),zeros(3),zeros(3,4);
    zeros(1,3),zeros(1,3),[0,0,1],zeros(1,3),zeros(1,4)];
B1 = [[0;0;0],zeros(3);
     [0;0;-1/m],zeros(3);
     [0;0;0],zeros(3);
     [0;0;0],J^-1;
     zeros(4,4)];

Nmc=0.00001;
Q = eye(12); Q(1,1)=10; Q(2,2)=10; % 状态权重矩阵
R1 = eye(4); R1(1,1)=Nmc; R1(2,2)=Nmc; R1(3,3)=Nmc;R1(4,4)=Nmc;  % 控制权重矩阵

K = lqr(A,B,Q,R1,0);

Q1 = eye(16); Q(1,1)=10; Q(2,2)=10; % 状态权重矩阵
R1 = eye(4); R1(1,1)=Nmc; R1(2,2)=Nmc; R1(3,3)=Nmc;R1(4,4)=Nmc;  % 控制权重矩阵

K1 = lqr(A1,B1,Q1,R1,0);

% System output. 
% x = [dPe, dVe, dLe, dOmega_e, xI]
% y = [dPe, dLe, dOmega_e, xI]
C1 = [eye(3), zeros(3), zeros(3), zeros(3), zeros(3,4);
     zeros(3), zeros(3), eye(3), zeros(3), zeros(3,4);
     zeros(3), zeros(3), zeros(3), eye(3), zeros(3,4);
     zeros(4,3), zeros(4,3), zeros(4,3), zeros(4,3), eye(4)];

D = zeros (13,4);

sys = ss(A1,B1,C1,D);
QN=eye(4);
RN=eye(13)*0.001;
[Kest,L]=kalman(sys,QN,RN);
