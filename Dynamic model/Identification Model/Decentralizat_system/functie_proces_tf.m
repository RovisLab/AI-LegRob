function J = functie_proces_tf(xyz,u,out,n)

    Ts = 0.01;
    
    k1 = xyz(1); 
    k2 = xyz(2); 
    k3 = xyz(3);
    
    T1 = xyz(4); T2 = xyz(5);
    T3 = xyz(6); T4 = xyz(7);
    T5 = xyz(8); T6 = xyz(9);
    
    s = tf('s');
    m1 = c2d(k1/(s*(T1*T2*s^2+(T1+T2)*s+1)),Ts,'zoh');
    m2 = c2d(k2/(s*(T3*T4*s^2+(T3+T4)*s+1)),Ts,'zoh');
    m3 = c2d(k3/(s*(T5*T6*s^2+(T5+T6)*s+1)),Ts,'zoh');
    

    yy(:,1) = lsim(m1, u(1,:));
    yy(:,2) = lsim(m2, u(2,:));
    yy(:,3) = lsim(m3, u(3,:));


    J = 1/n*sum(sum((out'-yy).^2),2);

end