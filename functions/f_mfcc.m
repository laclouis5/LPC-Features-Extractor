function [ coeff_mfcc ] = f_mfcc( speech_windows, mel_triangle, N, L )
%f_mfcc Calculates mfcc :
%   calculates speech fft
%   multiply speech by mel triangles
%   takes log of abs of result
%   mfcc coef correspond to dct of last result
%
%   N : Number of cepstral coefficients
%   L : cepstral sine lifter parameter

    M = size(mel_triangle,1); %number of filterbank channels
    
    dctm = @( N, M )( sqrt(2.0/M)*cos( repmat((0:N-1).',1,M).* repmat(pi*((1:M)-0.5)/M,N,1) ) );                 
    ceplifter = @( N, L )( 1+0.5*L*sin(pi*(0:N-1)/L) );
    
    DCT = dctm( N, M );  DCT(1,:) = DCT(1,:)/sqrt(2); 
    lifter = ceplifter( N, L );
    
    nfft = 2^nextpow2( size(speech_windows,1) );
    
    speech_fft = abs(fft(speech_windows,nfft));
    
    speech_mel = mel_triangle*speech_fft(1:nfft/2+1,:);
    
    speech_mel_log = log(speech_mel);

    coeff =  DCT*( speech_mel_log );

    coeff_mfcc = diag(lifter)*coeff;

end

