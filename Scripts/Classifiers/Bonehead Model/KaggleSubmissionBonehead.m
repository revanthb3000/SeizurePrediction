XTrain = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'XTrain.txt'));
YTrain = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'YTrain.txt'));

NBModel = NaiveBayes.fit(XTrain,YTrain,'Distribution','normal');

testFiles = dir([subject '/' '*_test_*.mat']);

for i = 1:size(testFiles,1)    
    fileHandle = load([subject '/' testFiles(i).name]);
    names = fieldnames(fileHandle);
    fileData = fileHandle.(names{1}).data';
    average = mean(fileData,1);
    output = predict(NBModel, average);
    clear fileHandle;
    fprintf('%s,%d\n',testFiles(i).name,output);
end