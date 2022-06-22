%Find the derivative of a function

function h=df(x)
 
syms R          %Symbolized R
y=cal(R);       %Call the cal function
dy=diff(y);     %Finding the derivative of cal function
h=subs(dy,R,x); %Get the derivative of cal function to take the value of x
end