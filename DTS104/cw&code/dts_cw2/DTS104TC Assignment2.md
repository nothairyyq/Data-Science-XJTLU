# DTS104TC Assignment2

[TOC]

##	Q1

### a) 

The three root finding methods of Bisection Method,Secant Method and Newton-Raphson are compared respectively, based on the number of iterations, iterative speed and the number of guessed values.

First of all, based on the following Bisection Method, Newton-Raphson and Secant Method matlab programs are used to iterate the equations in the problem.

Bisection Method and Secant Method require two guess values, which are set to 0 and 2 by the author, and the iteration stop error is set to 0.00001. The Newton-Raphson method requires a guess value, which is set to 2 by the author, and the iterative stop error is also 0.00001.

### Bisection Method

```matlab
f = @(x) (-3)*x^5+2*x^4-x^3+4;
bisect(0,2,50,0.00001,f);
```

The following is result:
```matlab
  Iteration        Approximation of root             length of interval             f(root)               relative error         
   1                    1.000000                         1.000000                   2.000000                  1.000000 
   2                    1.500000                         0.500000                 -12.031250                  0.333333 
   3                    1.250000                         0.250000                  -2.225586                  0.200000 
   4                    1.125000                         0.125000                   0.373688                  0.111111 
   5                    1.187500                         0.062500                  -0.781655                  0.052632 
   6                    1.156250                         0.031250                  -0.170961                  0.027027 
   7                    1.140625                         0.015625                   0.109257                  0.013699 
   8                    1.148438                         0.007813                  -0.028834                  0.006803 
   9                    1.144531                         0.003906                   0.040710                  0.003413 
  10                    1.146484                         0.001953                   0.006063                  0.001704 
  11                    1.147461                         0.000977                  -0.011354                  0.000851 
  12                    1.146973                         0.000488                  -0.002638                  0.000426 
  13                    1.146729                         0.000244                   0.001715                  0.000213 
  14                    1.146851                         0.000122                  -0.000461                  0.000106 
  15                    1.146790                         0.000061                   0.000627                  0.000053 
  16                    1.146820                         0.000031                   0.000083                  0.000027 
  17                    1.146835                         0.000015                  -0.000189                  0.000013 
  18                    1.146828                         0.000008                  -0.000053                  0.000007 
```

 In bisection method, we use Epsilon-a instead of relative error. For more information, you can see the following matlab source code

### Netwon-Raphson Method

```matlab
Newton(2, 0.00001, @cal,1.1468247)
```

The following is result:

```matlab
  Iteration        Approximation of root             f(root)               relative error         
   1                    1.638298                  -21.396010                  0.428551 
   2                    1.373933                   -6.154349                  0.198032 
   3                    1.213519                   -1.344827                  0.058155 
   4                    1.154147                   -0.132299                  0.006385 
   5                    1.146922                   -0.001742                  0.000085 
   6                    1.146825                   -0.000000                  0.000000 
```

In Netwon method, the writter need true value(1.1468247) to compute relative error(Epsilon-t).

### Secant Method

At the beginning, we gave the initial value of this method to cause the number of iterations of this method to be too many, which is not more than shown here. We reset the initial value to 0.5. The stop error is 0.05. The result is:

```matlab
secant(0.5, 2, 0.05,@cal, 1.146824)
```

```matlab
 Iteration        Approximation of root             f(root)               relative error         
   1                    0.581486                    3.832600                  0.492959 
   2                    0.657171                    3.721499                  0.426965 
   3                    3.192334                 -815.453692                  1.783631 
   4                    0.668688                    3.699788                  0.416922 
   5                    0.680086                    3.676836                  0.406983 
   6                    2.506060                 -229.390217                  1.185217 
   7                    0.708892                    3.611771                  0.381865 
   8                    0.736750                    3.538144                  0.357573 
   9                    2.075468                  -83.361634                  0.809752 
  10                    0.791257                    3.358093                  0.310045 
  11                    0.840986                    3.143618                  0.266683 
  12                    1.569879                  -16.326928                  0.368892 
  13                    0.958669                    2.379022                  0.164066 
  14                    1.036403                    1.607012                  0.096284 
  15                    1.198213                   -1.007273                  0.044809 
```

### Conclusion
According to the above data and the number of iterations, the relative error, the conclusion is drawn by the analysis of the results：

Because the scale of the problem of Secant method is much smaller, there are some errors. The convergence speed of Newton-Raphson is the fastest, the convergence speed of Bisection method is the second, and the convergence speed of Secant method is the slowest. Second, both the Secant and Bisection methods need to give two guesses, but Newton only needs one. So this report chooses the Newton-Raphson method to solve the problem.

### 2）

#### Calculations

This report will use its own matlab program to calculate the iterative results of the equation, the source code is as follows, will use three functions.

Newton-Raphson

```matlab
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
```

```matlab
%Find the derivative of a function

function h=df(x)
 
syms R          %Symbolized R
y=cal(R);       %Call the cal function
dy=diff(y);     %Finding the derivative of cal function
h=subs(dy,R,x); %Get the derivative of cal function to take the value of x
end
```

```matlab
function f=cal(x)
f=(-3)*x^5+2*x^4-x^3+4;
end
```

In this program, the correct result with high accuracy will be calculated by using this function in advance, that is, 1.146825. The correct result will be used to calculate the relative error. This program uses Epsilon-t to represent the relative error.

```matlab
Newton(1.2, 0.05, @cal, 1.146825)
```

```matlab
Iteration        Approximation of root             f(root)               relative error         
 1                    1.151585                   -0.085607                  0.004151 
```

#### Table

| Iteration | Approximation of root | Relative Error |
| --------- | --------------------- | -------------- |
| 1         | 1.1516                | 0.42%          |

### Other matlab source code and table

#### Bisection Method

```matlab
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
	
	e=abs(a-(a+b)/2)/abs((a+b)/2);	%compute relative error
	
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
```

#### Table

| Iteration | Approximation of Root | Relative Error |
| --------- | --------------------- | -------------- |
| 1         | 1.2500                | 60.00%         |
| 2         | 0.8750                | 42.86%         |
| 3         | 1.0625                | 17.65%         |
| 4         | 1.1563                | 8.11%          |
| 5         | 1.1094                | 0.04%          |






#### Secant Method

```matlab
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
```

## Q2
### a) Analytically

$\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx$ is a polynomial function whose highest term is 5, so this report only needs to perform symbolic operations on it to get accurate integration results:

Suppose the polynomial function is $f(x)$ and its original function is $F(x)$,  that is ${F(x)}'=f(x)$

$f(x)=\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx$

$F(x) = x-\frac{1}{2}x^2+\frac{2}{3}x^3-x^4+\frac{1}{3}x^6$

$F(4) = 1148 $, $F(-2) = -4$;

Hence, $\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx = F(4)-F(-2) = 1152$ 

Here are the results of validation using matlab

```matlab
f=@(x) (1-x+2*x.^2-4*x.^3+2*x.^5);
integral(f,-2,4)
```

The result is exactly the same as that of the matlab function.

### b) Trapezoidal Rule

Ues signle trapezoidal rule approximation

$\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx$.     $f(x)=\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx$

Trapezoidal rule estimation:

$\int_{-2}^{4} f(x)dx \approx \frac{4-(-2)}{2}\cdot \left( f(4)+f(-2) \right ) = 5400 $.   

The error of the trapezoidal rule is:

$E_t = E_t = -\frac{1}{12}{f}''(\xi)\cdot (4-(-2))^{3} $，$\xi \in [-2,4]$

Due to, ${f}''(x) = 4-24x+40x^3$, $and$,$ {f}''(x) \in [-268,2468]$

The error range calculated by the trapezoid rule error formula is:

$E_t \in [-44424,4824] $

Because at present, the author has obtained the estimated value of the trapezoidal rule and the real value of the integral of this function, which can be obtained by using relative error's formula.

$ \varepsilon _{t} = \frac{true`error}{true`value}\times 100\% $% $= \frac{5400-1152}{1152} \times 100\% $  $\approx 368.75\%$

### c) Trapezoidal Rule(n=2)

For the compound trapezoid rule on interval $[-2,4]$, two segments mean $h=\frac{(b-a)}{2}=3$

Multiple-application of the trapezoidal rule(n=2) estimation:

$x_{0}=-2, x_{1} = 1, x_{2} = 4$

$\int_{-2}^{4} f(x)dx \approx \frac{h}{2}\cdot \left( f(4)+f(-2)+2·f(1) \right ) \approx 2700 $. 

Relative error:
$ \varepsilon _{t} = \frac{true`error}{true`value}\times 100\% $% $= \frac{2700-1152}{1152} \times 100\% $  $\approx 134.38 \% $

### c) Trapezoidal Rule(n=4)

For the compound trapezoid rule on interval $[-2,4]$, two segments mean $h=\frac{(b-a)}{4}=3/2$

Multiple-application of the trapezoidal rule(n=4) estimation:

$x_{0}=-2, x_{1}=-\frac{1}{2},x_{2}=1,x_{3}=\frac{5}{2}, x_{4} = 4$

$\int_{-2}^{4} f(x)dx \approx \frac{h}{2}\cdot \left( f(4)+f(-2)+2·(f(1)+f(-\frac{1}{2})+f(\frac{5}{2}) \right ) \approx 1569.38 $. 

Relative error:
$ \varepsilon _{t} = \frac{true`error}{true`value}\times 100\%  = \frac{1569.38-1152}{1152} \times 100\%  \approx 36.23 \% $


### d) Simpson's 3/8 Rule

$h=\frac{(b-a)}{2}=3$

$I = \int_{-2}^{4} f(x)dx \cong \frac{h}{3}[f(x_0)+4f(x_1)+f(x_2)]$

$x_0 = -2, x_1 = 1, x_2 = 4$

$f(x)=\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx$

Hence, $I \cong 1800$

Relative error:

$ \varepsilon _{t} = \frac{true`error}{true`value}\times 100\%  = \frac{1800-1152}{1152} \times 100\%   \approx 56.25 \% $

### d) Simpson's 1/3 Rule

$h=\frac{(b-a)}{3}=2$

$I = \int_{-2}^{4} f(x)dx \cong \frac{3h}{8}[f(x_0)+3[f(x_1)+f(x_2)]+f(x_3)]$

$x_0 = -2, x_1 = 0, x_2 = 2, x_3=4$

$f(x)=\int_{-2}^{4} (1-x+2x^2-4x^3+2x^5)dx$

Hence, $I \cong1440 $

Relative error:

$ \varepsilon _{t} = \frac{true`error}{true`value}\times 100\%  = \frac{1440-1152}{1152} \times 100\%   \approx 25.00 \% $

