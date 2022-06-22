%-------------------------------------------------------
% Runs the Jacobi method for A*x = b.
%
% ON ENTRY :
%   A        n-by-n matrix
%   b        n-dimensional vector
%   epsilon  accuracy requirement
%   maxit    maximal number of iterations
%   x        start vector for the iteration
%
% ON RETURN :
%   x        approximate solution to A*x = b.
%-------------------------------------------------------
function x = Jacobi(A, b, epsilon, maxit, x)

% check if the entered matrix is a square matrix
[na, ma] = size(A);
if na ~= ma
    disp('ERROR: Matrix A must be a square matrix')
    return
end

% check if b is a column matrix
[nb, mb] = size (b);
if nb ~= na || mb~=1
   disp( 'ERROR: Matrix b must be a column matrix')
   return
end

dx = zeros(na,1);
for k=1:maxit
    sum = 0;
    for i=1:na
        dx(i) = b(i);
        for j=1:na
            dx(i) = dx(i) - A(i,j)*x(j); 
        end
        dx(i) = dx(i)/A(i,i);
        x(i) = x(i) + dx(i);
        if (dx(i) >= 0)
            sum = sum + dx(i);
        else 
            sum = sum - dx(i);
        end
    end
    if(sum <= epsilon)
        break
    end
end
fprintf('The final answer obtained after %g iterations is  \n', k);

