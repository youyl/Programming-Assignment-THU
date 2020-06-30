format long;
ss=single(0);%单精度总和
lastss=single(0);%记录上一次的改变
doubless=double(0);%双精度总和
res=0;
tic;
for i=1:3000000
    doubless=doubless+double(1/i);
    ss=ss+single(1/i);
    if ss==lastss%判断是否不改变
        res=i;
        break;
    end
    lastss=ss;
end
toc;%计时
ss
doubless
err=abs(ss-doubless)/doubless%输出相对误差
res