interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);

for i = 1:size(interictalFiles,1)
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    average = mean(fileData,1);                                                         % This is a 1x16 vector that contains the average observation values.
    class = NaiveBayesClassify(subject, average)
    
    clear fileHandle;
end

for i = 1:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data';
    
    average = mean(fileData,1);                                                         % This is a 1x16 vector that contains the average observation values.
    class = NaiveBayesClassify(subject, average)
    
    clear fileHandle;
end