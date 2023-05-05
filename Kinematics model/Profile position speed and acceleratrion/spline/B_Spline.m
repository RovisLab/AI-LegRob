clear,clc,close all;
set(0,'defaultfigurecolor','w');

% via-points
Q = [30, -70, 94, -87, -130, 115, -155, 110, -42, -95, 20]';  
col = size(Q, 2)

alpha = 0.2;
beta = 0.2;

q_add1 = alpha*Q(1,:)+(1-alpha)*Q(2,:);
q_add2 = beta*Q(end,:)+(1-beta)*Q(end-1,:);
Q = [Q(1,:);q_add1; Q(2:end-1,:);q_add2;Q(end,:)];

k = 3;                     
s = size(Q,1) -1;         
n = s + k -1;             
m = n + k + 1;          

U = para( s, Q, k)*5 ;
d = controlPoints( U,Q, col, 3);   

f = spmak(U,d');     
d_f = fnder(f,1);
dd_f = fnder(d_f,1);


% -------------------------position-------------------------------
% d_f = fnder(f,1);
% breaks1 = fnval(d_f,U(1+k:n+1+1)); 
% figure(2)
% fnplt(d_f,'b',3.3);
% xlabel('$\boldmath{u}$','Interpreter','latex');
% ylabel('$C^{(1)}(u)$','Interpreter','latex');
%
% grid on;
% set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
%     'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');
% figure(1);
% fnplt(f,'b',3); hold on;  
% 
% 
% breaks = fnval(f,U(1+k:n+1+1)); breaks(2) = []; breaks(end-1) = [];
% uu = U(1+k:n+1+1); uu(2)=[]; uu(end-1)=[];
% plot(uu,breaks,'bs','markersize',10,'linewidth',2);  
% xlabel('$\boldmath{u}$','Interpreter','latex');
% ylabel('$C(u)$','Interpreter','latex');
% 
% grid on;
% set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
%     'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');
% 
% % -------------------------velocity-------------------------------
% d_f = fnder(f,1);
% breaks1 = fnval(d_f,U(1+k:n+1+1));   
% figure(2)
% fnplt(d_f,'b',3.3);
% xlabel('$\boldmath{u}$','Interpreter','latex');
% ylabel('$C^{(1)}(u)$','Interpreter','latex');
% 
% grid on;
% set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
%     'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');
% 
% % -----------------------------acceleration-------------------------------
% dd_f = fnder(d_f,1);
% 
% figure(3)
% fnplt(dd_f,'b',3.3);
% xlabel('$\boldmath{u}$','Interpreter','latex');
% ylabel('$C^{(2)}(u)$','Interpreter','latex');
% 
% grid on;
% set(gca,'FontName','Times New Roman','FontSize',22,'FontWeight',...,
%     'bold','Linewidth',2,'GridAlpha',.8,'GridLineStyle',':');
% 
% figure

% Plot the data and spline
subplot(3,1,1)
fnplt(f,'r',2)
hold on
grid on
breaks = fnval(f,U(1+k:n+1+1)); breaks(2) = []; breaks(end-1) = [];
uu = U(1+k:n+1+1); uu(2)=[]; uu(end-1)=[];
plot(uu,breaks,'bs','markersize',10,'linewidth',1);  
title('Cubic B-Spline with Null Initial and Final Velocities and Accelerations');
ylabel('p');
legend('Data Points', 'Cubic B-Spline');

% Plot the velocity
subplot(3,1,2)
fnplt(d_f,'g',2)
grid on
title('Velocity of Cubic B-Spline');
ylabel('v');

% Plot the acceleration
subplot(3,1,3)
fnplt(dd_f,'b',2)
grid on
title('Acceleration of Cubic B-Spline');
xlabel('time');
ylabel('a');