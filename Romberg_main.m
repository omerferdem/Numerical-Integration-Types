function []=Romberg_main()
syms x;
f(x) = 4*x^3-4;
g(x) = 5*exp(-(x-1)^2)*x^2-2;
s(x) = sin(x)+cos(x/2);

cubic_result_num_10 = romberg(f,0,2,10);
cubic_result_num_100 = romberg(f,0,2,100);
cubic_result_num_200 = romberg(f,0,2,200);
cubic_result_real = int(f(x),0,2);
cubic_error(1) = abs(double((cubic_result_real-cubic_result_num_10)/cubic_result_real));
cubic_error(2) = abs(double((cubic_result_real-cubic_result_num_100)/cubic_result_real));
cubic_error(3) = abs(double((cubic_result_real-cubic_result_num_200)/cubic_result_real));
disp('Cubic func. error ratios for 10,100,200 points:');
disp(cubic_error);

exp_result_num_10 = romberg(g,0,3,10);
exp_result_num_100 = romberg(g,0,3,100);
exp_result_num_200 = romberg(g,0,3,200);
exp_result_real = int(g(x),0,3);
exp_error(1) = abs(double((exp_result_real-exp_result_num_10)/exp_result_real));
exp_error(2) = abs(double((exp_result_real-exp_result_num_100)/exp_result_real));
exp_error(3) = abs(double((exp_result_real-exp_result_num_200)/exp_result_real));
disp('Exp func. error ratios for 10,100,200 points:');
disp(exp_error);

sin_result_num_10 = romberg(s,0,3,10);
sin_result_num_100 = romberg(s,0,3,100);
sin_result_num_200 = romberg(s,0,3,200);
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

title('Romberg Integration Errors');
legend('cubic','exp','sin');
xlabel('Division points');
ylabel('Error ratio');
end

function romberg_result = romberg(f,a,b,N)
r=zeros(N,N);
%counter=0;
for j=1:N
    r(j,1) = trapezoidal(f,a,b,1+j);
    if N~=1
        for k=2:j
            r(j,k) = (4^(k-1)*r(j,k-1)-r(j-1,k-1))/(4^(k-1)-1);
            %counter=counter+1;
            %if mod(counter,100)==0
                %disp(j);
                %disp(k);
                %disp('-------------------------')
            %end
        end
    end
end
romberg_result = r(N,N);
end

function [result]=trapezoidal(f,a,b,N)
h=(b-a)/N;
result=f(a)+f(b);
if N~=2
    for l=2:(N-1)
        result=result+2*f(a+h*l);
    end
end
result = result*h/2;
end