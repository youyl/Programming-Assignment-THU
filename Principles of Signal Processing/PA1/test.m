fftcost=[];
goecost=[];
for i=0:9
    time=clock;
    res=fft_analysis(i);
    disp(res);
    for j=0:100
        res=fft_analysis(i); % do it 100 times to get large enough time
    end
    fftcost=[fftcost,etime(clock,time)];
end
for i=0:9
    time=clock;
    res=goertzel(i);
    disp(res);
    for j=0:100
        res=goertzel(i);
    end
    goecost=[goecost,etime(clock,time)];
end
hold on
plot(goecost,'g')
plot(fftcost,'r')