function [LPC] = f_LPC(path, f_ech, nb_coeff, thresh, time_window, time_step)

% signal
[speech, fs] = audioread(path);

% hamming window
len_window = f_ech * time_window / 1000;
len_step   = f_ech * time_step / 1000;

hamming_window = hamming(len_window);

% resampling at f_ech
speech_dw = resample(speech, f_ech, fs);

% Pre-emphasis
speech_f = filter([1, -0.95], 1, speech_dw);

% windowing signal according to len_window and len_step
sig_w = f_sig_windowed(speech_f, hamming_window, len_step);

% computing signal energy to remove blank speech

if isscalar(thresh)
    energy    = log(sum(sig_w.^2));
    e_logical = f_tresh_energy(energy, thresh);

else
    e_logical = true([1, size(sig_w, 2)]);
    
end

% LPC
LPC = lpc(sig_w(:, e_logical), nb_coeff)';
LPC = LPC(2:end);
end