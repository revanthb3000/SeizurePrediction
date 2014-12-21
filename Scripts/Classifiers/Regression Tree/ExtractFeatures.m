interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);
testFiles = dir([subject '/' '*_test_*.mat']);

interictalVectors = [];
for i = 1:size(interictalFiles,1)
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    average = mean(fileData,1);                                                         % This is a 1x16 vector that contains the average observation values.
    covarianceMatrix = cov(fileData);                                                   % A 16x16 matrix containing the covariance values. Diagonals are variances.
    variance = diag(covarianceMatrix)';                                                 % A 1x16 vector that contains the variance of each dimension. 
    correlationCoefficients = corrcoef(fileData);                                       % A 16x16 matrix containing the correlation coefficients.
    correlationVector = correlationCoefficients(~~tril(correlationCoefficients,-1))';   % This is a vector representation of the unique correlation coefficients.

    featureVector = horzcat(average, variance, correlationVector);    
    interictalVectors = [interictalVectors; featureVector];
    
    clear fileHandle;
end


preictalVectors = [];
for i = 1:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';

    average = mean(fileData,1);                                                         % This is a 1x16 vector that contains the average observation values.
    covarianceMatrix = cov(fileData);                                                   % A 16x16 matrix containing the covariance values. Diagonals are variances.
    variance = diag(covarianceMatrix)';                                                 % A 1x16 vector that contains the variance of each dimension. 
    correlationCoefficients = corrcoef(fileData);                                       % A 16x16 matrix containing the correlation coefficients.
    correlationVector = correlationCoefficients(~~tril(correlationCoefficients,-1))';   % This is a vector representation of the unique correlation coefficients.

    featureVector = horzcat(average, variance, correlationVector);    
    preictalVectors = [preictalVectors; featureVector];

    clear fileHandle;
end

dlmwrite(strcat('Scripts/Classifiers/Regression Tree/',subject,'interictalFeatureVectors.txt'),interictalVectors);
dlmwrite(strcat('Scripts/Classifiers/Regression Tree/',subject,'preictalFeatureVectors.txt'),preictalVectors);

% testVectors = [];
% for i = 1:size(testFiles,1)
%     fileHandle = load([subject '/' testFiles(i).name]);
%     names = fieldnames(fileHandle)
%     fileData = fileHandle.(names{1}).data';
%     
%     average = mean(fileData,1);                                                         % This is a 1x16 vector that contains the average observation values.
%     covarianceMatrix = cov(fileData);                                                   % A 16x16 matrix containing the covariance values. Diagonals are variances.
%     variance = diag(covarianceMatrix)';                                                 % A 1x16 vector that contains the variance of each dimension. 
%     correlationCoefficients = corrcoef(fileData);                                       % A 16x16 matrix containing the correlation coefficients.
%     correlationVector = correlationCoefficients(~~tril(correlationCoefficients,-1))';   % This is a vector representation of the unique correlation coefficients.
%     
%     featureVector = horzcat(average, variance, correlationVector);    
%     testVectors = [testVectors; featureVector];
%     
%     clear fileHandle;
% end

