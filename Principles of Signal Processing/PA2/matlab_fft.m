function [res]=matlab_fft(x,y)
    n=length(x);
    m=length(y);
    x=[x,zeros(1,m-1)]; % zero padding to n+m-1
    y=[y,zeros(1,n-1)]; % zero padding to n+m-1
    fx=fft(x);
    fy=fft(y);
    fres=fx.*fy; % f[ x convolution y ] = fx .* fy
    res=ifft(fres);
end
