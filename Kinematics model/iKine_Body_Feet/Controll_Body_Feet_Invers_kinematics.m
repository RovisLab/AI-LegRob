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

Rx = 5;
Ry = -10;
Rz = -3;

radRx = deg2rad(Rx)
radRy = deg2rad(Ry)
radRz = deg2rad(Rz)

Tx = -0.084990;
Ty = -0.043600;
Tz = -0.01; 

R_c_corp = rotz(Rx)*roty(Ry)*rotx(Rz)
T_c_corp = [-Tz; Ty; Tx];
% T_c_corp = [-0.1; 0.05; -0.05];
% T_c_corp = [0; 0; 0];
% T_c_corp = [0; 0; 0];
O_c_corp = [R_c_corp, T_c_corp; [0 0 0 1] ]

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

plot3(x_hr, y_hr, z_hr, '*r','MarkerSize',32)
hold on

x_hl = 0.155677;
y_hl = 0.130800;
z_hl = -0.247402;

pstar_hl = [x_hl; y_hl; z_hl];
%pstar_hl = [0.254607, 0.130800, -0.273078];

plot3(x_hl, y_hl, z_hl, '*r','MarkerSize',12)
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

plot3(x_bl, y_bl, z_bl, '*r','MarkerSize',32)

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

% leghr.plot(qz, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% leghl.plot(qz, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% legbr.plot(qz, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% legbl.plot(qz, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);


