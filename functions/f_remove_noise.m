function [ pos  ] = f_remove_noise( signal_window, alpha )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[N, M] = size(signal_window);
sigma2=var(signal_window(:,1));
epsilon = chi2inv(alpha, N);

energy_khi2 = ones(1,M);
pos = zeros(1,M);

for i=1:M
    energy_khi2(i)=(sum(signal_window(:,i).^2))/sigma2;
    if energy_khi2(i)>epsilon
        pos(i)=1;
    end
end
pos = logical(pos);

end

