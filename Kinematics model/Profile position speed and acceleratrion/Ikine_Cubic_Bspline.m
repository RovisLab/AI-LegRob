clear all
clc
close all

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

A = [0.1105, -0.1308, -0.15]';
C = [0.1205, -0.1308, -0.10]';
B = [0.1305, -0.1308, -0.15]';

rx = 0;
ry = 0;
rz = 0;
tx = 0;
ty = 0;
tz = 0;

nr_p = 20;
traj = Parab(A, B, nr_p);

t = [0, 0.5, 1]; % Assumed time stamp

x = [A(1), C(1), B(1)];
y = [A(2), C(2), B(2)];
z = [A(3), C(3), B(3)];

tt = linspace(t(1),t(end),nr_p);

xx = interp1(t,x,tt,'spline');
yy = interp1(t,y,tt,'spline');
zz = interp1(t,z,tt,'spline');

traj = [xx; yy; zz];



figure

for i=1:length(traj(1,:))

    Q(i,:) = ikine_fr_f(traj(:,i), tx, ty, tz, rx, ry, rz);
    tp = linspace(0,1,length(traj));

end

col = size(Q(i,:), 2);

alpha = 0.1;
beta = 0.1;

q_add1 = alpha*Q(1,:)+(1-alpha)*Q(2,:);
q_add2 = beta*Q(end,:)+(1-beta)*Q(end-1,:);
Q = [Q(1,:);q_add1; Q(2:end-1,:);q_add2;Q(end,:)];

k = 3;                     
s = size(Q,1) -1;         
n = s + k -1;             
m = n + k + 1;          

U = para( s, Q, k);
d = controlPoints( U,Q, col, 3);   

f = spmak(U,d');     
d_f = fnder(f,1);
dd_f = fnder(d_f,1);

u = U(4):0.001:U(end-3);
p = fnval(f, u);
v = fnval(d_f, u);
a = fnval(dd_f, u);

save("data.mat","u","p")

for i =1:3

    % Plot the data and spline
    subplot(3,1,1)
    plot(u, p(i,:), 'linewidth',2,'color',[0, 0.45, 0.74]);
    grid on
    
    title('Cubic B-Spline with Null Initial and Final Velocities and Accelerations');
    ylabel('p');
    %legend('Data Points', 'Cubic B-Spline');
    
    % Plot the velocity
    subplot(3,1,2)
    plot(u, v(i,:),'linewidth',2,'color',[0.85, 0.33, 0.10]);
    grid on
    title('Velocity of Cubic B-Spline');
    ylabel('v');
    
    % Plot the acceleration
    subplot(3,1,3)
    plot(u, a(i,:),'linewidth',2,'color',[0.93, 0.69, 0.13]); 
    grid on
    title('Acceleration of Cubic B-Spline');
    xlabel('time');
    ylabel('a');
    
    if i<3
        figure
    end
end

for i=1:length(p)

    point(:,i) = leghr.fkine(p(:,i)).t;

end
figure

plot3(point(1,:),point(2,:),point(3,:),'.b')
grid on
% hold on
% plot3(traj(1,:), traj(2,:), traj(3,:))
% grid on