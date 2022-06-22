function I = simpsons(f,a,b,n)
% This function computes the integral "I" via Simpson's rule in the interval [a,b] with n+1 equally spaced points

%  f= can be either an anonymous function (e.g. f=@(x) sin(x)) or a vector
%  containing equally spaced values of the function to be integrated
%  a= Initial point of interval
%  b= Last point of interval
%  n= # of sub-intervals (panels), must be integer
% 


if numel(f)>1 % If the input provided is a vector
    n=numel(f)-1; h=(b-a)/n;
    I= h/3*(f(1)+2*sum(f(3:2:end-2))+4*sum(f(2:2:end))+f(end));
else % If the input provided is an anonymous function
    h=(b-a)/n; xi=a:h:b;
    I= h/3*(f(xi(1))+2*sum(f(xi(3:2:end-2)))+4*sum(f(xi(2:2:end)))+f(xi(end)));
end
