function AnswerThree
%This is question1 main function
A=[2 8 10;8 3 5;10 5 9]; %Needed solved matrix
u= [1;1;1]; %  initial eigenvector
it=4;%iteration numbers;
[l,~]=AnswerThree_Function(A,u,it);
 
%Check power method answer and eig()function eigenvalue;
c=eig(A);   %eig function obtain a column eigenvalue vector
l=roundn(l,-4); %keep 4 decimal places
c=roundn(max(c),-4);    %keep 4 decimal places
 
if l==c
    fprintf('\n power method obtain eigenvalue equal to using eig() function obtained');
else
   fprintf('\n power method obtain eigenvalue do not equal to using eig() function obtained');
end
        %Power method iteration function
        %Calculate the dominant(highest) eigenvalues
        %and corresponding eigenvectors of each iteration
        %Input:A: Matrix A
        %         x: Initial(non-zero) vector
        %         k: Iteration numbers
        %Output: lam: the dominant(highest) eignvalues
        %            u: corresponding eigenvectors
        %Other variables:u_norm: normalized Eigenvectors
        function [lam,u]=AnswerThree_Function(A,x,k)
        for j = 1:k
            u=x/norm(x); %vector normalization
            x=A*u;          %Power Steps
            lam=u'*x;       %Rayleigh Quotient
            %Raleigh Quotient is optimal approximation of eigenvalues
            fprintf('\n\nThe iteration %d:',j);
            fprintf('\nThe Estimated Eigenvalue(dominant/highest) is %5.4f\n',lam);
            disp('The corresponding Estimated Eigenvector(normalized) is:');
            u_norm = x/norm(x); %normalized eigenvectors
            fprintf('\n%5.4f',u_norm);
        end
        end
end


