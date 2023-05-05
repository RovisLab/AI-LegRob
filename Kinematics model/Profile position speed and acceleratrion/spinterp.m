clear all
clc

% Define the data points
u = [0 2.5 5 7 8 10 15 16.5 18];
Q = [3 5.48 -2 -5 0 6 12 11.68 8];

% define n data points
% x = [x0, x1, ..., xn-1]; % x coordinates of the points
% y = [y0, y1, ..., yn-1]; % y coordinates of the points
n = length(Q);

% calculate values of hi
h = diff(u)
b = zeros(1,n)
e = zeros(1,n)
c = zeros(1,n)
a = zeros(1,n)

% define matrix A and vector b

col = 1 

         qv0 = zeros(1,col); qvn = zeros(1,col);
        b(1) = 1;
        e(1) = Q(0+ 1) + (u(4+ 1)-u(3+ 1))*qv0/3;
        b(n-1) = 1;
        e(n-1) = Q(n-2 +1) - (u(n+1 +1)-u(n+ 1))*qvn/3;
        
        b(2) = -(u(4 +1)-u(1+ 1));
        a(2) = u(5+ 1)+u(4+ 1)-u(2+ 1)-u(1+ 1);
        e(2,:) = (u(5+ 1)-u(2+ 1))*Q(0+ 1,:);
        b(n-2) = -(u(n+3 +1)-u(n+ 1));
        c(n-2) = u(n+3 +1)+u(n+2 +1)-u(n+ 1)-u(n-1 +1);
        e(n-2) = (u(n+2 +1)-u(n-1 +1))*Q(n-2 +1,:);


%%
d = (inv(A)*b)'

% define coefficients of cubic polynomials
a = y;
b = diff(y)./h - (2*d(1:end-1) + d(2:end)).*h/3
c = (d(2:end) - d(1:end-1))./(3*h)
c = [0; c'; 0];
d = d(1:end-1)./h.^2;
d = [0; d'; 0];

% define function for cubic spline
xx = linspace(x(1), x(end), 1000);
spline_fun = @(xx) zeros(size(xx));
for i = 1:n-1
    idx = (x(i) <= xx) & (xx <= x(i+1));
    xx_i = xx(idx) - x(i);
    spline_fun(idx) = a(i) + b(i)*xx_i + c(i)*xx_i.^2 + d(i)*xx_i.^3;
end

% plot the cubic spline

yy = spline_fun(xx);
plot(xx, yy);
hold on;
plot(x, y, 'o');
xlabel('x');
ylabel('y');
title('Cubic Interpolating Spline');
legend('Spline', 'Data Points');
