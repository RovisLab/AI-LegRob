%% HR


% orientarea centrului corpului

R_DH = rotz(0)*roty(90)*rotx(0);
T_DH = [0; 0; 0];
O_DH = [R_DH, T_DH; [0 0 0 1] ];

R_fr = rotz(0)*roty(0)*rotx(0);
T_fr = [0; -0.047; 0.1805];
O_fr = [R_fr, T_fr; [0 0 0 1] ];

R_fl = rotz(0)*roty(0)*rotx(0);
T_fl = [0; 0.047; 0.1805];
O_fl = [R_fl, T_fl; [0 0 0 1] ];

R_rr = rotz(0)*roty(0)*rotx(0);
T_rr = [0; -0.047; -0.1805];
O_rr = [R_rr, T_rr; [0 0 0 1] ];

R_rl = rotz(0)*roty(0)*rotx(0);
T_rl = [0; 0.047; -0.1805];
O_rl = [R_rl, T_rl; [0 0 0 1] ];

% Rx = 0;
% Ry = 0;
% Rz = 0;
% 
% Tx = 0;
% Ty = 0;
% Tz = 0; 

syms Rx Ry Rz Tx Ty Tz

qsyms_fr = sym('qsyms_fr',[1 3]);

% R_c_corp = rotz(Rx)*roty(Ry)*rotx(Rz)
R_c_corp =[cos(Rx) -sin(Rx) 0; sin(Rx) cos(Rx) 0; 0 0 1] * [cos(Ry) 0 sin(Ry); 0 1 0; -sin(Ry) 0 cos(Ry)]* [1 0 0; 0 cos(Rz) -sin(Rz); 0 sin(Rz) cos(Rz)];


T_c_corp = [-Tz; Ty; Tx];
% T_c_corp = [-0.1; 0.05; -0.05];
% T_c_corp = [0; 0; 0];
% T_c_corp = [0; 0; 0];
O_c_corp = [R_c_corp, T_c_corp; [0 0 0 1] ];

Bhr =  O_DH * O_c_corp * O_fr;

q_fr = [0    1.0000   -1.8000];

linkshr_com_c1(1) = Link([    0   0   0       -pi/2 ]);
linkshr_com_c1(2) = Link([    0   -0.04   0 0   ]);

leghr_com_c1 = SerialLink(linkshr_com_c1, 'name', 'leghr_com_c1', 'offset', [0   0  0], 'base', Bhr);
M_hr_com_c1 = leghr_com_c1.fkine(qsyms_fr(1:2));
%plot3(M_hr_com_c1.t(1), M_hr_com_c1.t(2), M_hr_com_c1.t(3), '*g','MarkerSize',34)


linkshr_com_c2(1) = Link([    0   0   0       -pi/2 ]);
linkshr_com_c2(2) = Link([    0   -0.0838   0.08 0   ]);

leghr_com_c2 = SerialLink(linkshr_com_c2, 'name', 'leghr_com_c2', 'offset', [0   0  0], 'base', Bhr);
M_hr_com_c2 = leghr_com_c2.fkine(qsyms_fr(1:2));
%plot3(M_hr_com_c2.t(1), M_hr_com_c2.t(2), M_hr_com_c2.t(3), '*g','MarkerSize',34)

linkshr_com_c3(1) = Link([    0   0   0       -pi/2 ]);
linkshr_com_c3(2) = Link([    0   -0.0838   0.2 0   ]);
linkshr_com_c3(3) = Link([    0   0   0.1   0   ]);

leghr_com_c3 = SerialLink(linkshr_com_c3, 'name', 'leghr_com_c3', 'offset', [0   0  0], 'base', Bhr);
M_hr_com_c3 = leghr_com_c3.fkine(qsyms_fr);
%plot3(M_hr_com_c3.t(1), M_hr_com_c3.t(2), M_hr_com_c3.t(3), '*g','MarkerSize',34)

m1 = 0.696;
m2 = 1.013;
m3 = 0.06+0.166;
mmat = [m1; m2; m3];

cmat_hr = [M_hr_com_c1.t M_hr_com_c2.t M_hr_com_c3.t];
c_hr = 1/(m1+m2+m3) *cmat_hr *mmat 
%plot3(c_hr(1),c_hr(2),c_hr(3),'*','Color','b','MarkerSize',32)

lb_r = [];
ub_r = [];

lb_l = [-pi/4, -pi/3, -0.85833333333*pi];
ub_l = [pi/4, 1.3333333333*pi, -0.29166666667*pi];
A = [];
b = [];
Aeq = [];
beq = [];

pstar_com_hr = [0.1340 -0.1150 -0.0434]';

qz = [0 0 0 0 0 0 0 0 0];

fun = matlabFunction(norm(c_hr - pstar_com_hr))

fun_ob = @(x)fun(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9))

q_hr = fmincon( fun_ob, qz,A,b,Aeq,beq,lb_r,ub_r)