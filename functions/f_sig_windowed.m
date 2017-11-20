function [sig_out, nb_sig_out] = f_sig_windowed(sig_in, f_ech, window, time_step) 
% return windowed signal according to the window put as input and the
% time_step parameter. time_step is the step (in second) between each
% window.

len_step   = f_ech * time_step / 1000;
len_sig    = length(sig_in);
len_window = length(window);
nb_sig_out = floor((len_sig - len_window) / len_step);
sig_out    = zeros(len_window, nb_sig_out);

for i = 1:nb_sig_out

    pos1 = (i - 1) * len_step + 1;
    pos2 = pos1 + len_window - 1;
    
    sig = sig_in(pos1:pos2);
    sig_out(:, i) = sig .* window;
end
end