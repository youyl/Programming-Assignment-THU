format long;
ss=single(0);%�������ܺ�
lastss=single(0);%��¼��һ�εĸı�
doubless=double(0);%˫�����ܺ�
res=0;
tic;
for i=1:3000000
    doubless=doubless+double(1/i);
    ss=ss+single(1/i);
    if ss==lastss%�ж��Ƿ񲻸ı�
        res=i;
        break;
    end
    lastss=ss;
end
toc;%��ʱ
ss
doubless
err=abs(ss-doubless)/doubless%���������
res