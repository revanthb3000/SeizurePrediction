function[error] = CVSplit(subject)
    interictalFiles = dir([subject '/' '*_interictal_*.mat']);
    preictalFiles = dir([subject '/' '*_preictal_*.mat']);

    K = 3;
    numOfInterictalSamples = size(interictalFiles,1);
    numOfPreictalSamples = size(preictalFiles,1);

    interictalDataDivison = crossvalind('Kfold', numOfInterictalSamples, K);
    preictalDataDivison = crossvalind('Kfold', numOfPreictalSamples, K);

    meanFeatureVectors = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'XTrain.txt'));
    numOfElectrodes = size(meanFeatureVectors,2);
    %These are just the mean vectors for each segment.
    
    varianceAndCorrelationFeatures = dlmread(strcat('Scripts/Classifiers/Regression Tree/',subject,'XTrain.txt'));
    fourierXTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrainBiVariate.txt'));
    
    %Adding More Features
    fourierXTrain = [varianceAndCorrelationFeatures fourierXTrain(:,1)];
    
    splitNumber = [];
    errors = [];

    precisions = [];
    recalls = [];
    
    for testSplitNumber = 1:K
        XTrain = [];
        YTrain = [];

        XTest = [];
        YTest = [];

        sampleNumber = 1;

        for i=1:size(interictalDataDivison,1)
            groupNumber = interictalDataDivison(i);

            %Obtain the feature vector of the data segment over here.
            featureVector = getSampleFeatureVector(sampleNumber,fourierXTrain);
            sampleNumber = sampleNumber + 1;

            if(groupNumber == testSplitNumber) % This is our test set
                XTest = [XTest; featureVector];
                YTest = [YTest; 0];
            else
                XTrain = [XTrain; featureVector];
                YTrain = [YTrain; 0];
            end
        end

        for i=1:size(preictalDataDivison,1)
            groupNumber = preictalDataDivison(i);
            
            featureVector = getSampleFeatureVector(sampleNumber,fourierXTrain);
            sampleNumber = sampleNumber + 1;

            if(groupNumber == testSplitNumber) % This is our test set
                XTest = [XTest; featureVector];
                YTest = [YTest; 1];
            else
                XTrain = [XTrain; featureVector];
                YTrain = [YTrain; 1];
            end
        end

        % Train your classifier using XTrain and YTrain over here
        %NBModel = NaiveBayes.fit(XTrain,YTrain,'Distribution','normal');
        %regressionTree = classregtree(XTrain, YTrain);
        
        %SVMStruct = svmtrain(XTrain, YTrain, 'kernel_function', 'rbf');
        Ensemble = fitensemble(XTrain,YTrain,'AdaBoostM1',100,'Tree');

        error = 0;
        
        numPreictalPredictions = 0;                 %Retrieved
        numOfAccuratePreictalPredictions = 0;       %Retrieved and Relevant
        numOfActualPreictalData = numOfPreictalSamples/K; %Relevant.
        
        for i=1:size(XTest,1)
            dataPoint = XTest(i,:);
            actualLabel = YTest(i);

%             predictedLabel = predict(NBModel, dataPoint); % Use your classifier over here to get the label for the datapoint.
%             result = eval(regressionTree, dataPoint);
            
            %predictedLabel = svmclassify(SVMStruct,dataPoint);
            predictedLabel = predict(Ensemble, dataPoint);

            if(predictedLabel == 1)
                numPreictalPredictions = numPreictalPredictions + 1;
            end
            
            if(predictedLabel~=actualLabel)
                error = error + 1;
            else
                if(actualLabel == 1)
                    numOfAccuratePreictalPredictions = numOfAccuratePreictalPredictions + 1;
                end
            end
        end
        
        if(numPreictalPredictions==0)
            numPreictalPredictions = 1; %I don't want NaN
        end
        
        p = numOfAccuratePreictalPredictions/numPreictalPredictions;
        r = numOfAccuratePreictalPredictions/numOfActualPreictalData;
        
        precisions = [precisions, p];
        recalls = [recalls, r];
        splitNumber = [splitNumber, testSplitNumber];
        errors = [errors, error];
    end

    error = mean(errors);

    fprintf('Fold Size : %d\n',K);
    fprintf('Number of training data points : %d\n',size(XTrain,1));
    fprintf('Number of testing data points : %d\n',size(XTest,1));
    fprintf('Interictal data to Preictal data Ratio : %d : %d\n', numOfInterictalSamples, numOfPreictalSamples);
    for i=1:size(splitNumber,2)
        fprintf('When fold #%d is used for testing : \n', i);
        fprintf('\tError = %d\n',errors(i));
        fprintf('\tPrecision = %d\n',precisions(i));
        fprintf('\tRecall = %d\n',recalls(i));
        fMeasure = 3*precisions(i) * recalls(i);
        fMeasure = fMeasure/(2*precisions(i) + recalls(i));
        fprintf('\tF-Measure is : = %d\n',fMeasure);
    end
    fprintf('Average Error : %f\n',error);
    
end

function [featVector] = getFeatureVector(fileName)
    fileHandle = load(fileName);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';    
    clear fileHandle;
    featVector = mean(fileData,1);
end

function [featVector] = getSampleFeatureVector(sampleNumber,featureVectors)
    featVector = featureVectors(sampleNumber,:);
end
