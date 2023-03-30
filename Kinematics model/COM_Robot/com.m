clear all
clc


% DENAVIT HRATEMBERG 
% create the leg links based on DH parameters
%                    theta   d     a  alpha  
linkshr(1) = Link([    0   0   0       -pi/2 ]);
linkshr(2) = Link([    0   -0.0838   0.2 0   ]);
linkshr(3) = Link([    0   0   0.2   0   ]);

linkshl(1) = Link([    0   0   0       -pi/2 ]);
linkshl(2) = Link([    0   0.0838   0.2 0   ]);
linkshl(3) = Link([    0   0   0.2   0   ]);

linksbr(1) = Link([    0   0   0       -pi/2 ]);
linksbr(2) = Link([    0   -0.0838   0.2 0   ]);
linksbr(3) = Link([    0   0   0.2   0   ]);

linksbl(1) = Link([    0   0   0       -pi/2 ]);
linksbl(2) = Link([    0   0.0838   0.2 0   ]);
linksbl(3) = Link([    0   0   0.2   0   ]);

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

Rx = 0;
Ry = 0;
Rz = 0;

radRx = deg2rad(Rx);
radRy = deg2rad(Ry);
radRz = deg2rad(Rz);

Tx = 0;
Ty = 0;
Tz = 0; 

R_c_corp = rotz(Rx)*roty(Ry)*rotx(Rz)
T_c_corp = [-Tz; Ty; Tx];
% T_c_corp = [-0.1; 0.05; -0.05];
% T_c_corp = [0; 0; 0];
% T_c_corp = [0; 0; 0];
O_c_corp = [R_c_corp, T_c_corp; [0 0 0 1] ];

Bhr =  O_DH * O_c_corp * O_fr;
Bhl =  O_DH * O_c_corp * O_fl;
Bbr =  O_DH * O_c_corp * O_rr;
Bbl =  O_DH * O_c_corp * O_rl;

% now create a robot to represent a single leg
leghr = SerialLink(linkshr, 'name', 'leghr', 'offset', [0   0  0], 'base', Bhr);
% now create a robot to represent a single leg
leghl = SerialLink(linkshl, 'name', 'leghl', 'offset', [0   0  0], 'base', Bhl);
% now create a robot to represent a single leg
legbl = SerialLink(linksbl, 'name', 'legbl', 'offset', [0   0  0], 'base', Bbl);
% now create a robot to represent a single leg
legbr = SerialLink(linksbr, 'name', 'legbr', 'offset', [0   0  0], 'base', Bbr);

qz = [0 pi/6 -pi/2];
q90 = [pi/2 pi/2 pi/2];

x_hr =   0.155677 ;
y_hr = -0.130800;
z_hr = -0.247402;

%pstar_hr = [x_hr; y_hr; z_hr];
pstar_hr = [x_hr; y_hr; z_hr];

%plot3(x_hr, y_hr, z_hr, '*r','MarkerSize',32)
hold on

x_hl = 0.155677;
y_hl = 0.130800;
z_hl = -0.247402;

pstar_hl = [x_hl; y_hl; z_hl];
%pstar_hl = [0.254607, 0.130800, -0.273078];

%plot3(x_hl, y_hl, z_hl, '*r','MarkerSize',12)
hold on

x_br = -0.205323 ;
y_br = -0.130800;
z_br = -0.247402;

%pstar_br = [x_br; y_br; z_br];
pstar_br = [x_br; y_br; z_br];

x_bl = -0.205323;
y_bl = 0.130800;
z_bl = -0.247402;

%pstar_bl = [x_bl; y_bl; z_bl];
pstar_bl = [x_bl; y_bl; z_bl];

%plot3(x_bl, y_bl, z_bl, '*r','MarkerSize',32)

q_fr = ikine_fr_f(pstar_hr, Tx, Ty, Tz, Rx, Ry, Rz)
q_fl = ikine_fl_f(pstar_hl, Tx, Ty, Tz, Rx, Ry, Rz)
q_rr = ikine_rr_f(pstar_br, Tx, Ty, Tz, Rx, Ry, Rz)
q_rl = ikine_rl_f(pstar_bl, Tx, Ty, Tz, Rx, Ry, Rz)

Mfr = leghr.fkine(q_fr);
Mfl = leghl.fkine(q_fl);
Mrr = legbr.fkine(q_rr);
Mfl = legbl.fkine(q_rl);

if abs(Mfr.t(1) - pstar_hr(1)) <= 1e-4 && abs(Mfr.t(2) - pstar_hr(2)) <= 1e-4 && abs(Mfr.t(3) - pstar_hr(3)) <= 1e-5
    disp("OK")
else
    disp("Prost")
end

Mfl = leghl.fkine(q_fl);
if abs(Mfl.t(1) - pstar_hl(1)) <= 1e-8 && abs(Mfl.t(2) - pstar_hl(2)) <= 1e-8 && abs(Mfl.t(3) - pstar_hl(3)) <= 1e-8
    disp("OK")
else
    disp("Prost")
end

Mrr = legbr.fkine(q_rr);
if abs(Mrr.t(1) - pstar_br(1)) <= 1e-8 && abs(Mrr.t(2) - pstar_br(2)) <= 1e-8 && abs(Mrr.t(3) - pstar_br(3)) <= 1e-8
    disp("OK")
else
    disp("Prost")
end

Mrl = legbl.fkine(q_rl);
if abs(Mrl.t(1) - pstar_bl(1)) <= 1e-8 && abs(Mrl.t(2) - pstar_bl(2)) <= 1e-8 && abs(Mrl.t(3) - pstar_bl(3)) <= 1e-8
    disp("OK")
else
    disp("Prost")
end

hold on
 leghr.plot(q_fr, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
leghl.plot(q_fl, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
legbr.plot(q_rr, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
legbl.plot(q_rl, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);

%% HR

linkshr_com_c1(1) = Link([    0   0   0       -pi/2 ]);
linkshr_com_c1(2) = Link([    0   -0.04   0 0   ]);

leghr_com_c1 = SerialLink(linkshr_com_c1, 'name', 'leghr_com_c1', 'offset', [0   0  0], 'base', Bhr);
M_hr_com_c1 = leghr_com_c1.fkine(q_fr(1:2));
%plot3(M_hr_com_c1.t(1), M_hr_com_c1.t(2), M_hr_com_c1.t(3), '*g','MarkerSize',34)


linkshr_com_c2(1) = Link([    0   0   0       -pi/2 ]);
linkshr_com_c2(2) = Link([    0   -0.0838   0.08 0   ]);

leghr_com_c2 = SerialLink(linkshr_com_c2, 'name', 'leghr_com_c2', 'offset', [0   0  0], 'base', Bhr);
M_hr_com_c2 = leghr_com_c2.fkine(q_fr(1:2));
%plot3(M_hr_com_c2.t(1), M_hr_com_c2.t(2), M_hr_com_c2.t(3), '*g','MarkerSize',34)

linkshr_com_c3(1) = Link([    0   0   0       -pi/2 ]);
linkshr_com_c3(2) = Link([    0   -0.0838   0.2 0   ]);
linkshr_com_c3(3) = Link([    0   0   0.1   0   ]);

leghr_com_c3 = SerialLink(linkshr_com_c3, 'name', 'leghr_com_c3', 'offset', [0   0  0], 'base', Bhr);
M_hr_com_c3 = leghr_com_c3.fkine(q_fr);
%plot3(M_hr_com_c3.t(1), M_hr_com_c3.t(2), M_hr_com_c3.t(3), '*g','MarkerSize',34)

%% HL

linkshl_com_c1(1) = Link([    0   0   0       -pi/2 ]);
linkshl_com_c1(2) = Link([    0   0.04   0 0   ]);

leghl_com_c1 = SerialLink(linkshl_com_c1, 'name', 'leghl_com_c1', 'offset', [0  0  0], 'base', Bhl);
M_hl_com_c1 = leghl_com_c1.fkine(q_fl(1:2));
%plot3(M_hl_com_c1.t(1), M_hl_com_c1.t(2), M_hl_com_c1.t(3), '*g','MarkerSize',34)


linkshl_com_c2(1) = Link([    0   0   0       -pi/2 ]);
linkshl_com_c2(2) = Link([    0   0.0838   0.08 0   ]);

leghl_com_c2 = SerialLink(linkshl_com_c2, 'name', 'leghl_com_c2', 'offset', [0   0  0], 'base', Bhl);
M_hl_com_c2 = leghl_com_c2.fkine(q_fl(1:2));
%plot3(M_hl_com_c2.t(1), M_hl_com_c2.t(2), M_hl_com_c2.t(3), '*g','MarkerSize',34)

linkshl_com_c3(1) = Link([    0   0   0       -pi/2 ]);
linkshl_com_c3(2) = Link([    0   0.0838   0.2 0   ]);
linkshl_com_c3(3) = Link([    0   0   0.1   0   ]);

leghl_com_c3 = SerialLink(linkshl_com_c3, 'name', 'leghl_com_c3', 'offset', [0   0  0], 'base', Bhl);
M_hl_com_c3 = leghl_com_c3.fkine(q_fl);
%plot3(M_hl_com_c3.t(1), M_hl_com_c3.t(2), M_hl_com_c3.t(3), '*g','MarkerSize',34)

%% br

linksbr_com_c1(1) = Link([    0   0   0       -pi/2 ]);
linksbr_com_c1(2) = Link([    0   -0.04   0 0   ]);

legbr_com_c1 = SerialLink(linksbr_com_c1, 'name', 'legbr_com_c1', 'offset', [0   0  0], 'base', Bbr);
M_br_com_c1 = legbr_com_c1.fkine(q_rr(1:2));
%plot3(M_br_com_c1.t(1), M_br_com_c1.t(2), M_br_com_c1.t(3), '*g','MarkerSize',34)


linksbr_com_c2(1) = Link([    0   0   0       -pi/2 ]);
linksbr_com_c2(2) = Link([    0   -0.0838   0.08 0   ]);

legbr_com_c2 = SerialLink(linksbr_com_c2, 'name', 'legbr_com_c2', 'offset', [0   0  0], 'base', Bbr);
M_br_com_c2 = legbr_com_c2.fkine(q_rr(1:2));
%plot3(M_br_com_c2.t(1), M_br_com_c2.t(2), M_br_com_c2.t(3), '*g','MarkerSize',34)

linksbr_com_c3(1) = Link([    0   0   0       -pi/2 ]);
linksbr_com_c3(2) = Link([    0   -0.0838   0.2 0   ]);
linksbr_com_c3(3) = Link([    0   0   0.1   0   ]);

legbr_com_c3 = SerialLink(linksbr_com_c3, 'name', 'legbr_com_c3', 'offset', [0   0  0], 'base', Bbr);
M_br_com_c3 = legbr_com_c3.fkine(q_rr);
%plot3(M_br_com_c3.t(1), M_br_com_c3.t(2), M_br_com_c3.t(3), '*g','MarkerSize',34)

%% bl

linksbl_com_c1(1) = Link([    0   0   0       -pi/2 ]);
linksbl_com_c1(2) = Link([    0   0.04   0 0   ]);

legbl_com_c1 = SerialLink(linksbl_com_c1, 'name', 'legbl_com_c1', 'offset', [0   0  0], 'base', Bbl);
M_bl_com_c1 = legbl_com_c1.fkine(q_rl(1:2));
%plot3(M_bl_com_c1.t(1), M_bl_com_c1.t(2), M_bl_com_c1.t(3), '*g','MarkerSize',34)


linksbl_com_c2(1) = Link([    0   0   0       -pi/2 ]);
linksbl_com_c2(2) = Link([    0   0.0838   0.08 0   ]);

legbl_com_c2 = SerialLink(linksbl_com_c2, 'name', 'legbl_com_c2', 'offset', [0   0  0], 'base', Bbl);
M_bl_com_c2 = legbl_com_c2.fkine(q_rl(1:2));
%plot3(M_bl_com_c2.t(1), M_bl_com_c2.t(2), M_bl_com_c2.t(3), '*g','MarkerSize',34)

linksbl_com_c3(1) = Link([    0   0   0       -pi/2 ]);
linksbl_com_c3(2) = Link([    0   0.0838   0.2 0   ]);
linksbl_com_c3(3) = Link([    0   0   0.1   0   ]);

legbl_com_c3 = SerialLink(linksbl_com_c3, 'name', 'legbl_com_c3', 'offset', [0   0  0], 'base', Bbl);
M_bl_com_c3 = legbl_com_c3.fkine(q_rl);
%plot3(M_bl_com_c3.t(1), M_bl_com_c3.t(2), M_bl_com_c3.t(3), '*g','MarkerSize',34)

m1 = 0.696;
m2 = 1.013;
m3 = 0.06+0.166;
mmat = [m1; m2; m3];

cmat_hr = [M_hr_com_c1.t M_hr_com_c2.t M_hr_com_c3.t];
c_hr = 1/(m1+m2+m3) *cmat_hr *mmat 
%plot3(c_hr(1),c_hr(2),c_hr(3),'*','Color','b','MarkerSize',32)

cmat_hl = [M_hl_com_c1.t M_hl_com_c2.t M_hl_com_c3.t];
c_hl = 1/(m1+m2+m3) *cmat_hl *mmat ;
%plot3(c_hl(1),c_hl(2),c_hl(3),'*','Color','b','MarkerSize',32)

cmat_br = [M_br_com_c1.t M_br_com_c2.t M_br_com_c3.t];
c_br = 1/(m1+m2+m3) *cmat_br *mmat ;
%plot3(c_br(1),c_br(2),c_br(3),'*','Color','b','MarkerSize',32)

cmat_bl = [M_bl_com_c1.t M_bl_com_c2.t M_bl_com_c3.t];
c_bl = 1/(m1+m2+m3) *cmat_bl *mmat ;
%plot3(c_bl(1),c_bl(2),c_bl(3),'*','Color','b','MarkerSize',32)


m_cl = [m1+m2+m3; m1+m2+m3; m1+m2+m3; m1+m2+m3];
cmatl = [c_hr c_hl c_br c_bl];
cl = 1/((m1+m2+m3)*4)*cmatl*m_cl

%plot3(cl(1),cl(2),cl(3),'*','Color','g','MarkerSize',20)


m_corp= 6;
c_corp = T_c_corp

m_c = [m1+m2+m3; m1+m2+m3; m1+m2+m3; m1+m2+m3; m_corp];

cmat = [c_hr c_hl c_br c_bl c_corp];

c = 1/(4*(m1+m2+m3)+m_corp)*cmat*m_c

plot3(c(1),c(2),c(3),'*','Color','b','MarkerSize',20)
%plot3(c_corp(1),c_corp(2),c_corp(3),'*','Color','r','MarkerSize',20)

















