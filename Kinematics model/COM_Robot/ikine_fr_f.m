function q_r = ikine_fr_f(pstar, Tx, Ty, Tz , Rx, Ry, Rz)
    
    R_DH = rotz(0)*roty(90)*rotx(0);
    T_DH = [0; 0; 0];
    O_DH = [R_DH, T_DH; [0 0 0 1] ];
    
    R_fr = rotz(0)*rotx(0);
    T_fr = [0; -0.047; 0.1805];
    O_fr = [R_fr, T_fr; [0 0 0 1] ];
    
    R_c_corp = rotz(Rx)*roty(Ry)*rotx(Rz);
    T_c_corp = [-Tz; Ty; Tx];
    O_c_corp = [R_c_corp, T_c_corp; [0 0 0 1] ];
        
    B =  O_DH * O_c_corp * O_fr;
    
    pzero = [B(1,4), B(2,4), B(3,4)];
    
    x0_ = pzero(1);
    y0_ = pzero(2);
    z0_ = pzero(3);
    
    x_ = pstar(1);
    y_ = pstar(2);
    z_ = pstar(3);

    Rot = [rotz(Rz)*roty(-Ry)*rotx(-Rx), [0; 0; 0]; [0 0 0 1]];
    Point = [1 0 0 x_-x0_; 0 1 0 y_-y0_; 0 0 1 z_-z0_; 0 0 0 1];
    Origin = [1 0 0 x0_; 0 1 0 y0_; 0 0 1 z0_; 0 0 0 1];
    
    pstar = Origin + Rot*Point;

    x_ = pstar(1,4);
    y_ = pstar(2,4);
    z_ = pstar(3,4);


%     d = sqrt((x_ - x0_)*(x_ - x0_) + (y_ - y0_)*(y_ - y0_) + (z_ - z0_)*(z_ - z0_));
% 
%     th = acos((z_ - z0_)/d) 
%     fis = acos((x_ - x0_)/(d*sin(th)))% + Rz*2*pi/360
% 
%     star = [x0_; y0_; z0_] + rotx(Rx)*roty(-Ry)*rotz(Rz)*(d.*[cos(fis)*sin(th); sin(fis)*sin(th); cos(th)]) 
%     
%     x_ = star(1)
%     y_ = star(2)
%     z_ = star(3)

    
    off = 0.0838;
    L = 0.2;

    m = sqrt((z_ - z0_)*(z_ - z0_));
    n = sqrt( (y_ - y0_)*(y_ - y0_));
    p = sqrt( (y0_ - y_)*(y0_ - y_) + (z0_ - z_)*(z0_ - z_));
    alp0 = atan(n/m);
    alp1 = asin(off/p);
    q1_ = -(alp0 - alp1) ;

    x = sqrt((x_ - x0_)*(x_ - x0_));
    r = sqrt(p*p - off*off);
    a = sqrt(r*r + x*x);

    fi = asin((x_ - x0_)/a);

    alpha = acos((a*a + L*L - L*L)/(2*a*L));
    q2_ =  alpha - fi ;
    q3_ = -pi + acos((L*L + L*L - a*a)/(2*L*L)) ;

    q_r = [q1_, q2_, q3_];

end
