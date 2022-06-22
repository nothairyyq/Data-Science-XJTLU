function AnswerTwo
        function [X_reality,n_reality ] = AnswerTwo_Function( A,b,X_start,n_limit,tol)

        %%The function input variables:
        % A is the iterative coefficient matrix.
        % b is the constant term on the right side of the equation group (column vector)
        % X_start is the initial vector of iteration
        % n_limit is the maximum number of iterations allowed
        % tol is the limit of tolerance.
        %%The function output variables:
        % X_reality is function running result
        % n_reality is final iteration numbers


        [m,n] = size(A); % A's row number = m，column number = n
        D_L = tril(A); % The lower triangular matrix of A is obtained.
        B = inv(D_L) * (D_L - A); % B is the Gauss-Seidel iterative matrix
                                  % the coefficient matrix of the simplified equivalent system of equations
                                  % which is convenient for iteration.
        f = inv(D_L) * b; % f is the constant vector of the simplified
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
                disp('The coefficient matrix is not diagonally dominant')
            break;
            end
        end

        disp('The coefficient matrix A is diagonally dominant')

        while 1
        if(n_reality > n_limit)
        disp('The number of iterations exceeds the given maximum number of times');
        break;
        end
        X_reality = B * X_start + f; % Gauss-Seidel iteration formula
        n_reality = n_reality + 1; % Actual number of iterations
        if(norm(X_reality - X_start) <= tol) % if meet||X(k+1) - X(k)|| 2 norm <= tol
        break; % exit the function
        else
        X_start = X_reality; % iteration
        end
        end
        disp('The number of Gauss Seidel iterations is:');
        disp(n_reality);
        disp('The iteration x value is:');
        disp(X_reality);
        end

end
