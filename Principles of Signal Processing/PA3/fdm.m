[audio1,fs]=audioread('wav/1.wav'); % read audio from file
[audio2,fs]=audioread('wav/2.wav');
[audio3,fs]=audioread('wav/3.wav');
fs
duration=length(audio1) % show the freq and duration of audio
t=0:duration-1;
f1=fft(audio1); % calculate the frequency spectrum
f2=fft(audio2);
f3=fft(audio3);
figure(1); % plot the frequency spectrum
subplot(311);
stem(t,abs(f1),'.');
subplot(312);
stem(t,abs(f2),'.');
subplot(313);
stem(t,abs(f3),'.');
figure(2); % plot the original audio
subplot(311);
stem(t,audio1,'.');
subplot(312);
stem(t,audio2,'.');
subplot(313);
stem(t,audio3,'.');
f=zeros(1,duration); % distribute the spectrum into different ranges
f(1:50000)=f1(1:50000);
f(450001:500000)=f1(450001:500000);
f(50001:100000)=f2(1:50000);
f(400001:450000)=f2(450001:500000);
f(100001:150000)=f3(1:50000);
f(350001:400000)=f3(450001:500000);
res=ifft(f); % get the fused audio
figure(3); % plot the spectrum and audio
subplot(211);
stem(t,abs(f),'.');
subplot(212);
stem(t,real(res),'.');
soundsc(real(res),fs); % play the fused audio
pause(duration/fs);
f=fft(res); % get the spectrum back
f1=zeros(1,duration);
f2=zeros(1,duration);
f3=zeros(1,duration);
f1(1:50000);f(1:50000); % make out the three audios' spectrum
f1(450001:500000)=f(450001:500000);
f2(1:50000)=f(50001:100000);
f2(450001:500000)=f(400001:450000);
f3(1:50000)=f(100001:150000);
f3(450001:500000)=f(350001:400000);
audio1=real(ifft(f1)); % get the three audio
audio2=real(ifft(f2));
audio3=real(ifft(f3));
soundsc(audio1,fs); % play the three audio
pause(duration/fs);
soundsc(audio2,fs);
pause(duration/fs);
soundsc(audio3,fs);
figure(4); % plot the spectrum
subplot(311);
stem(t,abs(f1),'.');
subplot(312);
stem(t,abs(f2),'.');
subplot(313);
stem(t,abs(f3),'.');
figure(5); % plot the audio
subplot(311);
stem(t,audio1,'.');
subplot(312);
stem(t,audio2,'.');
subplot(313);
stem(t,audio3,'.');
