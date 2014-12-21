fourierAmps = dlmread(strcat('FourierAmps/',subject,'XTrain.txt'));

numElectrodes = size(fourierAmps,2)/100;

eucilideanDistance = [];
cosineDistance = [];

for i = 1:size(fourierAmps,1)
    amplitudeVector = fourierAmps(i,:);
    amplitudeMatrix = vec2mat(amplitudeVector,100);
    eucilideanDistance = [eucilideanDistance; pdist(amplitudeMatrix,'euclidean')];
    cosineDistance = [cosineDistance;pdist(amplitudeMatrix,'cosine')];
end

dlmwrite(strcat('FourierAmps/',subject,'EuclideanDistanceXTrain.txt'),eucilideanDistance);
dlmwrite(strcat('FourierAmps/',subject,'CosineDistanceXTrain.txt'),cosineDistance);