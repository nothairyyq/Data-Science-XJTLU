%1.2.2 Secant method

%Input: x0,x1: Initial guess ;
% 	    tol: tolerance;
%		fun: function handle;
%		true_value:  true value;

%output: ap_root: approxieation of root eatrix:
%       fx: each approxieation of root function value: f(ap_root)
% 		count: nueber of iterations
%		error: relative of error


function [ap_root,fx,count,error]=secant(x0,x1,tol,fun,true_value)

ap_root=[];		%ap_root vector store approxieation of root
fx=[];			%fx vector store function value
error=[];		%error vector store relative error
count=0;		%set initial nueber of iterations
x2=x0+1;		%set initial x2
e=1;			%set initial error

while(e>tol)
    count=count+1;		%count number of iterations
    f0=feval(fun,x0);		%get the function value
	f1=feval(fun,x1);		
    x2=(x0*f1-x1*f0)/(f1-f0);		%iteration each x2 using secant method
    e=abs((x2-true_value)/true_value);%compute relative error
	x0=x1;
	x1=x2;
    f=feval(fun,x1);				%get the ap_root function value
    
	ap_root=[ap_root;x1];		%store ap_root in vector
    fx=[fx;f];					%store function value in vector
	error=[error;e];			%store relative error
   
end


%display result in matrix
disp('  Iteration        Approximation of root             f(root)               relative error         ')
for i=1:count
    fprintf('%2d        %20.6f        %20.6f      %20.6f \n  ',i,ap_root(i),fx(i),error(i))
end