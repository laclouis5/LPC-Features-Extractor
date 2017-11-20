function [sig_thresh] = f_tresh_energy(energy, thresh)
% Computes the signal energy and return a logical array where ones
% represents parts of the speech that are above the threshold specified as
% an input (output is the same size as the input).

sig_thresh = zeros(1, length(energy));
sig_thresh(energy > thresh) = 1;
sig_thresh = logical(sig_thresh);
end

