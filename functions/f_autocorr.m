function [autocorr] = f_autocorr(path, f_ech, time_window, time_step)

% signal
[speech, fs] = audioread(path);

% hamming window
len_window = f_ech * time_window / 1000;
len_step   = f_ech * time_step / 1000;

% hamming_window = hamming(len_window);
rect_window = ones(len_window, 1);

% resampling at f_ech
speech_dw = resample(speech, f_ech, fs);

% Pre-emphasis
% speech_f = filter([1, -0.95], 1, speech_dw);

% windowing signal according to len_window and len_step
[sig_w, nb_sig] = f_sig_windowed(speech_dw, rect_window, len_step);

% 
for i = 1:nb_sig
   autocorr(:, i) = xcorr(sig_w(:, i), 'unbiased'); 
end
end