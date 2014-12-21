% This script runs through all interrictal files, finds the average values
% among all segments and then plots those values. Same for preictal.

interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);
testFiles = dir([subject '/' '*_test_*.mat']);

fileHandle = load([subject '/' preictalFiles(1).name]);
names = fieldnames(fileHandle);
averagePreictalData = fileHandle.(names{1}).data;

for i = 2:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data;
    averagePreictalData = averagePreictalData + fileData;
    clear fileHandle;
end

averagePreictalData = averagePreictalData/size(preictalFiles,1);
fileName = strcat(subject,'averagePreictalPlot.jpg');
plotData(averagePreictalData, fileName);

fileHandle = load([subject '/' interictalFiles(1).name]);
names = fieldnames(fileHandle);
averageInterictalData = fileHandle.(names{1}).data;

for i = 2:size(interictalFiles,1)
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data;
    averageInterictalData = averageInterictalData + fileData;
    clear fileHandle;
end

averageInterictalData = averageInterictalData/size(interictalFiles,1);
fileName = strcat(subject,'averageInterictalPlot.jpg');
plotData(averageInterictalData, fileName);

