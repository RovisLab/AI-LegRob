function x=purse(varargin)

narginchk(2,4);

    b=varargin{1};
    c=varargin{3};
    a=varargin{2};
    f=varargin{4};
    n=size(f,1);

a=[0 a]; 

beta=c(1)/b(1);
for i=2:n-1
    beta(i)=c(i)/(b(i)-a(i)*beta(i-1));
end
% y = zeros(1,n);

y(1,:)=f(1,:)/b(1);
for i=2:n
    y(i,:)=(f(i,:)-a(i)*y(i-1,:))/(b(i)-a(i)*beta(i-1));
end

x(n,:)=y(n,:);

for i=n-1:-1:1
    x(i,:)=y(i,:)-beta(i)*x(i+1,:);
end

end
