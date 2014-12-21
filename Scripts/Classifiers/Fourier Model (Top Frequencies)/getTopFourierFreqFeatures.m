interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);

fileHandle = load([subject '/' preictalFiles(1).name]);
names = fieldnames(fileHandle);
numOfElectrodes = size(fileHandle.(names{1}).data,1);
clear fileHandle;

numTopFrequencies = 20;

XTrain = zeros(0, numOfElectrodes * numTopFrequencies);
YTrain = zeros(0,1);

for i = 1:size(interictalFiles,1)
    fileName = [subject '/' interictalFiles(i).name];
    fileHandle = load(fileName);
    names = fieldnames(fileHandle);
    samplingFrequency = fileHandle.(names{1}).sampling_frequency;
    data = fileHandle.(names{1}).data;
    
    featureVector = [];
    for electrodeNumber = 1:numOfElectrodes
        [frequencies, amplitudes] = getTopFourierFreqs(data, samplingFrequency, electrodeNumber);
        frequencies = frequencies';
        amplitudes = amplitudes';
        [amplitudes, indices] = sortrows(amplitudes);
        frequencies = frequencies(indices);
        topFrequencies = frequencies(1:numTopFrequencies,:)';
        featureVector = [featureVector topFrequencies];
    end
    XTrain = [XTrain;featureVector];
    YTrain = [YTrain ; 0];
    fprintf('Finished processing %s\n', fileName);
    clear fileHandle;
end

for i = 1:size(preictalFiles,1)
    fileName = [subject '/' preictalFiles(i).name];
    fileHandle = load(fileName);
    names = fieldnames(fileHandle);
    samplingFrequency = fileHandle.(names{1}).sampling_frequency;
    data = fileHandle.(names{1}).data;
    
    featureVector = [];
    for electrodeNumber = 1:numOfElectrodes
        [frequencies, amplitudes] = getTopFourierFreqs(data, samplingFrequency, electrodeNumber);
        frequencies = frequencies';
        amplitudes = amplitudes';
        [amplitudes, indices] = sortrows(amplitudes);
        frequencies = frequencies(indices);
        topFrequencies = frequencies(1:numTopFrequencies,:)';
        featureVector = [featureVector topFrequencies];
    end
    XTrain = [XTrain;featureVector];
    YTrain = [YTrain ; 1];
    fprintf('Finished processing %s\n', fileName);
    clear fileHandle;
end

dlmwrite(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrain.txt'),XTrain);
dlmwrite(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'YTrain.txt'),YTrain);