function [res]=fft_analysis(idx) % use fft to find the key pressed
    filename=['wav/dtmf-',num2str(idx),'.wav']; % input file name
    [audio,fs]=audioread(filename);
    keys=['1','2','3','a';'4','5','6','b';'7','8','9','c';'*','0','#','d'];
    f=[697,770,852,941,1209,1336,1477,1633]; % dtmf frequencies
    fx=abs(fft(audio,fs));
    row=find(fx(650:1000)==max(fx(650:1000)))+649; % find the first peak
    col=find(fx(1150:1500)==max(fx(1150:1500)))+1149; % find the second peak
    difrow=abs(f-row); % use the difference to find the correct one
    difcol=abs(f-col);
    row=find(difrow==min(difrow));
    col=find(difcol==min(difcol))-4;
    res=keys(row,col);
end
