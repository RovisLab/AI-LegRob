clear all
close all
clc

A = [0.1105, -0.1308, -0.15]';
B = [0.1305, -0.1308, -0.15]';

rx = 0;
ry = 0;
rz = 0;
tx = 0;
ty = 0;
tz = 0;

nr_p = 1;

traj = Parab(A, B, nr_p)

for i=1:length(traj(1,:))

    qq(i,:) = ikine_fr_f(traj(:,i), tx, ty, tz, rx, ry, rz);
    tp = linspace(0,1,length(traj));

end

n = length(tp);

t = 0:0.01:1;

for i = 1:3


    dqi = 0;
    ddqi = 0;
    
    h = contruct_math(tp);
    
    Yn = [qq(1,i); 0; 0; qq(2:n,i); 0; 0];
    
    cof = pinv(h)*Yn;
    
    for j = 1:1:length(t)
    
        qq1(i,j) = [1 t(j) t(j)^2 t(j)^3 t(j)^4 t(j)^5 t(j)^6 t(j)^7]*cof;
        vq1(i,j) = [0 1 2*t(j) 3*t(j)^2 4*t(j)^3 5*t(j)^4 6*t(j)^5 7*t(j)^6]*cof;
        aq1(i,j) = [0 0 2  6*t(j) 12*t(j)^2 20*t(j)^3 30*t(j)^4 42*t(j)^5]*cof;

    end

end

% hold on
% grid on
% plot(qq1(3,:),'b')
% plot(qq(:,3),'g')

figure

hold on
grid on
plot(qq1(1,:),'b')
plot(vq1(1,:)/2,'g')
plot(aq1(1,:)/20,'r')

figure

hold on
grid on
plot(qq1(2,:),'b')
plot(vq1(2,:)/2,'g')
plot(aq1(2,:)/20,'r')

figure

hold on
grid on
plot(qq1(3,:),'b')
plot(vq1(3,:)/2,'g')
plot(aq1(3,:)/20,'r')

