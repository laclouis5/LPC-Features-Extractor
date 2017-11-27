function [mel_triangle, freq, freq_index] = f_triangle( nb_filters, f_min, f_max, fs, nfft )
% f_triangle return nb_filters mel triangular filters :
%  Adjust number of filters
%  Converts f_min and f_max on mel scale
%  Defines nb_filters between mel_min and mel_max
%  Convert last result into frequences
%  Defines the initial position of filters
%  Creates each triangular filters from their analytic function
%  Plot result
%  
%  nb_filters : number of filter bank channels
%  f_min & f_max :frequency range to consider
%  fs : sampling frequency
%  nfft : lenght of fft analysis

    nb_filters = nb_filters + 2; 
    mel_min=1127*log(1+(f_min/700));
    mel_max=1127*log(1+(f_max/700));
    mel = linspace(mel_min,mel_max,nb_filters); 

    freq=700*((exp(mel/1127))-1); 
    freq_index = floor((nfft+1)*freq/fs);

    mel_triangle = zeros(nb_filters-2, nfft/2+1);
    for i =2:nb_filters-1
        for j = 1:nfft/2+1
            if j>=freq_index(i-1)&&j<freq_index(i)
                mel_triangle(i-1, j+1) = (j-freq_index(i-1))/(freq_index(i)-freq_index(i-1));
            elseif j>=freq_index(i)&&j<freq_index(i+1)
               mel_triangle(i-1, j+1) = (freq_index(i+1)-j)/(freq_index(1+i)-freq_index(i));
            end
        end
    end
    
    
    % test
%     for m = 1:nb_filters
% 
%         k = f>=freq_index(m)&f<=freq_index(m+1); % up-slope
%         H(m,k) = (f(k)-freq_index(m))/(freq_index(m+1)-freq_index(m));
%         k = f>=freq_index(m+1)&f<=freq_index(m+2); % down-slope
%         H(m,k) = (freq_index(m+2)-f(k))/(freq_index(m+2)-freq_index(m+1));
%        
%    end

% figure, plot(0:nfft/2, mel_triangle(:,:), 'LineWidth', 2),
    
end

