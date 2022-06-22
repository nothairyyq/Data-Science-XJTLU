clc
clear
format long g

A = [5 -2 3 0 6; -3 9 1 -2 7.4; 2 -1 -7 1 6.7; 4 3 -5 7 9; 2 3.5 6.1 -4 -8.1];
b = [-1 2 3 0.5 3.1]';

fprintf('Jacobi\n');
n = length(b);
maxit = 1000;
x0 = rand(n,1);
tol = 1e-13;
x = Jacobi(A,b,tol,maxit,x0)

fprintf('MATLAB Built-in Function\n');
x = linsolve(A,b)

fprintf('MATLAB Built-in Function\n');
x = A\b

fprintf('MATLAB Built-in Function\n');
x = pinv(A)*b

fprintf('MATLAB Built-in Function\n');
% making the augmented matrix
Awiggle = [A b];
temp = rref(Awiggle);
x = temp(:,end)

