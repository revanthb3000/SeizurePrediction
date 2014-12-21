function output = NaiveBayesClassify(subject, x)
	XTrain = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'XTrain.txt'));
	YTrain = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'YTrain.txt'));

	NBModel = NaiveBayes.fit(XTrain,YTrain,'Distribution','normal');
    output = predict(NBModel, x);
end
