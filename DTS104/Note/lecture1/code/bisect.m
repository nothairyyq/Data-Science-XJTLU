% 二分法：计算f(x) = 0的近似解
% 输入：函数句柄f;a,b使得f(a)*f(b)<0
%       容差tol
%输出：近似解xc,误差范围为tol

function [xc,t] = bisect(f,a,b,tol)
fa = f(a);
fb = f(b);
t1 = 0;
while (b-a)/2 > tol
    c = (a+b)/2;
    fc = f(c);
    if fc == 0
        break
    end
    if sign(fc)*sign(fa) < 0
        b = c; fb = fc;
    else
        a = c; fa = fc;
    end
    t1 = t1+1;
end
xc = (a+b) / 2;
t=t1;




