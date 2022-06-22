%assignment2-1.1 bisection method
%compute f(x) = 0's each approximation of root, Iteration, errorlative eor

%input: initial guesses: a,b; 
%       maximum iteration: max; tolerance:tol;
%		Function handle: fun


%output: ap_root: approximation of root matrix:
%       gap: Interval length: 
%       fx: each approximation of root function value: f(ap_root)
% 		count: number of iterations
%		error: relative of error


function [ap_root,gap,fx,count,error]=bisect(a,b,max,tol,fun)

e=tol+1;%set initial errorlative error
count=0;	%set initial number of iterations
ap_root=[];	%ap_root vector store approximation of root
gap=[];		%gap vector store interval length
error=[];	%error vector store relative error
fx=[];		%fx vector store function value
while(e>tol&&count<max)
    
    count=count+1;
    c=(a+b)/2;
    x=c;
	
    ap_root=[ap_root;x];	%Store the iterative value in the ap_root matrix
    fc=feval(fun,x);		%compute function value of ap_root
    fx=[fx;fc];				%store the function value in the fx matrix
    x=a;
	
	e=abs(b-a);	%compute relative error
	
    %Determine which area the root is in
    if(fc*feval(fun,x)<0)
        b=c;
    else
        a=c;
    end
	
    dis=abs(a-b);		%compute length of interval
    gap=[gap;dis];
    error=[error;e];
end

%display result in matrix
disp('  Iteration        Approximation of root             length of interval             f(root)               relative error         ')
for i=1:count
    fprintf('%2d        %20.6f        %25.6f       %20.6f      %20.6f \n  ',i,ap_root(i),gap(i),fx(i),error(i))
end



