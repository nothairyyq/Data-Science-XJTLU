function x1 = newton2(t1,esp,m)
syms x;
fun = (-3)*x^5+2*x^4-x^3+4;

for k = 1:m
    if abs(subs(diff(fun,'x'),x,t1))<esp
        x1 = t1;
        break;
    else
        if subs(diff(fun,'x',2),x,t1)==0
            break;
        else
            t0 = t1;
            t1 = t0- subs(fun,x,t0)/subs(diff(fun,'x'),x,t0);
            if abs(t1-t0)<esp
                x1 = t1;
                break;
                
            end
        end
    end
end
x1 = vpa(x1,8);