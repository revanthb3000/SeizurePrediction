XTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrain.txt'));
YTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'YTrain.txt'));

numFreqs = 20;
numElectrodes = size(XTrain,2)/numFreqs;
newTrainingData = [];

for i = 1:size(XTrain,1)
   newFeatureVector = [];
   for j = 1:numElectrodes
       for k=j+1:numElectrodes
           vector1 = XTrain(i,(j-1)*numFreqs+1:(j)*numFreqs);
           vector2 = XTrain(i,(k-1)*numFreqs+1:(k)*numFreqs);
           newFeatureVector = [newFeatureVector getFourierFreqSimilarity(vector1,vector2)];
       end
   end
   newTrainingData = [newTrainingData;newFeatureVector];
end

dlmwrite(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrainBiVariate.txt'),newTrainingData);
