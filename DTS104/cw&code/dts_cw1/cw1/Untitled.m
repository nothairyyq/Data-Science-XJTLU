%Initiation
close all;
clc;
clear all;
format long ... Scaled fixed point format with 15 digits.
    
A=[3.556 -1.778 0;-1.778 3.556 -1.778;0 -1.778 3.556]; %Write your matrix here.
u= [1;1;1]; % The initial choice of eigenvector.
n=length(u); % Size of initial eigenvector.
v=zeros(n,1);
% m1=0;m2=0;
itr=4;
for i=1:itr
    v=A*u;
    m2=max(abs(v));
    u=v/m2;
    m1=m2;
    fprintf('\n\nWhen the iteration %d:',i);
    fprintf('\nThe greatest eigenvalue is %5.4f\n',m1);
    disp('The corresponding eigenvector is:');
    norm_u = u/norm(u);
    fprintf('\n%5.4f',norm_u);
end

e=eig(A)
