clear all
close all
clc
% Define the x and y values for the spline
x = linspace(0, 1, 7);
y = [0, 1, 0, -1, 0];

% Define the initial and final conditions for the first and second derivatives
y_prime_0 = 0; % first derivative at x=0
y_prime_n = 0; % first derivative at x=n
y_double_prime_0 = 0; % second derivative at x=0
y_double_prime_n = 0; % second derivative at x=n

% Generate the spline
s = spline(x, [y_prime_0, 0, y, y_prime_n, 0]);
s.coefs(:, 4) = s.coefs(:, 4) + y_double_prime_0;
s.coefs(:, end) = s.coefs(:, end) + y_double_prime_n;

% Plot the spline and its first and second derivatives
xx = linspace(0, 1, 1000);
yy = ppval(s, xx);
plot(xx, yy, 'LineWidth', 2);
hold on;
yy_prime = ppval(fnder(s, 1), xx);
plot(xx, yy_prime, 'LineWidth', 2);
yy_double_prime = ppval(fnder(s, 2), xx);
plot(xx, yy_double_prime, 'LineWidth', 2);
legend('Spline', 'First Derivative', 'Second Derivative');
xlabel('x');
ylabel('y');






%%

clear all
close all
clc

% Define n data points
x = [0 0 1 2 3 4 4];
y = [1 3 2 4 1];

% Create a cubic spline with null initial and final velocities and accelerations
spline = csape(x, [0, y, 0], 'variational');



% Evaluate the spline at new points
xi = linspace(0, 4, 101);
yi = fnval(spline, xi);

% Compute the first and second derivatives of the spline
spline1 = fnder(spline, 1);
spline2 = fnder(spline, 2);
vi = fnval(spline1, xi);
ai = fnval(spline2, xi);

% Plot the data and spline
subplot(3,1,1)
plot(x(2:end-1), y, 'o', xi, yi);
title('B-Spline with Null Initial and Final Velocities and Accelerations');
ylabel('y');
legend('Data Points', 'Cubic Spline');

% Plot the velocity
subplot(3,1,2)
plot(xi, vi);
title('Velocity of Cubic Spline');
ylabel('v');

% Plot the acceleration
subplot(3,1,3)
plot(xi, ai);
title('Acceleration of Cubic Spline');
xlabel('x');
ylabel('a');
