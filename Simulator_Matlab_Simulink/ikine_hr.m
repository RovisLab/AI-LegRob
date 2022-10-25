function q_hrr = ikine_hr(pstar_hr, r, x , y, z)

%     Bhr = [r,[x; y; z];0 0 0 1]*[rotz(90)*rotx(90), [0.1805; -0.047; 0]; [0 0 0 1] ];

%     Bhr = [r,[x; y; 0];0 0 0 1]*[rotz(90)*rotx(90), [0.1805; -0.047; 0]; [0 0 0 1] ];

    Bhr = [r*rotz(90)*rotx(90), [0.1805; -0.047; 0]; [0 0 0 1] ];

%     Bhr = [rotz(90)*rotx(90), [0.1805; -0.047; 0]; [0 0 0 1] ];

%     Bhr = [roty(0)*rotz(0)*rotx(0),[x; y; z];0 0 0 1]*[rotz(90)*rotx(90), [0.1805; -0.047; 0]; [0 0 0 1] ];
    
    linkshr(1) = Link([    0   0   0       -pi/2 ]);
    linkshr(2) = Link([    0   -0.0838   0.2 0   ]);
    linkshr(3) = Link([    0   0   0.2   0   ]);

    % now create a robot to represent a single leg
    leghr = SerialLink(linkshr, 'name', 'leghr', 'offset', [-pi/2   0  0], 'base', Bhr);

    qz = [0 0 0];
    
    lb_r = [-pi/4, -pi/3, -0.85833333333*pi];
    ub_r = [pi/4, 1.3333333333*pi, -0.29166666667*pi];

    A = [];
    b = [];
    Aeq = [];
    beq = [];

    syms q1 q2 q3 

    qsyms = [q1 q2 q3];


    q_hrr = fmincon( @(qsyms) norm(leghr.fkine(qsyms).t - pstar_hr), qz,A,b,Aeq,beq,lb_r,ub_r);
end

