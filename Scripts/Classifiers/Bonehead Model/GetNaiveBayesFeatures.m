interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);

fileHandle = load([subject '/' preictalFiles(1).name]);
names = fieldnames(fileHandle);
numOfElectrodes = size(fileHandle.(names{1}).data,1);
clear fileHandle;

XTrain = zeros(0, numOfElectrodes);
YTrain = zeros(0,1);

for i = 1:size(interictalFiles,1)    
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    average = mean(fileData,1);
    XTrain = [XTrain ; average];
    YTrain = [YTrain ; 0];
    clear fileHandle;
end

for i = 1:size(preictalFiles,1)    
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    average = mean(fileData,1);
    XTrain = [XTrain ; average];
    YTrain = [YTrain ; 1];
    clear fileHandle;
end

dlmwrite(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'XTrain.txt'),XTrain);
dlmwrite(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'YTrain.txt'),YTrain);