clear,clc,close all;

clear all
close all
clc

A = [0.1105, -0.1308, -0.15]'
C = [0.1205, -0.1308, -0.10]'
B = [0.1305, -0.1308, -0.15]'

rx = 0;
ry = 0;
rz = 0;
tx = 0;
ty = 0;
tz = 0;

nr_p = 3;
traj = Parab(A, B, nr_p)

t = [0, 0.5, 1]; % Assumed time stamp

x = [A(1), C(1), B(1)];
y = [A(2), C(2), B(2)];
z = [A(3), C(3), B(3)];

tt = linspace(t(1),t(end),3);

xx = interp1(t,x,tt,'spline');
yy = interp1(t,y,tt,'spline');
zz = interp1(t,z,tt,'spline');

traj = [xx; yy; zz]

plot3(traj(1,:), traj(2,:), traj(3,:))
grid on

figure

for i=1:length(traj(1,:))

    Q(i,:) = ikine_fr_f(traj(:,i), tx, ty, tz, rx, ry, rz)
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

U = para( s, Q, k)*2 ;
d = controlPoints( U,Q, col, 3);   

f = spmak(U,d');     
d_f = fnder(f,1);
dd_f = fnder(d_f,1);

u = U(4):0.05:U(end-3);
p = fnval(f, u);
v = fnval(d_f, u);
a = fnval(dd_f, u);

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