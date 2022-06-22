function res=diagmost(A)
%
[m,n]=size(A);
A=abs(A);
diaLine=diag(A);
res=1;
for i=1 :m
if diaLine(i)<sum(A(i,:))-diaLine(i)
res=0;
break;
end
end