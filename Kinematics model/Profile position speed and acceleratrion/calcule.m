clear all
clc

% Define the data points
x = [0 2.5 5 7 8 10 15 16.5 18];
y = [3 5.48 -2 -5 0 6 12 11.68 8];

% define n data points
% x = [x0, x1, ..., xn-1]; % x coordinates of the points
% y = [y0, y1, ..., yn-1]; % y coordinates of the points
n = length(x);

% calculate values of hi
h = diff(x)

% define matrix A and vector b
A = zeros(n);
A(1,1) = 1;
A(n,n) = 1;
for i = 2:n-1

    A(i,i-1) = h(i-1);
    A(i,i) = 2*(h(i-1)+h(i));
    A(i,i+1) = h(i);
    
%     A(i,i) = 2*h(i+1) + h(i)*() 
%     A(i,i+1) = 

end
b = zeros(n,1);
for i = 2:n-1
    b(i) = 6*((y(i+1)-y(i))/h(i) - (y(i)-y(i-1))/h(i-1));
    %b(i) = 6*((y(i+2)-y(i+1))/h(i+1) - (y(i+1)-y(i-1))/h(i))
end

% solve system of equations to obtain second derivatives d
A
b

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
