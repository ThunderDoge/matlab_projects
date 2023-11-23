
Oc = [0,0,0];
Vc = [1,0,0];

J = 0.1 * eye(3);
g = 9.8;
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


Nmc=0.00001;
Q = eye(12); Q(1,1)=10; Q(2,2)=10; % 状态权重矩阵
R = eye(4); R(1,1)=Nmc;   %R(2,2)=Nmc; R(3,3)=Nmc;R(4,4)=Nmc;  % 控制权重矩阵

K = lqr(A, B, Q, R);