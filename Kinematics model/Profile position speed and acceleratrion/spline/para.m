function u = para( r,Q,k )

u = zeros(1, r + 1);

for i = 0:r-1
    delta = sqrt(norm(Q(i+1 +1,:)-Q(i+ 1,:)));
    u(i+1 +1) = u(i+ 1) + delta;
end
        
u = u/u(r + 1);    
u = [zeros(1,k) u ones(1,k)];

end

