function [res]=goertzel(idx) % use goertzel to find the key pressed
    filename=['wav/dtmf-',num2str(idx),'.wav']; % input file name
    [audio,fs]=audioread(filename);
    keys=['1','2','3','a';'4','5','6','b';'7','8','9','c';'*','0','#','d'];
    f=[697,770,852,941,1209,1336,1477,1633]; % dtmf frequencies
    n=length(audio);
    f=f*n/fs; % calculate the corresponding frequency
    tmp=zeros(1,8);
    p=zeros(1,8);
    for i=1:8
        fir=2*cos(2*pi*f(i)/n);
        for j=3:n-3
            tmp(j)=fir.*tmp(j-1)-tmp(j-2)+audio(j); % goertzel
        end
        p(i)=tmp(n-3).^2+tmp(n-4).^2-fir*tmp(n-3)*tmp(n-4);
    end
    p=abs(p);
    row=find(p(1:4)==max(p(1:4))); % find the most possible one
    col=find(p(5:8)==max(p(5:8)));
    res=keys(row,col);
end
