clear all
clc
close all
% optimizare

data = load('matdate.mat');
xyz = load('testdata.mat', 'xyz');
xyz = xyz.xyz;

in_fr_h = data.fr_h_com;
in_fr_t = data.fr_t_com;
in_fr_c = data.fr_c_com;

in_fr = [in_fr_h'; in_fr_t'; in_fr_c'];    

out_fr_h = normalize(data.fr_h_w);
out_fr_t = normalize(data.fr_t_w);
out_fr_c = normalize(data.fr_c_w);

out_fr_p = [out_fr_h'; out_fr_t'; out_fr_c'];

    Ts = 0.01;
    
    a11 = xyz(1); a12 = xyz(2); a13 = xyz(3); a21 = xyz(4);
    a22 = xyz(5); a23 = xyz(6); a31 = xyz(7); a32 = xyz(8); a33 = xyz(9);
    
    b11 = xyz(10); b12 = xyz(11); b13 = xyz(12);
    b21 = xyz(13); b22 = xyz(14); b23 = xyz(15);
    b31 = xyz(16); b32 = xyz(17); b33 = xyz(18);

    c11 = xyz(19); c12 = xyz(20); c13 = xyz(21);
    c21 = xyz(22); c22 = xyz(23); c23 = xyz(24);
    c31 = xyz(25); c32 = xyz(26); c33 = xyz(27);

    d11 = xyz(28); d12 = xyz(29); d13 = xyz(30);
    d21 = xyz(31); d22 = xyz(32); d23 = xyz(33);
    d31 = xyz(34); d32 = xyz(35); d33 = xyz(36);


    A = [a11 a12 a13; a21 a22 a23; a31 a32 a33];
    B = [b11 b12 b13; b21 b22 b23; b31 b32 b33];
    C = [c11 c12 c13; c21 c22 c23; c31 c32 c33];
    D = [d11 d12 d13; d21 d22 d23; d31 d32 d33];

    sys = ss(A,B,C,D,Ts);

    yy = lsim(sys, in_fr');

    plot(yy(:,1),'b')
    hold on
    grid on
    plot(out_fr_p(1,:),'r')
figure
    plot(yy(:,2),'b')
    hold on
    grid on
    plot(out_fr_p(2,:),'r')
figure
    plot(yy(:,3),'b')
    hold on
    grid on
    plot(out_fr_p(3,:),'r')