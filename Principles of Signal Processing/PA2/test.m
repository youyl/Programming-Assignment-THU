x=rand([1,500000]); % variable length of y for test
ffttime=[];
addtime=[];
savetime=[];
for i=10000:1000:500000
    y=rand([1,i]);
    fprintf("length(x)=%d length(y)=%d\n",500000,i)
    tmp=clock;
    ans1=matlab_fft(x,y);
    time_fft=etime(clock,tmp);
    ffttime=[ffttime,time_fft];
    fprintf("fft time cost: %f\n",time_fft)
    tmp=clock;
    ans2=overlap_add(x,y);
    time_add=etime(clock,tmp);
    addtime=[addtime,time_add];
    fprintf("overlap-add time cost: %f\n",time_add)
    tmp=clock;
    ans3=overlap_save(x,y);
    time_save=etime(clock,tmp);
    savetime=[savetime,time_save];
    fprintf("overlap-save time cost: %f\n",time_save)
end
figure
hold on
plot(ffttime,'r')
plot(savetime,'g')
plot(addtime,'b')