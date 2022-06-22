%% erfenfa new use one
% Author:jfsufeng@foxmail.com
% Version:
% Date&Time:
% Description:

function [i,x,fx]=erfenfa_new_use1(f,bot,top,err)
%输入：f为要求解的方程函数表达式，bot为求解区间的下界，top为求解区间的上界，err为所要求的误差范围
%输出：i为二分法求解的次数，x为最终的根，fx为方程的根x对应的函数值（精度要求内接近于零或等于零）
if f(bot)*f(top)>0
    disp('\n注意：f(bot)*f(top)>0,无法继续运算，请重新调整区间端点bot和top.\n');
    return
end
%wucha=abs(top_new-bot_new)/2;  % put that into for loop || while loop
n=ceil((log(top-bot)- log(err))/log(2))-1; %n为二分法运算总的次数；ceil是上取整 ,相对应的floor是下取整
for i=0:1:n    % 步长默认为1，中间的1加不加都可以
    x=(bot+top)/2;
    fx=f(x);
    if fx==0
        bot=x; top=x;
    elseif f(bot)*fx<0
        top=x;
    else
        bot=x;
    end
%     if abs(top-bot)<=err  % 结合题意，加不加1/2都行，只是有着多二分运算一次的影响
%         %此外，实际这里的if判断err的语句part，针对for循环是无必要的
%         break  % 这里用break，不用return
%     end
end
fprintf('\nThe result:\n二分法运算次数i=%d;方程的根x=%.4f;f(x)=%.4f\n',i,x,fx);%保留4位小数


