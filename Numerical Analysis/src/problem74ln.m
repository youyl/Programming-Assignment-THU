format long;
ss=0;
lb=1;%积分下界
ub=2;%积分上界
n=36;%选择步长
h=(ub-lb)/n;
for i=1:n%simpson积分
    x1=lb+h*(i-1);
    x3=lb+h*i;
    x2=(x1+x3)/2;
    f1=1/x1;%计算1/x
    f2=1/x2;
    f3=1/x3;
    ss=ss+(f1+f3+4*f2);
end
ss=ss*h/6
err=abs(ss-log(2))
ss=0;
n=33;
h=(ub-lb)/n;
for i=1:n%复合gauss积分
    x1=lb+h*(i-1)+h/2-h/(2*sqrt(3));
    x2=lb+h*(i-1)+h/2+h/(2*sqrt(3));
    f1=1/x1;%计算1/x
    f2=1/x2;
    ss=ss+(f1+f2);
end
ss=ss*h/2
err=abs(ss-log(2))
