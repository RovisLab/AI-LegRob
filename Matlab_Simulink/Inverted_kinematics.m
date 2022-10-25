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

Bhr = [rotz(90)*rotx(90), [0.1805; -0.047; 0]; [0 0 0 1] ];
Bhl = [rotz(90)*rotx(90), [0.1805; 0.047; 0]; [0 0 0 1] ];
Bbl = [rotz(90)*rotx(90), [-0.1805; 0.047; 0]; [0 0 0 1] ]; 
Bbr = [rotz(90)*rotx(90), [-0.1805; -0.047; 0]; [0 0 0 1] ];

% now create a robot to represent a single leg
leghr = SerialLink(linkshr, 'name', 'leghr', 'offset', [-pi/2   0  0], 'base', Bhr);
% now create a robot to represent a single leg
leghl = SerialLink(linkshl, 'name', 'leghl', 'offset', [-pi/2   0  0], 'base', Bhl);
% now create a robot to represent a single leg
legbl = SerialLink(linksbl, 'name', 'legbl', 'offset', [-pi/2   0  0], 'base', Bbl);
% now create a robot to represent a single leg
legbr = SerialLink(linksbr, 'name', 'legbr', 'offset', [-pi/2   0  0], 'base', Bbr);

tc = 0.1; %timpul in care articulatiile ajung in punctul dorit Simulink

q1 = 0;
q2 = 0;
q3 = 0;

qz = [0 0 0];
q90 = [pi/2 pi/2 pi/2];

x_hr = 0.3;
y_hr = -0.0838-0.047;
z_hr = -0.25;

pstar_hr = [x_hr; y_hr; z_hr]

x_hl = 0.3;
y_hl = 0.0838+0.047;
z_hl = -0.25;

pstar_hl = [x_hl; y_hl; z_hl]

x_br = -0.25;
y_br = -0.0838-0.047;
z_br = -0.25;

pstar_br = [x_br; y_br; z_br]

x_bl = -0.25;
y_bl = 0.0838+0.047;
z_bl = -0.25;

pstar_bl = [x_bl; y_bl; z_bl]

% q_hr = [q1 q2 q3];
% q_hl = [q1 q2 q3];
% q_br = [q1 q2 q3];
% q_bl = [q1 q2 q3];

lb_r = [-pi/4, -pi/3, -0.85833333333*pi];
ub_r = [pi/4, 1.3333333333*pi, -0.29166666667*pi];

lb_l = [-pi/4, -pi/3, -0.85833333333*pi];
ub_l = [pi/4, 1.3333333333*pi, -0.29166666667*pi];
A = [];
b = [];
Aeq = [];
beq = [];

syms q1 q2 q3 

qsyms = [q1 q2 q3];

f = @ (qsyms) norm(mun4dof.fkine(qsyms).t - pstar_hr);

q_hr = fmincon( @(qsyms) norm(leghr.fkine(qsyms).t - pstar_hr), qz,A,b,Aeq,beq,lb_r,ub_r);

q_hl = fmincon( @(qsyms) norm(leghl.fkine(qsyms).t - pstar_hl), qz,A,b,Aeq,beq,lb_l,ub_l);

q_br = fmincon( @(qsyms) norm(legbr.fkine(qsyms).t - pstar_br), qz,A,b,Aeq,beq,lb_r,ub_r);

q_bl = fmincon( @(qsyms) norm(legbl.fkine(qsyms).t - pstar_bl), qz,A,b,Aeq,beq,lb_l,ub_l);


% leghr.plot(lb_r, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% hold on
% leghl.plot(lb_l, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% legbr.plot(lb_r, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% legbl.plot(lb_l, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% 
% figure
% 
% leghr.plot(ub_r, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% hold on
% leghl.plot(ub_l, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% legbr.plot(ub_r, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
% legbl.plot(ub_l, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);


hold on

leghr.plot(q_hr, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
leghl.plot(q_hr, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
legbr.plot(q_br, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);
legbl.plot(q_bl, 'workspace', [-0.5 0.5 -0.5 0.5 -0.5 0.5]);



