clear;
close all;
clc;

%% parameters
path     = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/Matlab/data/data_solo/frm02/frm02_s05_solo.wav';
f_ech    = 8000;
thresh   = ''; % non scalar value <=> no threshold
nb_coeff = 20;

LPC = f_LPC(path, f_ech, 20, thresh, 30, 15);
x   = f_autocorr(path, f_ech, time_window, time_step);
y   = f_fft(path, f_ech);

%% plot
figure,
% subplot(221), plot(speech_f);
% subplot(222), plot(energy);
% subplot(223), plot(e_logical);
axis([-inf, inf, -1, 2]);
subplot(224), plot(LPC);

l = size(x, 1);
axis = -l/2:1:l/2 - 1;

figure, plot(axis, x);