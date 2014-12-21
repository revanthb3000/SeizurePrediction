testFiles = dir([subject '/' '*_test_*.mat']);

fileHandle = load([subject '/' testFiles(1).name]);
names = fieldnames(fileHandle);
numOfElectrodes = size(fileHandle.(names{1}).data,1);
clear fileHandle;

numTopFrequencies = 20;

XTest = zeros(0, numOfElectrodes * numTopFrequencies);

for i = 1:size(testFiles,1)
    fileName = [subject '/' testFiles(i).name];
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
    XTest = [XTest;featureVector];
    fprintf('Finished processing %s\n', fileName);
    clear fileHandle;
end

dlmwrite(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'KaggleXTest.txt'),XTest);