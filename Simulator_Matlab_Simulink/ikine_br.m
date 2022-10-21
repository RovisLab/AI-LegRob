function q_br = ikine_br(pstar_br, r, x , y, z)

    Bbr = [r,[x; y; z];0 0 0 1]*[rotz(90)*rotx(90), [-0.1805; -0.047; 0]; [0 0 0 1] ];
    
    linksbr(1) = Link([    0   0   0       -pi/2 ]);
    linksbr(2) = Link([    0   -0.0838   0.2 0   ]);
    linksbr(3) = Link([    0   0   0.2   0   ]);

    % now create a robot to represent a single leg
    legbr = SerialLink(linksbr, 'name', 'legbr', 'offset', [-pi/2   0  0], 'base', Bbr);

    qz = [0 0 0];
    
    A = [];
    b = [];
    Aeq = [];
    beq = [];

    lb_r = [-pi/4, -pi/3, -0.85833333333*pi];
    ub_r = [pi/4, 1.3333333333*pi, -0.29166666667*pi];

    syms q1 q2 q3 

    qsyms = [q1 q2 q3];


    q_br = fmincon( @(qsyms) norm(legbr.fkine(qsyms).t - pstar_br), qz,A,b,Aeq,beq,lb_r,ub_r);
end

