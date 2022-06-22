
function x=Gauss_Seidel_fun(A,b,n,x0,tol,N)
x=zeros(n,1);  % 给x赋值
k=1;
while k<N
    for i=1:n
        if i==1
            x(1)=(b(1)-A(1,2:n)*x0(2:n))/A(1,1);
        elseif i==n
            x(n)=(b(n)-A(n,1:n-1)*x(1:n-1))/A(n,n);
        else
            x(i)=(b(i)-A(i,1:i-1)*x(1:i-1)-A(i,i+1:n)*x0(i+1:n))/A(i,i)       
        end  
    end
    if norm(x-x0)<tol
        break;
    end
    
    x0=x;
    k=k+1;
    
    disp(['when k=',num2str(k)])
    disp('x=');
    disp(x);                       %输出中间结果
end

if k==N
    disp('迭代次数已到达上限!');
end
disp(['迭代次数 k=',num2str(k)])

end

