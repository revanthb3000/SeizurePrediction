% This script groups files that have the same sequence number together,
% averages out the data in them and then plots those graphs.

interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);
testFiles = dir([subject '/' '*_test_*.mat']);

% fileHandle = load([subject '/' interictalFiles(1).name]);
% names = fieldnames(fileHandle);
% 
% numOfElectrodes = size(fileHandle.(names{1}).data,1);
% numOfDataPoints = size(fileHandle.(names{1}).data,2);
% 
% averageInterictalData = zeros(numOfElectrodes, numOfDataPoints ,6);        %This creates 6 matrices - each of which contains the average data for a sequence number.
% 
% for i = 1:size(interictalFiles,1)
%     fileHandle = load([subject '/' interictalFiles(i).name]);
%     names = fieldnames(fileHandle)
%     fileData = fileHandle.(names{1}).data;
%     sequenceNumber = fileHandle.(names{1}).sequence;
%     averageInterictalData(:,:,sequenceNumber) = averageInterictalData(:,:,sequenceNumber) + fileData;
%     clear fileHandle;
% end
% 
% temp = size(interictalFiles,1)/6;
% averageInterictalData = averageInterictalData/(temp);
% 
% for i=1:6
%     averageInterictalData = averageInterictalData/size(interictalFiles,1);
%     fileName = strcat(subject,int2str(i),'SequenceAverageInterictalPlot.jpg');
%     plotData(averageInterictalData(:,:,i), fileName);
% end


fileHandle = load([subject '/' preictalFiles(1).name]);
names = fieldnames(fileHandle);

numOfElectrodes = size(fileHandle.(names{1}).data,1);
numOfDataPoints = size(fileHandle.(names{1}).data,2);

averagePreictalData = zeros(numOfElectrodes, numOfDataPoints ,6);        %This creates 6 matrices - each of which contains the average data for a sequence number.

for i = 1:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data;
    sequenceNumber = fileHandle.(names{1}).sequence;
    averagePreictalData(:,:,sequenceNumber) = averagePreictalData(:,:,sequenceNumber) + fileData;
    clear fileHandle;
end

temp = size(preictalFiles,1)/6;
averagePreictalData = averagePreictalData/(temp);

for i=1:6
    averagePreictalData = averagePreictalData/size(preictalFiles,1);
    fileName = strcat(subject,'-',int2str(i),'SequenceAveragePreictalPlot.jpg');
    plotData(averagePreictalData(:,:,i), fileName);
end