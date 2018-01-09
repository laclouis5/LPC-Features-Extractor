close all
clear
clc

path  = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/audioBank/data_solo/frm02/frm02_s05_solo.wav';
f_ech = 8000;

[speech, fs] = audioread(path);
speech_dw    = resample(speech, f_ech, fs);

N = size(speech_dw, 1);

t_axis = (1:N)/f_ech;
f_axis = f_ech*(-1/2:1/N:1/2 - 1/N);

F = fftshift(fft(speech_dw));

figure, plot(t_axis, speech_dw);
figure, plot(f_axis, abs(F));