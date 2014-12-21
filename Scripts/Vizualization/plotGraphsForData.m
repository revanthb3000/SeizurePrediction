% This function goes in, reads each segment file and plots a graph for it.

interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);
testFiles = dir([subject '/' '*_test_*.mat']);

for i = 1:size(preictalFiles,1)
    fileHandle = load([subject '/' preictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data;
    fileName = strrep(preictalFiles(i).name, '.mat', '.jpg');
    plotData(fileData, fileName);
    clear fileHandle;
end

for i = 1:size(interictalFiles,1)
    fileHandle = load([subject '/' interictalFiles(i).name]);
    names = fieldnames(fileHandle)
    fileData = fileHandle.(names{1}).data;
    fileName = strrep(interictalFiles(i).name, '.mat', '.jpg');
    plotData(fileData, fileName);
    clear fileHandle;
end
