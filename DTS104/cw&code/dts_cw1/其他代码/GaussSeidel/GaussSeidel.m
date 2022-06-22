function[x,k]=GaussSeidel(A,b,x0,eps,M)
%高斯赛德尔迭代法求方程组的解（矩阵公式求解）
%A为方程组的系数矩阵；b为方程组的右端项
%x为线性方程组的解了；x0为迭代初值
%eps为误差限；M为迭代的最大次数
if nargin==3
    eps= 1.0e-6;%默认精度
    M = 10000;%参数不足时默认后两个条件
elseif nargin ==4
    M = 10000;%参数的默认值
elseif nargin<3
     error('参数不足');
     return
end
[n,m]=size(A);
nb=length(b);
%当方程组行与列的维数不相等时，停止计算，并输出出错信息
if n~=m
     error('矩阵A行数和列数必须相等!');
     return;
end
%当方程组与右端项的维数不匹配时，停止计算，并输出出错信息
if n~=nb
     error('矩阵A的行数必须和b的长度相等!');
     return;
end 
L =zeros(n,n);
U =zeros(n,n);
D =zeros(n,n);
for i=2:n
     for j=1:i-1
        L(i,j)=-A(i,j);
    end
end
for i=1:n-1
     for j=i+1:n
        U(i,j)=-A(i,j);
     end
end
for i=1:n
        D(i,i)=A(i,i);
end
B=inv(D-L)*U;%B为迭代矩阵
g=inv(D-L)*b;%g为右端项
pr=max(abs(eig(B))); %求迭代矩阵谱半径
if pr>=1
    error('迭代矩阵谱半径大于1迭代法不收敛');
     return;
end
k=0;
tol=1;
while tol>=eps 
     x = B*x0+g;
     k = k+1;%迭代步数
     tol = norm(x-x0);%前后两步迭代结果的误差
     x0 = x;
     if(k>=M)
            disp('Warning: 迭代次数太多，可能不收敛！');
        return;
        end
end
disp(k);


