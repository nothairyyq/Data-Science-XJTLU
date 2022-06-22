clear all
clc
f=@(x)(-3)*x^5+2*x^4-x^3+4; %Write your function f(x), where f(x)=0.
% Root lies between in the interval (x0, x1).
x0=input('\n Enter left point of interval '); %here x0=2
x1=input('\n Enter right point of interval ');%here x1=3
epsilon=input('\n Enter the error '); %error of tolerance you want. for exmple 0.001 or 0.0001 etc.
 err=abs(x1-x0);
 %Formula: x2=(x0*f(x1)-x1*f(x0))/(f(x1)-f(x0));
 if f(x0)*f(x1)>0 
    disp('Enter valid interval !!!')
 else
while err > epsilon
    x2=(x0*f(x1)-x1*f(x0))/(f(x1)-f(x0));
     x0=x1;        
     x1=x2;
    err=abs(x1-x0);
    root=x2;
   
 end
    fprintf('\n The root is %4.3f ',root);
 end