function [res]=overlap_add(x,y)
    if length(x)<length(y) % to make sure that y is shorter
        t=x;
        x=y;
        y=t;
    end
    n=length(x); % n <= m
    m=length(y);
    blocksize=m+1;
    l=blocksize+m-1;
    fy=fft(y,l); % pre calculate F[y]
    blocknum=ceil(n/blocksize);
    x=[x,zeros(1,(blocknum+1)*blocksize-n)]; % zero padding
    res=zeros(1,(blocknum+1)*blocksize);
    overlap=zeros(1,m-1); % overlap-add
    for i=0:blocknum
        id=blocksize*i+1;
        ym=ifft(fft(x(id:id+blocksize-1),l).*fy);
        ym(1:m-1)=ym(1:m-1)+overlap(1:m-1);
        overlap(1:m-1)=ym(blocksize+1:l);
        res(id:id+blocksize-1)=ym(1:blocksize);
    end
    res=res(1:n+m-1);
end
