

J=  [ 10^-1,  0,      0;
      0,    10^-1  ,  0;
      0,     0,    10^-1  ];

m=0.25;
g=9.8;
Ruc=eye(3,3);

ddVdt_dV=0*eye(3);
ddVdt_dO=0*eye(3);
ddOdt_dO=0*eye(3);

%STATE
% dx=[dPe,dVe,dLe,dOe,xI]
% inputs 
% du=[-dT,dn ]


Oc=[0,0,0];
Vc=[1,0,0];

A_LD=[  -skew(Oc),    eye(3),          -skew(Vc),      zeros(3),      zeros(3,4);
        zeros(3),    ddVdt_dV,   skew(Ruc*[0;0;g]),      ddVdt_dO,     zeros(3,4);
        zeros(3),    zeros(3),          -skew(Oc),       eye(3) ,      zeros(3,4);
        zeros(3),    zeros(3),           zeros(3),     ddOdt_dO ,       zeros(3,4);
        eye(3,3),    zeros(3),           zeros(3),     zeros(3),      zeros(3,4);
        [0,0,0],     [0,0,0] ,          [0,0,1],        [0,0,0],      [0,0,0,0]       ]  ;

B_LD=[    [0;0;0],     zeros(3);
       [0;0;-1/m],     zeros(3);
          [0;0;0],     zeros(3);
          [0;0;0],      J^-1 ;
             zeros(4,4)
          ];

Q=eye(16);    Q(1,1)=3;           
Q(4,4)=3;   Q(5,5)=3;
Q(14,14)=0.001;
R=eye(4,4)*0.01 ;   R(1,1)=0.001;          %后面可以呈上相应的系数0.1 从而改变收敛速度 也可以直接R(1,1)=0.001或者0.1


K=lqr(A_LD,B_LD,Q,R);
rank(ctrb(A_LD,B_LD));

% system output [dPe ,dLe,dOe,xI]
% dx=[dPe,dVe,dLe,dOe,xI]

C_LD=[eye(3),zeros(3),zeros(3),zeros(3),zeros(3,4);   %dPe
     zeros(3),zeros(3),eye(3),zeros(3),zeros(3,4);   %dLe
     zeros(3),zeros(3),zeros(3),eye(3),zeros(3,4);    %dOe
    zeros(4,3),zeros(4,3),zeros(4,3),zeros(4,3),eye(4)   ];      %xI 

D_LD=zeros(13,4);
System=ss(A_LD,B_LD,C_LD,D_LD);
QN=eye(4);
RN=eye(13)*0.001;
[Kest,L]=kalman(System,QN,RN);


