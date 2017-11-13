%% Folder script
clc
clear
close all

if isunix
    SLASH = '/';
else
    SLASH = '\';
end

%% Param
% Choose the path were WAV files are stored. Put the absolute path and not
% the relative one.
pathIn  = '/Users/laclouis5/Documents/Etudes/Enseirb-Matmeca/Cours_E3/S9_project/audioBank/data_solo';

% Choose were the data produced will be stored. A subfolder named 'data'
% will be created.
pathOut = '/Users/laclouis5/Downloads';
nbPers  = 36;

% Choose the number of LPC coeff, the threshold for removing speech blank
% and others. Default: et f_ech = 8000, thresh = '', nb_coeff = 20.
f_ech    = 8000;
thresh   = '';
nb_coeff = 20;
len_win  = 30;
len_step = 15;

%% Main
currDir = cd;

if isfolder(pathIn) && isfolder(pathOut)
    
    % init
    subFolder = 'data';
    mkdir(pathOut, subFolder);
    pathOut = strcat(pathOut, SLASH, subFolder);
    
    cd(pathIn);
    myFileList   = dir(strcat('**', SLASH, '*.wav'));
    myFileNumber = length(myFileList);
    
    % read
    if isempty(myFileList)
        error('Files must me in .waw type');
        
    else
        for idx = 1:myFileNumber
           
            % path to read
            % cd(pathIn);
            path = strcat(myFileList(idx).folder, SLASH, myFileList(idx).name);
            
            % function
            fileOut = f_LPC(path, f_ech, nb_coeff, thresh, len_win, len_step);
            
            % file out and disp
            nameOut = replace(myFileList(idx).name, 'wav', 'mat');
            nameOut = strcat(pathOut, SLASH, nameOut);
            
            save(nameOut, 'fileOut');
            
            clc;
            avancement = 100 * idx / myFileNumber;
            fprintf('Percent achieved: %.2f%%\n', avancement);
        end
        
        clc;
        fprintf('Done!\n');
    end
    
else
    
    error('PathIn or PathOut do no path does not exist');
end

% organize
% cd(pathOut);
% 
% for idx = 1:nbPers
%     
%     listDir = dir(strcat('**', SLASH, '*.mat'));
%     nameFile = listDir(1).name;
%     
%     idFolderFile = strcat(extractBefore(nameFile, 6));
%     id2 = strcat(idFolderFile, '*');
%     movefile(id2, idFolderFile);
% end

cd(currDir);