% Sample point

A = [0.1105, -0.1308, -0.15]';
C = [0.1205, -0.1408, -0.10]';
B = [0.1305, -0.1308, -0.15]';

t = [1, 2, 3]; % Assumed time stamp

x = [A(1), C(1), B(1)]
y = [A(2), C(2), B(2)]
z = [A(3), C(3), B(3)]

tt = linspace(t(1),t(end));

xx = interp1(t,x,tt,'spline');
yy = interp1(t,y,tt,'spline');
zz = interp1(t,z,tt,'spline');
% Visualize the result
figure
scatter3(x,y,z)
hold on
plot3(xx,yy,zz)