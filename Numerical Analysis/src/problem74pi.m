format long;
ss=0;
lb=0;%�����½�
ub=1;%�����Ͻ�
n=36;%ѡ�񲽳�
h=(ub-lb)/n;
for i=1:n%simpson����
    x1=lb+h*(i-1);
    x3=lb+h*i;
    x2=(x1+x3)/2;
    f1=1/(x1*x1+1);%����1/(1+x^2)
    f2=1/(x2*x2+1);
    f3=1/(x3*x3+1);
    ss=ss+(f1+f3+4*f2);
end
ss=ss*h*4/6
err=abs(ss-pi)
ss=0;
n=33;
h=(ub-lb)/n;
for i=1:n%����gauss����
    x1=lb+h*(i-1)+h/2-h/(2*sqrt(3));
    x2=lb+h*(i-1)+h/2+h/(2*sqrt(3));
    f1=1/(1+x1*x1);%����1/(1+x^2)
    f2=1/(1+x2*x2);
    ss=ss+(f1+f2);
end
ss=ss*h*2
err=abs(ss-pi)
