%% Neural Network
close all
clear
clc

nntraintool('close');

if isunix
    SLASH = '/';
else
    SLASH = '\';
end

%% Input Parameters
% pathIn = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/LPC';
pathIn = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/MFCC';

nbPers  = 16;
nbEch   = 500; % per person
nbCoeff = 20;

nbHiddenNeurones = floor((nbPers + nbCoeff) / 2);
% nbHiddenNeurones = 100;

cd(pathIn);

data = {};

for i = 1:nbPers
    if i < 10
        d = load(strcat('irm0', string(i), SLASH, 'irm0', string(i), '_f01_solo.mat'));
    else
        d = load(strcat('irm', string(i), SLASH,  'irm', string(i), '_f01_solo.mat'));
    end
    
    data{i} = d.fileOut;
end

%%
x_train = [];
t_train = [];

for i = 1:nbPers
    
   len = size(data{i}, 2);
   R   = randi(len, 1, nbEch);
   
   x_train = [x_train, data{i}(:, R)];
   t_train(i, (i - 1) * nbEch + 1:i * nbEch) = 1;
end


%%
net = patternnet(nbHiddenNeurones);
net.trainParam.epochs = 1000;
net.trainParam.max_fail = 300;
net = train(net,x_train,t_train);

% view(net)
y = net(x_train);
perf = perform(net,t_train,y);
% classes = vec2ind(y);
