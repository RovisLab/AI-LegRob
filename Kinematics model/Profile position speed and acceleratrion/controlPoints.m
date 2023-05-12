function d = controlPoints( varargin)

u=varargin{1};
Q=varargin{2};
col=varargin{3};
boundaryCondition=varargin{4};

n = size(Q,1) -1 + 2;

b = zeros(1, n-1); a = zeros(1, n-1); c = zeros(1, n-2); e = zeros(n-1,col);

qv0 = zeros(1,col); qvn = zeros(1,col);
b(1) = 1;
e(1,:) = Q(0+ 1,:) + (u(4+ 1)-u(3+ 1))*qv0/3;
b(n-1) = 1;
e(n-1,:) = Q(n-2 +1,:) - (u(n+1 +1)-u(n+ 1))*qvn/3;

b(2) = -(u(4 +1)-u(1+ 1));
a(2) = u(5+ 1)+u(4+ 1)-u(2+ 1)-u(1+ 1);
e(2,:) = (u(5+ 1)-u(2+ 1))*Q(0+ 1,:);
b(n-2) = -(u(n+3 +1)-u(n+ 1));
c(n-2) = u(n+3 +1)+u(n+2 +1)-u(n+ 1)-u(n-1 +1);
e(n-2,:) = (u(n+2 +1)-u(n-1 +1))*Q(n-2 +1,:);

for i = 3:n-3
    da = u(i+3 +1) - u(i+ 1);
    dc = u(i+4 +1) - u(i+1 +1);
    a(i) = ((u(i+3 +1) - u(i+2 +1))^2)/(da);
    c(i) = ((u(i+2 +1) - u(i+1 +1))^2)/(dc);
    b(i) = (u(i+3 +1)-u(i+2 +1))*(u(i+2 +1)-u(i +1))/da +(u(i+2 +1)-u(i+1 +1))*(u(i+4 +1)-u(i+2 +1))/dc;
    e(i,:) = Q(i-1 +1,:)*(u(i+3 +1)-u(i+1 +1));
end

a(1) = [];    
d=purse(b,a,c,e);
d = [Q(1,:);d;Q(end,:)]; 


end

