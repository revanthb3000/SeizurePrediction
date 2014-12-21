XTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrain.txt'));
YTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'YTrain.txt'));

YTrain = YTrain + 1; %Since Y has to have positive integers.

%Training
[Model,dev,stats] = mnrfit(XTrain(5:end,:), YTrain(5:end,:));
