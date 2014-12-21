fileHandle = load('Dog_5/Dog_5_preictal_segment_0011.mat');
names = fieldnames(fileHandle);
Fs = fileHandle.(names{1}).sampling_frequency;
T = 1/Fs;
L = size(fileHandle.(names{1}).data,2);
t=(0:L-1)*T;
x=fileHandle.(names{1}).data(14,:);
NFFT = 2^nextpow2(L);
Y = fft(x,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
y = 2*abs(Y(1:NFFT/2+1));
figure;
plot(f,y) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
ylim([0 1.5])
