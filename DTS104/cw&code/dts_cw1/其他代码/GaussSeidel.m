 function [X_reality,n_reality ] = GaussSeidel( A,b,X_start,n_limit,tolerance)

%%
% A为迭代的系数矩阵
% b为方程组右边的常数项（列向量）
% X_start为迭代的初始向量
% n_limit为最大允许迭代的次数
% tolerance为精度上限值
%%
% X_reality为最后结果
% n_reality为最后迭代次数
%%
fprintf('\n高斯-赛德尔迭代法求解线性方程组\n');
[m,n] = size(A); % A的行数和列数均为n
D_L = tril(A); % A的下三角矩阵
B = inv(D_L) * (D_L - A); % B为高斯-赛德尔迭代矩阵，也就是化简后的便于迭代的等价方程组的系数矩阵
f = inv(D_L) * b; % f为化简后的便于迭代的等价方程组的常数项向量
n_reality = 0;

%Check whether the coefficient matrix is a square matrix
if m ~= n
	error('A is not a square matrix');
end

%Check the coefficient matrix is diagonally dominant
check = abs(A);
diaLine = diag(check);
res=1;
for i = 1:m
	if diaLine(i)<sum(check(i,:))-diaLine(i)
		res = 0;
	else 
		res = 1;
	end
end


%%
while 1
if(n_reality > n_limit)
disp('迭代次数超界');
break;
end
X_reality = B * X_start + f; % 高斯-赛德尔迭代公式
n_reality = n_reality + 1; % 实际迭代次数
if(norm(X_reality - X_start) <= tolerance) % 如果满足条件||X(k+1) - X(k)||的2范数小于等于tolerance
break; % 则退出函数
else
X_start = X_reality; % 循环迭代
end
end
disp(n_reality);
 end

%%