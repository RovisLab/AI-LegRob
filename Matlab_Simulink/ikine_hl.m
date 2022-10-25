function q_hl = ikine_hr(pstar_hl, r, x , y, z)

    Bhl = [r,[x; y; z];0 0 0 1]*[rotz(90)*rotx(90), [0.1805; 0.047; 0]; [0 0 0 1] ];
    
    linkshl(1) = Link([    0   0   0       -pi/2 ]);
    linkshl(2) = Link([    0   0.0838   0.2 0   ]);
    linkshl(3) = Link([    0   0   0.2   0   ]);

    % now create a robot to represent a single leg
    leghl = SerialLink(linkshl, 'name', 'leghr', 'offset', [-pi/2   0  0], 'base', Bhl);

    qz = [0 0 0];
    
    lb_l = [-pi/4, -pi/3, -0.85833333333*pi];
    ub_l = [pi/4, 1.3333333333*pi, -0.29166666667*pi];

    A = [];
    b = [];
    Aeq = [];
    beq = [];

    syms q1 q2 q3 

    qsyms = [q1 q2 q3];


    q_hl = fmincon( @(qsyms) norm(leghl.fkine(qsyms).t - pstar_hl), qz,A,b,Aeq,beq,lb_l,ub_l);
end

