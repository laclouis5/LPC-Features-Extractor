clear;
close all;
clc;

%% parameters
path     = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/Matlab/data/data_solo/frm02/frm02_s05_solo.wav';
f_ech    = 8000;
thresh   = ''; % non scalar value <=> no threshold
nb_coeff = 20;

LPC = f_LPC(path, f_ech, 20, thresh, 30, 15);

%% plot
figure,
% subplot(221), plot(speech_f);
% subplot(222), plot(energy);
% subplot(223), plot(e_logical);
axis([-inf, inf, -1, 2]);
subplot(224), plot(LPC);