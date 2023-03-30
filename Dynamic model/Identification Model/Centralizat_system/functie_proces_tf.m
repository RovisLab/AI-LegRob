function J = functie_proces_tf(xyz,u,out,n)

    Ts = 0.01;
    
    k1 = xyz(1); k2 = xyz(2); k3 = xyz(3); k4 = xyz(4);
    k5 = xyz(5); k6 = xyz(6); k7 = xyz(7); k8 = xyz(8); k9 = xyz(9);
    
    T1 = xyz(10); T2 = xyz(11); T3 = xyz(12); T4 = xyz(13); T5 = xyz(14); T6 = xyz(15);
    T7 = xyz(16); T8 = xyz(17); T9 = xyz(18); T10 = xyz(19); T11 = xyz(20); T12 = xyz(21);
    
    s = tf('s');
    m1 = c2d(k1/(T1*T2*s^2+(T1+T2)*s+1),Ts,'zoh');
    m5 = c2d(k2/(T3*T4*s^2+(T3+T4)*s+1),Ts,'zoh');
    m9 = c2d(k3/(T5*T6*s^2+(T5+T6)*s+1),Ts,'zoh');
    m2 = c2d(k4/(T7*s+1),Ts,'zoh');
    m3 = c2d(k5/(T8*s+1),Ts,'zoh');
    m4 = c2d(k6/(T9*s+1),Ts,'zoh');
    m6 = c2d(k7/(T10*s+1),Ts,'zoh');
    m7 = c2d(k8/(T11*s+1),Ts,'zoh');
    m8 = c2d(k9/(T12*s+1),Ts,'zoh');
    
    M=[m1 m2 m3;
        m4 m5 m6;
        m7 m8 m9];
    

    yy = lsim(M, u');


    J = 1/n*sum(sum((out'-yy).^2),2);

end