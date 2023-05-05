clear all
close all
clc


t = [0 0.4 0.7 0.9 1];

qq = [10; 20; 30; 35; 45];

n = length(t);

dqi = 0;
ddqi = 0;

H1 = [1     t(1)   (t(1))^2   (t(1))^3;
      0     1   2*(t(1))   3*(t(1))^2;
      0     0   2   6*(t(1));
      1     t(2)   (t(2))^2   (t(2))^3];

Y1 = [qq(1,1); dqi; ddqi; qq(2,1)];

cof1 = inv(H1)*Y1

%dq(1) = qq(1,1) + 3*(qq(2,1)-qq(1,1))/(t(2)-t(1));

dq(1) = 0 + 1*cof1(2,1) + 2*(t(2))*cof1(3,1) + 3*(t(2))^2*cof1(4,1);



    H2 = [1 t(2) t(2)^2;
         0  1  2*t(2);
         1  t(3)  t(3)^2];

    Y2 = [qq(2); dq(1); qq(3)];

    cof2 = inv(H2)*Y2

    dq(2) = 0 + 1*cof2(2,1) + 2*(t(3))*cof2(3,1);

    H3 = [1 t(3) t(3)^2;
         0  1  2*t(3);
         1  t(4)  t(4)^2];

    Y3 = [qq(3); dq(2); qq(4)];

    cof3 = inv(H3)*Y3

    dq(3) = 0 + 1*cof3(2,1) + 2*(t(4))*cof3(3,1) 


Hn = [1 t(n-1) t(n-1)^2 t(n-1)^3 t(n-1)^4;
      0 1 2*t(n-1) 3*t(n-1)^2 4*t(n-1)^3;
      1 t(n) t(n)^2 t(n)^3 t(n)^4;
      0 1 2*t(n) 3*t(n)^2 4*t(n)^3;
      0 0 2 6*t(n) 12*t(n)^2];

%dq(n-1) = cof(2,n-2) + 2*cof(3,n-2)*t(n-1)

Yn = [qq(n-1,1); dq(3); qq(n,1); 0; 0];

cofn = inv(Hn)*Yn

timp = 0:0.01:1;


for i = 1:length(timp)

    if timp(i) < t(2)

        qq1(i) = [1     timp(i)   timp(i)^2   timp(i)^3]*cof1;
        dq1(i) = [0     1   2*timp(i)   3*timp(i)^2]*cof1;
        ddq1(i) = [0     0   2   6*timp(i)]*cof1;


    elseif timp(i) >= t(2) && timp(i) < t(3) 

        qq1(i) = [1     timp(i)   timp(i)^2]*cof2;
        dq1(i) = [0     1   timp(i)]*cof2;


    elseif timp(i) >= t(3) && timp(i) < t(4) 
    
        qq1(i) = [1     timp(i)   timp(i)^2]*cof3;
        dq1(i) = [0     1   timp(i)]*cof3;

    elseif timp(i) >= t(4) 

        qq1(i) = [1 timp(i) timp(i)^2 timp(i)^3 timp(i)^4]*cofn;
        dq1(i) = [0 1 2*timp(i) 3*timp(i)^2 4*timp(i)^3]*cofn;
        ddq1(i) = [0 0 2 6*timp(i) 12*timp(i)^2]*cofn;

    end

end



plot(t,qq(:,1),'r')
hold on
grid on
plot(timp,qq1,'b')
figure
plot(timp,dq1,'b')
grid on
%plot(vq1,'g')
%plot(aq1,'y')



