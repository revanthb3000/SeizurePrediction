interictalFeatureVectors = dlmread(strcat('Scripts/Classifiers/Regression Tree/',subject,'interictalFeatureVectors.txt'));
preictalFeatureVectors = dlmread(strcat('Scripts/Classifiers/Regression Tree/',subject,'preictalFeatureVectors.txt'));

meanFeatureVectors = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'XTrain.txt'));
numOfElectrodes = size(meanFeatureVectors,2);

interictalFeatureVectors = interictalFeatureVectors(:,(numOfElectrodes+1):end);
preictalFeatureVectors = preictalFeatureVectors(:,(numOfElectrodes+1):end);

XTrain = [interictalFeatureVectors ; preictalFeatureVectors];

dlmwrite(strcat('Scripts/Classifiers/Regression Tree/',subject,'XTrain.txt'),XTrain);