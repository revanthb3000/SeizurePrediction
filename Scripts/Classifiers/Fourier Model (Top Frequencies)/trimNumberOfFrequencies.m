XTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrain.txt'));

numberOfFreqs = 15;
trimmedXTrain = [];
numElectrodes = size(XTrain,2)/20;

for i=1:size(XTrain,1)
    featureVector = XTrain(i,:);
    startIndex = 1;
    endIndex = 20;
    trimmedFeatureVector = [];
    for j=1:numElectrodes
        frequencies = featureVector(:,startIndex:endIndex);
        startIndex = startIndex + 20;
        endIndex = endIndex + 20;
        trimmedFeatureVector = [trimmedFeatureVector frequencies(:,1:5)];
    end
    trimmedXTrain = [trimmedXTrain;trimmedFeatureVector];
end 

dlmwrite(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrain', num2str(numberOfFreqs), 'Freq.txt'),trimmedXTrain);