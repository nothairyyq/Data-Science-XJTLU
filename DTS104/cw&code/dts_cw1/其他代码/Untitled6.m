%Initiation
close all;
clc;
clear all;
format long ... Scaled fixed point format with 15 digits.

f=@(t,y) 0.0259*(1-y/12000)*y;
t0=0;
y0=2555;
tn=50;
h=10;
fprintf('The result produced by Euler method:');
while t0<=tn
    fprintf('\n%d  %5.0f ',t0,y0); %values of t and y
    y1=y0+h*f(t0,y0);
    t1=t0+h;
    t0=t1;
    y0=y1;  
end

fprintf('\nThe result produced by 4th-Order Runge-Kutta method:');
ty=0:h:50;
yy = zeros(1,length(ty)); 
yy(1) = 2555;
for i=1:(length(ty))                              % calculation loop
    k_1 = f(ty(i),yy(i));
    k_2 = f(ty(i)+0.5*h,yy(i)+0.5*h*k_1);
    k_3 = f((ty(i)+0.5*h),(yy(i)+0.5*h*k_2));
    k_4 = f((ty(i)+h),(yy(i)+k_3*h));

    yy(i+1) = yy(i) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
     fprintf('\n%d %5.0f ',ty(i),yy(i));
end
