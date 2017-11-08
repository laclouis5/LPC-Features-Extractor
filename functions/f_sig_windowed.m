function [sig_out, nb_sig_out] = f_sig_windowed(sig_in, window, len_step) 

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

