function [ freq ] = fourierTransform( x )
%	Fs = 10000;                    % Sampling frequency
%	T = 1/Fs;                     % Sample time
	L = size(x,1);                     % Length of signal
%	t = (0:L-1)*T;                % Time vector
	% Sum of a 50 Hz sinusoid and a 120 Hz sinusoid
%	x = sin(2*pi*f2*t); 
	NFFT = 2^nextpow2(L); % Next power of 2 from length of y
	Y = fft(x,NFFT)/L;
	[i,freq]=max(abs(Y));
end
