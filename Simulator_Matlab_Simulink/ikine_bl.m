function q_bl = ikine_bl(pstar_bl, r, x , y, z)

%     Bbl = [r,[x; y; z];0 0 0 1]*[rotz(90)*rotx(90), [-0.1805; 0.047; 0]; [0 0 0 1] ];

%     Bbl = [r,[x; y; 0];0 0 0 1]*[rotz(90)*rotx(90), [-0.1805; 0.047; 0]; [0 0 0 1] ]; 

    Bbl = [r*rotz(90)*rotx(90), [-0.1805; 0.047; 0]; [0 0 0 1] ]; 
    
%     Bbl = [rotz(90)*rotx(90), [-0.1805; 0.047; 0]; [0 0 0 1] ]; 

%     Bbl = [roty(0)*rotz(0)*rotx(0), [x; y; z]; 0 0 0 1]*[rotz(90)*rotx(90), [-0.1805; 0.047; 0]; [0 0 0 1] ];
    
    linksbl(1) = Link([    0   0   0       -pi/2 ]);
    linksbl(2) = Link([    0   0.0838   0.2 0   ]);
    linksbl(3) = Link([    0   0   0.2   0   ]);

    % now create a robot to represent a single leg
    legbl = SerialLink(linksbl, 'name', 'legbl', 'offset', [-pi/2   0  0], 'base', Bbl);

    qz = [0 0 0];
    
    lb_l = [-pi/4, -pi/3, -0.85833333333*pi];
    ub_l = [pi/4, 1.3333333333*pi, -0.29166666667*pi];

    A = [];
    b = [];
    Aeq = [];
    beq = [];

    syms q1 q2 q3 

    qsyms = [q1 q2 q3];


    q_bl = fmincon( @(qsyms) norm(legbl.fkine(qsyms).t - pstar_bl), qz,A,b,Aeq,beq,lb_l,ub_l);
end

