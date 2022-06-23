function []=Monte_Carlo_main()
format long g
syms x;
f(x) = 4*x^3-4;
g(x) = 5*exp(-(x-1)^2)*x^2-2;
s(x) = sin(x)+cos(x/2);

cubic_result_num_10 = Monte_Carlo_Int(f,0,2,10);
cubic_result_num_100 = Monte_Carlo_Int(f,0,2,100);
cubic_result_num_1000 = Monte_Carlo_Int(f,0,2,1000);
cubic_result_real = int(f(x),0,2);
cubic_error(1) = abs(double((cubic_result_real-cubic_result_num_10)/cubic_result_real));
cubic_error(2) = abs(double((cubic_result_real-cubic_result_num_100)/cubic_result_real));
cubic_error(3) = abs(double((cubic_result_real-cubic_result_num_1000)/cubic_result_real));
disp('Cubic func. error ratios for 10,100,1000 points:');
disp(cubic_error);

exp_result_num_10 = Monte_Carlo_Int(g,0,3,10);
exp_result_num_100 = Monte_Carlo_Int(g,0,3,100);
exp_result_num_1000 = Monte_Carlo_Int(g,0,3,1000);
exp_result_real = int(g(x),0,3);
exp_error(1) = abs(double((exp_result_real-exp_result_num_10)/exp_result_real));
exp_error(2) = abs(double((exp_result_real-exp_result_num_100)/exp_result_real));
exp_error(3) = abs(double((exp_result_real-exp_result_num_1000)/exp_result_real));
disp('Exp func. error ratios for 10,100,1000 points:');
disp(exp_error);

sin_result_num_10 = Monte_Carlo_Int(s,0,3,10);
sin_result_num_100 = Monte_Carlo_Int(s,0,3,100);
sin_result_num_1000 = Monte_Carlo_Int(s,0,3,1000);
sin_result_real = int(s(x),0,3);
sin_error(1) = abs(double((sin_result_real-sin_result_num_10)/sin_result_real));
sin_error(2) = abs(double((sin_result_real-sin_result_num_100)/sin_result_real));
sin_error(3) = abs(double((sin_result_real-sin_result_num_1000)/sin_result_real));
disp('Sin func. error ratios for 10,100,1000 points:');
disp(sin_error);

x_axis = [10 100 1000];
figure
loglog(x_axis,cubic_error)
hold on
loglog(x_axis,exp_error)
hold on
loglog(x_axis,sin_error)

title('Monte-Carlo Integration Errors');
legend('cubic','exp','sin');
xlabel('Division points');
ylabel('Error ratio');
end

function [answer] = Monte_Carlo_Int(f,a,b,N)

f_max = 0;
f_min = 0;
for i = 1 : 1001
    f_index = f(a+(i-1)*(b-a)/1000);
    if f_index >= f_max
        f_max = f_index;
    end
    if f_index <= f_min
        f_min = f_index;
    end
end
x = zeros(N);
y = zeros(N);
K=0;
L=0;
%succesful_x = [];
%succesful_y = [];
for i = 1 : N
    x(i) = a+rand*(b-a);
    y(i) = f_min+rand*(f_max-f_min);
    if (f(x(i))>=0) && (y(i)<f(x(i))) && (y(i)>0)
        K=K+1;
        %succesful_x = [succesful_x, x(i)];
        %succesful_y = [succesful_y, y(i)];
    end
    if (f(x(i))<0) && (y(i)>f(x(i))) && (y(i)<0)
        L=L+1;
        %succesful_x = [succesful_x, x(i)];
        %succesful_y = [succesful_y, y(i)];
    end
end
%plot(succesful_x,succesful_y,'.')
answer = (f_max-f_min)*(b-a)*(K-L)/N;
end