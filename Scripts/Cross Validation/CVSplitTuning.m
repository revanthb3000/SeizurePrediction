function[error] = CVSplitTuning(subject)
    testFraction = 0.2;
    interictalFiles = dir([subject '/' '*_interictal_*.mat']);
    preictalFiles = dir([subject '/' '*_preictal_*.mat']);
    
    numOfInterictalSamples = size(interictalFiles,1);
    numOfTrainingInterictalSamples = numOfInterictalSamples - floor(testFraction*numOfInterictalSamples);
    
    numOfPreictalSamples = size(preictalFiles,1);
    numOfTrainingPreictalSamples = numOfPreictalSamples - floor(testFraction*numOfPreictalSamples);
    
    featureMatrix = getFeatureMatrix(subject);
    interictalTrainingMatrix = featureMatrix(1:numOfTrainingInterictalSamples,:);
    interictalTestingMatrix = featureMatrix(numOfTrainingInterictalSamples+1:numOfInterictalSamples,:);
    interictalYTrain = zeros(size(interictalTrainingMatrix,1),1);
    interictalYTest = zeros(size(interictalTestingMatrix,1),1);
    
    preictalTrainingMatrix = featureMatrix((numOfInterictalSamples+1):(numOfInterictalSamples+ 1 + numOfTrainingPreictalSamples),:);
    preictalTestingMatrix = featureMatrix((numOfInterictalSamples+ 1 + numOfTrainingPreictalSamples)+1:end,:);
    preictalYTrain = ones(size(preictalTrainingMatrix,1),1);
    preictalYTest = ones(size(preictalTestingMatrix,1),1);

    XTrain = [interictalTrainingMatrix;preictalTrainingMatrix];
    YTrain = [interictalYTrain; preictalYTrain];
    
    XTest = [interictalTestingMatrix;preictalTestingMatrix];
    YTest = [interictalYTest; preictalYTest];
    
    [C, sigma] = trainParameters(XTrain, size(interictalTrainingMatrix,1), size(preictalTrainingMatrix,1));
%     runOnTestData(C, sigma, XTrain, XTest, YTrain, YTest);
end

function[C, sigma] = trainParameters(featureMatrix,numOfInterictalSamples,numOfPreictalSamples)
    sigma = 0.5;
    while(sigma<10)
    C = 0.1;
    while(C<10)
        K = 3;

        interictalDataDivison = crossvalind('Kfold', numOfInterictalSamples, K);
        preictalDataDivison = crossvalind('Kfold', numOfPreictalSamples, K);

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
                featureVector = getSampleFeatureVector(sampleNumber,featureMatrix);
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

                featureVector = getSampleFeatureVector(sampleNumber,featureMatrix);
                sampleNumber = sampleNumber + 1;

                if(groupNumber == testSplitNumber) % This is our test set
                    XTest = [XTest; featureVector];
                    YTest = [YTest; 1];
                else
                    XTrain = [XTrain; featureVector];
                    YTrain = [YTrain; 1];
                end
            end

            %Train your classifier using XTrain and YTrain over here
            SVMStruct = svmtrain(XTrain, YTrain, 'kernel_function', 'rbf', 'RBF_Sigma', sigma, 'BoxConstraint', C);

            error = 0;

            numPreictalPredictions = 0;                 %Retrieved
            numOfAccuratePreictalPredictions = 0;       %Retrieved and Relevant
            numOfActualPreictalData = numOfPreictalSamples/K; %Relevant.

            for i=1:size(XTest,1)
                dataPoint = XTest(i,:);
                actualLabel = YTest(i);
                predictedLabel = svmclassify(SVMStruct,dataPoint);

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

%         fprintf('Fold Size : %d\n',K);
%         fprintf('Number of training data points : %d\n',size(XTrain,1));
%         fprintf('Number of testing data points : %d\n',size(XTest,1));
%         fprintf('Interictal data to Preictal data Ratio : %d : %d\n', numOfInterictalSamples, numOfPreictalSamples);
        for i=1:size(splitNumber,2)
            if(recalls(i)~=0)
                C
                sigma
                fprintf('When fold #%d is used for testing : \n', i);
                fprintf('\tError = %d\n',errors(i));
                fprintf('\tPrecision = %d\n',precisions(i));
                fprintf('\tRecall = %d\n',recalls(i));
                fMeasure = 3*precisions(i) * recalls(i);
                fMeasure = fMeasure/(2*precisions(i) + recalls(i));
                fprintf('\tF-Measure is : = %d\n',fMeasure);
            end
        end
%         fprintf('Average Error : %f\n',error);
        C = C + 0.5;
    end
    sigma = sigma + 0.5;
    end
end

function[featureMatrix] = getFeatureMatrix(subject)
    meanFeatureVectors = dlmread(strcat('Scripts/Classifiers/Bonehead Model/Parameters/',subject,'XTrain.txt'));
    numOfElectrodes = size(meanFeatureVectors,2);

    varianceAndCorrelationFeatures = dlmread(strcat('Scripts/Classifiers/Regression Tree/',subject,'XTrain.txt'));
    fourierXTrain = dlmread(strcat('Scripts/Classifiers/Fourier Model (Top Frequencies)/Parameters/',subject,'XTrainBiVariate.txt'));
    fourierAmps = dlmread(strcat('FourierAmps/',subject,'XTrain.txt'));
    fourierEuclideanDists = dlmread(strcat('FourierAmps/',subject,'EuclideanDistanceXTrain.txt'));
    fourierCosineDists = dlmread(strcat('FourierAmps/',subject,'CosineDistanceXTrain.txt'));
    %Adding More Features
    featureMatrix = [varianceAndCorrelationFeatures fourierCosineDists];
end

function [featVector] = getSampleFeatureVector(sampleNumber,featureVectors)
    featVector = featureVectors(sampleNumber,:);
end
