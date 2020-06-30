format long;
n=10;%这里可以改变
x=ones(n,1);
oldH=ones(n);
for i=1:n
    for j=1:n
        oldH(i,j)=1/(i+j-1);%计算H矩阵
    end
end
H=oldH;
b=oldH*x;
for i=1:n%cholesky分解
    for j=1:(i-1)
        H(i,i)=H(i,i)-H(i,j)*H(i,j);
    end
    H(i,i)=sqrt(H(i,i));
    for j=(i+1):n
        for k=1:(i-1)
            H(j,i)=H(j,i)-H(i,k)*H(j,k);
        end
        H(j,i)=H(j,i)/H(i,i);
    end
end
tx=zeros(n,1);
mx=zeros(n,1);
for i=1:n%第一次前代
    mx(i,1)=b(i,1);
    for j=1:(i-1)
        mx(i,1)=mx(i,1)-H(i,j)*mx(j,1);
    end
    mx(i,1)=mx(i,1)/H(i,i);
end
for i=n:-1:1%第二次回代
    tx(i,1)=mx(i,1);
    for j=n:-1:(i+1)
        tx(i,1)=tx(i,1)-H(j,i)*tx(j,1);
    end
    tx(i,1)=tx(i,1)/H(i,i);
end
dx=max(abs(tx-x));
r=max(abs(b-oldH*tx));
dx
r
diff=ones(n,1)/(1e7);%扰动
H=oldH;
b=oldH*x+diff;
for i=1:n%与上面的一样
    for j=1:(i-1)
        H(i,i)=H(i,i)-H(i,j)*H(i,j);
    end
    H(i,i)=sqrt(H(i,i));
    for j=(i+1):n
        for k=1:(i-1)
            H(j,i)=H(j,i)-H(i,k)*H(j,k);
        end
        H(j,i)=H(j,i)/H(i,i);
    end
end
tx=zeros(n,1);
mx=zeros(n,1);
for i=1:n
    mx(i,1)=b(i,1);
    for j=1:(i-1)
        mx(i,1)=mx(i,1)-H(i,j)*mx(j,1);
    end
    mx(i,1)=mx(i,1)/H(i,i);
end
for i=n:-1:1
    tx(i,1)=mx(i,1);
    for j=n:-1:(i+1)
        tx(i,1)=tx(i,1)-H(j,i)*tx(j,1);
    end
    tx(i,1)=tx(i,1)/H(i,i);
end
dx2=max(abs(tx-x));
r2=max(abs(b-oldH*tx));
dx2
r2
