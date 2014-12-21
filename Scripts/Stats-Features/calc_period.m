interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);

fileHandle = load([subject '/' preictalFiles(1).name]);
names = fieldnames(fileHandle);
numOfElectrodes = size(fileHandle.(names{1}).data,1);
clear fileHandle;

fourierMatrix = [];

for i = 1:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    fourier = fourierTransform(fileData);              
    fourierMatrix = [fourierMatrix; fourier];
    
    clear fileHandle;
end

fourier = mean(fourierMatrix,1);

dlmwrite(strcat('FourierStats/',subject,'preictalFourierMatrix.txt'),fourierMatrix);
dlmwrite(strcat('FourierStats/',subject,'preictalMeanFourier.txt'),fourier);


fourierMatrix = []

for i = 1:size(interictalFiles,1)
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    fourier = fourierTransform(fileData);                 % This is a 1x16 vector that contains the fourier observation values.
    fourierMatrix = [fourierMatrix; fourier];
    
    clear fileHandle;
end

fourier = mean(fourierMatrix,1);

dlmwrite(strcat('FourierStats/',subject,'interictalFourierMatrix.txt'),fourierMatrix);
dlmwrite(strcat('FourierStats/',subject,'interictalMeanFourier.txt'),fourier);
