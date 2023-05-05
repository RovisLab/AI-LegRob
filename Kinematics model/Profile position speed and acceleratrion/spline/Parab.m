function X = Parab(A, B, nr_p)

t = linspace(-1,1,nr_p);

d = 0.08;

C = 1/2*(A + B);
D = C + [0, 0, d]';

X = C + (C - A)*t + (D-C)*(1-t.^2);

end

