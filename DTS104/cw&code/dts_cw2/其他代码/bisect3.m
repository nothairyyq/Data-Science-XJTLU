
function [xvalue,gap,fx,count,re]=bisect(a,b,nmax,eps,fun)
% xvalue--自变量迭代值  gap--区间长度   fx--函数值   count--计数
% nma--所允许执行的最大次数，防止死循环  eps--允许的误差   fun--调用的函数名
err=eps+1;
count=0;%初始化计数值为0
xvalue=[];%xvalue向量存储变量x的值
gap=[];%gap向量存储误差值
re=[];%存储相对误差
fx=[];%fx向量存储函数值
while(err>eps&&count<nmax)
    %当误差err大于所给的误差长度或者计数小于允许运行次数时，执行算法
    
    count=count+1;%计数加1
    c=(a+b)/2;%计算中间值
    x=c;
    xvalue=[xvalue;x];%将自变量迭代值存入xvalue矩阵
    fc=feval(fun,x);%将自变量代入cal函数得到的函数值赋给fc
    fx=[fx;fc];%将fc函数值存入fx矩阵
    x=a;
    %判断根在哪个区域
    err=abs(a-(a+b)/2)/abs((a+b)/2);%误差长度
    if(fc*feval(fun,x)<0)
        b=c;
    else
        a=c;
    end
    dis=abs(a-b);
    gap=[gap;dis];
    re=[re;err];
end
disp('  次数        自变量             区间长           函数值         相对误差         ')
%输出相应数据
for i=1:count
    fprintf('%2d        %10.6f        %10.6f       %10.6f      %10.6f \n  ',i,xvalue(i),gap(i),fx(i),re(i))
end

