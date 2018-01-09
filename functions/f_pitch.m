function [ pitch] = f_pitch( signal_window, fs )
%   f_pitch detects voiced sound by calculating autocorrelation. Result gives
%   a pitch value.
%   signal_window: speech divided in window: 2D matrix [data x time]
%   fs: the sampling frequency
%   pitch: the frequency which characterized voiced sound

pitch_windows = [];
L = size(signal_window, 1);
threshold = 0.4;
kmin   = floor(fs/400);
kmax   = floor(fs/80);
[b, a] = butter(10,2*1200/fs);

for i = 1: size(signal_window, 2)
    % low-pass filter to remove frequency greater than 1200Hz
    z = filter(b,a,signal_window(:,i));
    % empirical correlation
    den = sum(z.*z);
    for k=1:L
        rho(k) = sum(z(k:L-1).*z(1:L-k))/den;
    end
    
    % find the max value
    [maxcorr,indmaxcorr] = max(rho(kmin:kmax));
    indmaxcorr = indmaxcorr + kmin;
    
    % separate voiced and unvoiced sound
    if maxcorr > threshold
        pitch_windows = [pitch_windows, fs/indmaxcorr]; % A compl??ter
    end
end

pitch = mean(pitch_windows);

