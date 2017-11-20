clear;
close all;
clc;

%% parameters
path     = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/audioBank/data_solo/frm02/frm02_s05_solo.wav';
f_ech    = 8000;
thresh   = ''; % non scalar value <=> no threshold
nb_coeff = 20;

time_window = 30;
time_step = 15;

LPC = f_LPC(path, f_ech, 20, thresh, 30, 15);
x   = f_autocorr(path, f_ech, time_window, time_step);
[y, f_axis] = f_fft(path, f_ech, time_window, time_step);
z = abs(y);

%% plot
figure, plot(LPC);
figure, plot(f_axis, sum(z, 2));