x=[0.520,3.1,8.0,17.95,28.65,39.62,50.65,78,104.6,156.6,208.6,260.7,312.5,364.4,416.3,468,494,507,520];
y=[5.288,9.4,13.84,20.20,24.90,28.44,31.10,35,36.9,36.6,34.6,31,26.34,20.9,14.8,7.8,3.7,1.5,0.2];
y0p=1.86548;
ynp=-0.046115;
xp=[2,30,130,350,515];
yvalid=[y0p y ynp];
resvalid=spline(x,yvalid,xp);%用官方函数计算用于验证的点值
h=zeros(1,18);
for i=1:18
    h(i)=x(i+1)-x(i);
end
miu=zeros(1,17);
lbd=zeros(1,17);
d=zeros(1,17);
for i=1:17
    miu(i)=h(i)/(h(i)+h(i+1));
    lbd(i)=h(i+1)/(h(i)+h(i+1));
    d(i)=6*(y(i)/(h(i)*(h(i)+h(i+1)))+y(i+2)/(h(i+1)*(h(i)+h(i+1)))-y(i+1)/(h(i)*h(i+1)));
end
miu=[miu 1];
lbd=[1 lbd];
d0=6*((y(2)-y(1))/h(1)-y0p)/h(1);
dn=6*(ynp-(y(19)-y(18))/h(18))/h(18);
A=zeros(19);%整理矩阵
for i=1:19
    A(i,i)=2;
end
for i=1:18
    A(i,i+1)=lbd(i);
    A(i+1,i)=miu(i);
end
d=[d0 d dn];
res=A\transpose(d);%解方程
ans=zeros(1,5);%点值
ansp=zeros(1,5);%一阶导数
anspp=zeros(1,5);%二阶导数
for i=1:5
    for j=1:18
        if x(j)<xp(i) & x(j+1)>xp(i)
            ans(i)=res(j)*(x(j+1)-xp(i))^3/(6*h(j))+res(j+1)*(xp(i)-x(j))^3/(6*h(j))+(y(j)-res(j)*h(j)*h(j)/6)*(x(j+1)-xp(i))/h(j)+(y(j+1)-res(j+1)*h(j)*h(j)/6)*(xp(i)-x(j))/h(j);
            ansp(i)=-res(j)*(x(j+1)-xp(i))^2/(2*h(j))+res(j+1)*(xp(i)-x(j))^2/(2*h(j))+(y(j+1)-y(j))/h(j)-(res(j+1)-res(j))*h(j)/6;
            anspp(i)=res(j)*(x(j+1)-xp(i))/h(j)+res(j+1)*(xp(i)-x(j))/h(j);
            break;
        end
    end
end
resvalid
ans %此处可以对比计算值和用于验证的正确值
ansp
anspp