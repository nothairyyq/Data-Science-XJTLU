function AnswerFive
 
%Question5 (a)
f=@(x)exp((-0.5)*x^2);
Gaussian_3(f,1,4);
Gaussian_4(f,1,4);
Gaussian_5(f,1,4);
 
%Question5(b)
CompareGT(f,1,4,0.397610357,0.397613249);
%Gaussian_3/4/5 are almost same
%input:f:given function
%      lower:Lower limit of integral
%      upper:upper limit of integral
%      Final output is calculate the approximate solution of equation f
%      using Gaussian Quadrature Method
    function Gaussian_3(f,lower,upper)
        
        c=[0.5555556 0.8888889 0.5555556];%weighting factors
        x=[-0.774596669 0.0 0.774596669];%Funtion Arguments
        I=0;
        a=lower;
        b=upper;
        z=[];
        
        %using Gaussian Quadrature calculate given function
        for i = 1:3
           zo=(b-a)/(2.0)*x(i)+(a+b)/(2.0);
           z=[z;zo];
        end
        
        for i = 1:3
            I=I+(b-a)/(2.0)*c(i)*f(z(i));
        end
        %Formatted output to retain nine decimal places
        fprintf('using Gaussian Quadrature Method with n=3 result is:%5.9f',I);
        fprintf('\n');
    end
 
    function Gaussian_4(f,lower,upper)
        c=[0.3478548 0.6521452 0.6521452 0.3478548];
        x=[-0.861136312 -0.339981044 0.339981044 0.861136312];
        I=0;
        a=lower;
        b=upper;
        co=[];
        
        for i = 1:4
           zo=(b-a)/(2.0)*x(i)+(a+b)/(2.0);
           co=[co;zo];
        end
        
        for i = 1:4
            I=I+(b-a)/(2.0)*c(i)*f(co(i));
        end
        fprintf('using Gaussian Quadrature Method with n=4 result is:%5.9f',I);
        fprintf('\n');
    end
    
    function Gaussian_5(f,lower,upper)
        c=[0.2369269 0.4786287 0.5688889 0.4786287 0.2369269];
        x=[-0.906179846 -0.538469310 0.0 0.538469310 0.906179846];
        I=0;
        a=lower;
        b=upper;
        co=[];
        
        for i = 1:5
           zo=(b-a)/(2.0)*x(i)+(a+b)/(2.0);
           co=[co;zo];
        end
        
        for i = 1:5
            I=I+(b-a)/(2.0)*c(i)*f(co(i));
        end
        fprintf('Using Gaussian Quadrature Method with n=5 result is:%5.9f',I);
        fprintf('\n');
    end
 
    %Question5 b function compare Gaussian Quadrature(N=5) and Trapezoidal rule
%input:f:given function
%      lower:Lower limit of integral
%      upper:upper limit of integral
%      trueval:Given equation actual integral
%      Final output is the number of iteration of compare
%      Trapezoidal rule better than Gaussian Quadrature(n=5)
    function CompareGT(f,lower,upper,trueval,Gval)
 
        Gerror=abs(Gval-trueval);       %Trapezoidal rule accuracy
        n=1;
        Terror=1;
    
        
        while(Terror>=Gerror)
            h=(upper-lower)/n;
            x=lower;
            y=f(x);
            
            for i = 1 : n-1
                x=x+h;         %Trapezoidal rule iteration
                y=y+2*f(x);
            end
            y=y+f(upper);
            I=(upper-lower)*y/(2*n);
            Terror=abs(I-trueval);
            n=n+1;
        end
        fprintf('The actual integral is %5.9f, require %d by the Trapezoidal rule to attain better than using Gaussian Quadrature(n=5)', trueval,n-1);
    end
 
 
end    




