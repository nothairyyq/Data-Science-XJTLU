function int_f = trapezoidal( f, a, b, m )
% input :   f : function handler
%           a : the lower limit of integral
%           b : the upper limit of integral
%           m : cut integral area into m peace
% output :  int_f : the answer of the integral
    h = (b - a) / m;
    int_f = 0;
    if m >= 2
        for i = 1 : m-1
           int_f = int_f + 2 * f(a + h * i); 
        end
    end
    int_f = int_f + f(a) + f(b);
    int_f = int_f * h / 2;
end

