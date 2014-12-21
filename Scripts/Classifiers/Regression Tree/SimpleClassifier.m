% This is a simple classifier that just constructs a regression tree based
% on the features we've extracted and put into interictalVectors and
% preictalVectors.

interictalFiles = dir([subject '/' '*_interictal_*.mat']);
preictalFiles = dir([subject '/' '*_preictal_*.mat']);

ExtractFeatures;

y = [zeros(size(interictalFiles,1),1);ones(size(preictalFiles,1),1)];
tree = classregtree([interictalVectors;preictalVectors], y);

for i=1:size(testVectors,1)
    datapoint = testVectors(i,:);
    result = eval(tree, datapoint);
    fprintf('%s_test_segment_%04d.mat,%f\n',subject, i,result);
end