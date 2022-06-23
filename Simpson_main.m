function []=Simpson_main()
format long g
syms x;
f(x) = 4*x^3-4;
g(x) = 5*exp(-(x-1)^2)*x^2-2;
s(x) = sin(x)+cos(x/2);

cubic_result_num_10 = simpson(f,0,2,10);
cubic_result_num_100 = simpson(f,0,2,100);
cubic_result_num_1000 = simpson(f,0,2,1000);
cubic_result_real = int(f(x),0,2);
cubic_error(1) = abs(double((cubic_result_real-cubic_result_num_10)/cubic_result_real));
cubic_error(2) = abs(double((cubic_result_real-cubic_result_num_100)/cubic_result_real));
cubic_error(3) = abs(double((cubic_result_real-cubic_result_num_1000)/cubic_result_real));
disp('Cubic func. error ratios for 10,100,1000 points:');
disp(cubic_error);

exp_result_num_10 = simpson(g,0,3,10);
exp_result_num_100 = simpson(g,0,3,100);
exp_result_num_1000 = simpson(g,0,3,1000);
exp_result_real = int(g(x),0,3);
exp_error(1) = abs(double((exp_result_real-exp_result_num_10)/exp_result_real));
exp_error(2) = abs(double((exp_result_real-exp_result_num_100)/exp_result_real));
exp_error(3) = abs(double((exp_result_real-exp_result_num_1000)/exp_result_real));
disp('Exp func. error ratios for 10,100,1000 points:');
disp(exp_error);

sin_result_num_10 = simpson(s,0,3,10);
sin_result_num_100 = simpson(s,0,3,100);
sin_result_num_1000 = simpson(s,0,3,1000);
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

title('Simpsons Rule Errors');
legend('cubic','exp','sin');
xlabel('Division points');
ylabel('Error ratio');
end

function [result]=simpson(infunc,low,high,partition)
interval=(high-low)/partition;
result=0;
for i=1:partition
    result=result+interval*(infunc((low+interval*(i-1)))/6+infunc(low+interval*(i))/6+infunc(low+interval*(i-0.5))*2/3);
end
end