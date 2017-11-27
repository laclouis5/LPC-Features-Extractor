function [ signal_windows, fs_new ] = f_windows( signal, fs, fech, winsize, noverlap, filtering)
% f_windows divides signal in windows : 2D matrix [data x time]
%    signal: speech 
%    fs : sampling frequency of speechi
%    fech : new sampling frequency, generally 8000Hz
%    winsize: length of a window in seconds
%    noverlap : length in seconds
%    filter : string yes or no : increases amplitude of high frequencies 

if nargin == 2
    fech = 8000;
    winsize = 0.03;
    noverlap = 0.015;
    filtering = 'yes';
end

if nargin == 3
    winsize = 0.03;
    noverlap =0.015;
    filtering = 'yes';
end

% N = length(signal);

winsize = floor(winsize*fech);
noverlap = floor(noverlap*fech);

signal_sub_sampled = resample(signal, fech, fs);
N = length(signal_sub_sampled);

if strcmp(filtering,  'yes')
    signal_filtered =filter( [1 -0.95], 1, signal_sub_sampled );
else
    signal_filtered =signal_sub_sampled;
end

index = 1:winsize-noverlap:N-winsize+1;
signal_windows = zeros(length(index), winsize);

j = 1;
for i = index
   signal_windows(j,:) = signal_filtered(i:i+winsize-1);%.* hamming_window;
   j = j + 1;
end
signal_windows = signal_windows';
fs_new = fech;

end

