function [F, f_axis] = f_fft(path, f_ech, time_window, time_step)
% downsample the signal tu f_ech, cut it into parts with a hamming window
% and compute the shifted fft of each part. Also return the axis in Hz.
% time_window and time_step are the hamming_window parameters in second.

len_window  = f_ech * time_window / 1000;

window = hamming(len_window);

[speech, fs] = audioread(path);
speech_dw    = resample(speech, f_ech, fs);

sig_out = f_sig_windowed(speech_dw, f_ech, window, time_step);

F = fftshift(fft(sig_out));
len = size(sig_out, 1);
f_axis = f_ech*(-1/2:1/len:1/2 - 1/len);
end
