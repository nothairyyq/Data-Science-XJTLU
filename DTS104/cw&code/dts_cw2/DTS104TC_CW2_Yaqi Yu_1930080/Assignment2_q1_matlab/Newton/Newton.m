%1.2.1 Newton-Raphson method

%Input: x0: Initial guess;
% 	    tol: tolerance;
%		fun: function handle;
%		true_value:  true value;

%output: ap_root: approxieation of root eatrix:
%       fx: each approxieation of root function value: f(ap_root)
% 		count: nueber of iterations
%		error: relative of error


function [ap_root,fx,count,error]=Newton(x0,tol,fun,true_value)

ap_root=[];		%ap_root vector store approxieation of root
fx=[];			%fx vector store function value
error=[];		%error vector store relative error
count=0;		%set initial nueber of iterations
x1=x0+1;		%set initial x1
e=1;

while(e>tol)
    count=count+1;		%count number of iterations
    f=feval(fun,x0);		%get the x0 function value
    x1=x0-f/df(x0);		%iteration each x1 using Newton-Raphson
    
    e=abs((x1-true_value)/true_value);		%compute relative error
    x0=x1;						%X1 passes the value to x0 for the next iteration
    f=feval(fun,x0);				%get the ap_root function value
    
	ap_root=[ap_root;x0];		%store ap_root in vector
    fx=[fx;f];					%store function value in vector
	error=[error;e];			%store relative error
   
end


%display result in matrix
disp('  Iteration        Approximation of root             f(root)               relative error         ')
for i=1:count
    fprintf('%2d        %20.6f        %20.6f      %20.6f \n  ',i,ap_root(i),fx(i),error(i))
end