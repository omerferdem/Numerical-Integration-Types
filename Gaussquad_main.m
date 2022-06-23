function [] = Gaussquad_main()
format long g
syms x;
f(x) = 4*x^3-4;
g(x) = 5*exp(-(x-1)^2)*x^2-2;
s(x) = sin(x)+cos(x/2);

cubic_result_num_10 = gaussquad(f,0,2,10);
cubic_result_num_100 = gaussquad(f,0,2,100);
cubic_result_num_200 = gaussquad(f,0,2,200);
cubic_result_real = int(f(x),0,2);
cubic_error(1) = abs(double((cubic_result_real-cubic_result_num_10)/cubic_result_real));
cubic_error(2) = abs(double((cubic_result_real-cubic_result_num_100)/cubic_result_real));
cubic_error(3) = abs(double((cubic_result_real-cubic_result_num_200)/cubic_result_real));
disp('Cubic func. error ratios for 10,100,200 points:');
disp(cubic_error);

exp_result_num_10 = gaussquad(g,0,3,10);
exp_result_num_100 = gaussquad(g,0,3,100);
exp_result_num_200 = gaussquad(g,0,3,200);
exp_result_real = int(g(x),0,3);
exp_error(1) = abs(double((exp_result_real-exp_result_num_10)/exp_result_real));
exp_error(2) = abs(double((exp_result_real-exp_result_num_100)/exp_result_real));
exp_error(3) = abs(double((exp_result_real-exp_result_num_200)/exp_result_real));
disp('Exp func. error ratios for 10,100,200 points:');
disp(exp_error);

sin_result_num_10 = gaussquad(s,0,3,10);
sin_result_num_100 = gaussquad(s,0,3,100);
sin_result_num_200 = gaussquad(s,0,3,200);
sin_result_real = int(s(x),0,3);
sin_error(1) = abs(double((sin_result_real-sin_result_num_10)/sin_result_real));
sin_error(2) = abs(double((sin_result_real-sin_result_num_100)/sin_result_real));
sin_error(3) = abs(double((sin_result_real-sin_result_num_200)/sin_result_real));
disp('Sin func. error ratios for 10,100,200 points:');
disp(sin_error);

x_axis = [10 100 200];
figure
loglog(x_axis,cubic_error)
hold on
loglog(x_axis,exp_error)
hold on
loglog(x_axis,sin_error)

title('Gaussian Quadrature Integration Errors');
legend('cubic','exp','sin');
xlabel('Division points');
ylabel('Error ratio');
end
function anss = gaussquad(f,a,b,points)
% Author:  Matt Fig
% Date:  revised 1/31/2006
% Contact:  popkenai@yahoo.com
tol = 1;
cnt = 1;  
ints = points/2;  
maxcount = 35;   
anss1 = 1;  
anss2 = 0;                                                                                                                                                   
while abs(anss2-anss1) >= tol && cnt < maxcount
      anss1 = core(f,a,b,points,ints);
      anss2 = core(f,a,b,points+8,ints+3);
      points =  points+16;
      ints = ints+6;
      cnt = cnt+1;
end 
anss = anss2;
end
function anss = core(f,a,b,points,ints)
[abs1, wgt1] = Gauss(points);
bb(1) = a;
bb(2:ints) = (2:ints)*(b-a)/ints+a;
dif = diff(bb)/2;
an = f((abs1+1)*dif+repmat(bb(1:end-1),points,1));
new = dif*an'*wgt1;
anss = sum(new(:));
end
function [x, w] = Gauss(n)
x = zeros(n,1);
w = x;
m = (n+1)/2;
for ii=1:m
    z = cos(pi*(ii-.25)/(n+.5));
    z1 = z+1;
while abs(z-z1)>eps
    p1 = 1;
    p2 = 0;
    for jj = 1:n
        p3 = p2;
        p2 = p1;
        p1 = ((2*jj-1)*z*p2-(jj-1)*p3)/jj;
    end
    pp = n*(z*p1-p2)/(z^2-1);
    z1 = z;
    z = z1-p1/pp;
end
    x(ii) = -z;
    x(n+1-ii) = z;
    w(ii) = 2/((1-z^2)*(pp^2));
    w(n+1-ii) = w(ii);
end
end