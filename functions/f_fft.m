function [spectro] = f_fft(path, f_ech)

% signal
[speech, fs] = audioread(path);

% resampling at f_ech
speech_dw = resample(speech, f_ech, fs);

spectro = spectrogram(speech_dw);
spectrogram(speech_dw)
end