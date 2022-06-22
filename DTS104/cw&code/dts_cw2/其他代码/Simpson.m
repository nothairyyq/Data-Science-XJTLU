function res = Simpson(f,a,b)
    format long;
    if b < a
        c = b;
        b = a;
        a = c;
    end
    res = (b-a)/6 * (f(a) + 4*f((a+b)/2) + f(b));
end

