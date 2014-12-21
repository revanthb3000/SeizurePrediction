interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);

fileHandle = load([subject '/' preictalFiles(1).name]);
names = fieldnames(fileHandle);
numOfElectrodes = size(fileHandle.(names{1}).data,1);
clear fileHandle;

averageMatrix = [];
varianceMatrix = [];
averageCovarianceMatrix = zeros(numOfElectrodes, numOfElectrodes);
averageCorrelationCoeffcientsMatrix = zeros(numOfElectrodes, numOfElectrodes);

for i = 1:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    average = mean(fileData,1);                   % This is a 1x16 vector that contains the average observation values.
    averageMatrix = [averageMatrix; average];
    
    covarianceMatrix = cov(fileData);             % A 16x16 matrix containing the covariance values. Diagonals are variances.
    variance = diag(covarianceMatrix)';           % A 1x16 vector that contains the variance of each dimension.
    varianceMatrix = [varianceMatrix; variance];
    
    correlationCoefficients = corrcoef(fileData); % A 16x16 matrix containing the correlation coefficients.
    
    averageCovarianceMatrix = averageCovarianceMatrix + covarianceMatrix;
    averageCorrelationCoeffcientsMatrix = averageCorrelationCoeffcientsMatrix + correlationCoefficients;
    
    clear fileHandle;
end

average = mean(averageMatrix,1);
variance = mean(varianceMatrix,1);
averageCovarianceMatrix = averageCovarianceMatrix/size(preictalFiles,1);
averageCorrelationCoeffcientsMatrix = averageCorrelationCoeffcientsMatrix/size(preictalFiles,1);

dlmwrite(strcat('Stats/SegmentWise/',subject,'preictalMeanMatrix.txt'),averageMatrix);
dlmwrite(strcat('Stats/',subject,'preictalMeanAveraged.txt'),average);
dlmwrite(strcat('Stats/SegmentWise/',subject,'preictalVarianceMatrix.txt'),varianceMatrix);
dlmwrite(strcat('Stats/',subject,'preictalVarianceAveraged.txt'),variance);
dlmwrite(strcat('Stats/',subject,'preictalCovarianceAveraged.txt'),averageCovarianceMatrix);
dlmwrite(strcat('Stats/',subject,'preictalCorrelationAveraged.txt'),averageCorrelationCoeffcientsMatrix);


averageMatrix = []
varianceMatrix = []
for i = 1:size(interictalFiles,1)
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    average = mean(fileData,1);                 % This is a 1x16 vector that contains the average observation values.
    averageMatrix = [averageMatrix; average];
    
    covarianceMatrix = cov(fileData);           % A 16x16 matrix containing the covariance values. Diagonals are variances.
    variance = diag(covarianceMatrix)';         % A 1x16 vector that contains the variance of each dimension.
    varianceMatrix = [varianceMatrix; variance];
    
    correlationCoefficients = corrcoef(fileData); % A 16x16 matrix containing the correlation coefficients.
    
    averageCovarianceMatrix = averageCovarianceMatrix + covarianceMatrix;
    averageCorrelationCoeffcientsMatrix = averageCorrelationCoeffcientsMatrix + correlationCoefficients;
    
    clear fileHandle;
end

average = mean(averageMatrix,1);
variance = mean(varianceMatrix,1);
averageCovarianceMatrix = averageCovarianceMatrix/size(interictalFiles,1);
averageCorrelationCoeffcientsMatrix = averageCorrelationCoeffcientsMatrix/size(interictalFiles,1);

dlmwrite(strcat('Stats/SegmentWise/',subject,'interictalMeanMatrix.txt'),averageMatrix);
dlmwrite(strcat('Stats/',subject,'interictalMeanAveraged.txt'),average);
dlmwrite(strcat('Stats/SegmentWise/',subject,'interictalVarianceMatrix.txt'),varianceMatrix);
dlmwrite(strcat('Stats/',subject,'interictalVarianceAveraged.txt'),variance);
dlmwrite(strcat('Stats/',subject,'interictalCovarianceAveraged.txt'),averageCovarianceMatrix);
dlmwrite(strcat('Stats/',subject,'interictalCorrelationAveraged.txt'),averageCorrelationCoeffcientsMatrix);