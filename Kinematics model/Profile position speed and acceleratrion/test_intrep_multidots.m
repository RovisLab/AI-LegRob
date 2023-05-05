clear all
close all
clc

t = [0 0.4 0.7 1];

qq = [10; 20; 30; 45];

n = length(t);


dqi = 0;
ddqi = 0;

h = contruct_math(t)

Yn = [qq(1,1); 0; 0; qq(2:n,1); 0; 0];

cof = pinv(h)*Yn

t = 0:0.01:1;

for j = 1:1:length(t)

    qq1(j) = [1 t(j) t(j)^2 t(j)^3 t(j)^4 t(j)^5 t(j)^6 t(j)^7]*cof;
    vq1(j) = [0 1 2*t(j) 3*t(j)^2 4*t(j)^3 5*t(j)^4 6*t(j)^5 7*t(j)^6]*cof;
    aq1(j) = [0 0 2  6*t(j) 12*t(j)^2 20*t(j)^3 30*t(j)^4 42*t(j)^5]*cof;
end


%plot(qq(:,1),'r')
hold on
grid on
plot(t,qq1,'b')
plot(t,vq1/2,'g')
plot(t,aq1/20,'r')
