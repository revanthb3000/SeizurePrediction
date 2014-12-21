function [frequencies, amplitudes] = getTopFourierFreqs(data, samplingFrequency, electrodeNumber)
    Fs = samplingFrequency;
    T = 1/Fs;
    L = size(data,2);
    t=(0:L-1)*T;
    
    x = data(electrodeNumber,:);
    NFFT = 2^nextpow2(L);
    Y = fft(x,NFFT)/L;
    
    frequencies = Fs/2*linspace(0,1,NFFT/2+1);
    amplitudes = 2*abs(Y(1:NFFT/2+1));
    
    %f is the array of frequencies. y is the amplitudes.
end