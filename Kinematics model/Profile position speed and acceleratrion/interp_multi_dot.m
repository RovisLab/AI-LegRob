function cof = interp_multi_dot(qi,qf,dq,tf,ti)
    
    A = [1 ti ti^2;
         0  1  2*ti;
         1  tf  tf^2];

    Y = [qi; dq; qf];

    cof = inv(A)*Y;

end

