function main
% This is question1 main program
f1= @(x) (-139.34411) + (1.575701*10^5)/x-(6.642308*10^7)/x^2+(1.2438*10^10)/x^3-8.621949*10^11/x^4 - log(8);
f2= @(x) (-139.34411) + (1.575701*10^5)/x-(6.642308*10^7)/x^2+(1.2438*10^10)/x^3-8.621949*10^11/x^4- log(10);
f3= @(x) (-139.34411) + (1.575701*10^5)/x-(6.642308*10^7)/x^2+(1.2438*10^10)/x^3-8.621949*10^11/x^4- log(13);
disp('Case1: y=8');
AnswerOne_function(273.15,313.15,0.01,f1);  %solve x for the y = 8, and absolute error = 0.01
disp('Case2: y=10');
AnswerOne_function(273.15,313.15,0.01,f2);   %solve x for the y = 10, and absolute error = 0.01
disp('Case3: y=13');
AnswerOne_function(273.15,313.15,0.01,f3);  %solve x for the y = 13, and absolute error = 0.01



%assignment1-1.1 bisection method
%compute f(x) = 0's each approximation of root, Iteration, each relative
%error

%input: initial guesses: a,b; 
%        tolerance:tol;
%		Function handle: fun


%output: ap_root: approximation of root matrix:
%       gap: Interval length: 
%       fx: each approximation of root function value: f(ap_root)
% 		count: number of iterations
%		error: relative of error


    function [ap_root,gap,fx,count,error]=AnswerOne_function(a,b,tol,fun)

    e=tol+1;    %set initial errorlative error
    count=-1;	%set initial number of iterations
    ap_root=[];	%ap_root vector store approximation of root
    gap=[];		%gap vector store interval length
    error=[];	%error vector store relative error
    fx=[];		%fx vector store function value
    while(e>tol)

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
    end



end