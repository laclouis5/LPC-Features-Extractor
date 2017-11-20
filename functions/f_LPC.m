function [LPC] = f_LPC(path, f_ech, nb_coeff, thresh, time_window, time_step)
% This function divides the input signal into many windowed parts with a
% hamming window parametrized with time_window and time_step that are the
% length of the window and the step between each window in second. Then,
% LPC coefficents are computed for each window according to the nb_coeff
% parameter. Thresh is an optional input that allow threshold on the signal
% energy to get rid of blank in the speech.

% signal
[speech, fs] = audioread(path);

% hamming window
len_window     = f_ech * time_window / 1000;
hamming_window = hamming(len_window);

% resampling at f_ech
speech_dw = resample(speech, f_ech, fs);

% Pre-emphasis
speech_f = filter([1, -0.95], 1, speech_dw);

% windowing signal according to len_window and len_step
sig_w = f_sig_windowed(speech_f, f_ech, hamming_window, time_step);

% computing signal energy to remove blank speech

if isscalar(thresh)
    energy    = log(sum(sig_w.^2));
    e_logical = f_tresh_energy(energy, thresh);

else
    e_logical = true([1, size(sig_w, 2)]);    
end

% LPC
LPC = lpc(sig_w(:, e_logical), nb_coeff)';
LPC = LPC(2:end, :);
end