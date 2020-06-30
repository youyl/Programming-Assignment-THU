function [res]=overlap_save(x,y)
    if length(x)<length(y) % to make sure that y is shorter
        t=x;
        x=y;
        y=t;
    end
    n=length(x);
    m=length(y);
    blocksize=m+1;
    l=blocksize+m-1;
    fy=fft(y,l);
    blocknum=ceil(n/blocksize);
    x=[x,zeros(1,(blocknum+1)*blocksize-n)];
    res=zeros(1,(blocknum+1)*blocksize);
    overlap=zeros(1,m-1);
    for i=0:blocknum
        id=blocksize*i+1;
        xm=[overlap,x(id:id+blocksize-1)];
        overlap=xm(blocksize+1:blocksize+m-1);
        ym=ifft(fft(xm,l).*fy);
        res(id:id+blocksize-1)=ym(m:m+blocksize-1);
    end
    res=res(1:n+m-1);
end
