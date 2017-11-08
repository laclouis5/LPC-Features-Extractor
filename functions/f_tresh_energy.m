function [sig_thresh] = f_tresh_energy(energy, thresh)

sig_thresh = zeros(1, length(energy));
sig_thresh(energy > thresh) = 1;
sig_thresh = logical(sig_thresh);
end

