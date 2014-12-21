% This is a simple script that iterates through all subjects you have and
% executes code on those folders.
subjects = {'Dog_1';'Dog_2';'Dog_3';'Dog_4';'Dog_5';'Patient_1';'Patient_2'};

for i=1:size(subjects)
	subject = char(subjects(i)) %This is the key part. Once you set the subject, the other functions will work.
	%plotAverageElectrodeData;
	%plotSequenceAverageElectrodeData;
    %ExtractStats;
    %ExtractFeatures;
    %calc_period
    CVSplit(subject);
    %CVSplitTuning(subject);
    %obtainAmplitudeCorrelations;
    %obtainFourierFreqSequenceSimilarity;
    %plotCorrelation;
    %KaggleSubmissionBonehead;
    %FourierStatsCorrelation;
    %getTopFourierFreqFeatures
    %getTestSegmentsTopFourierFreqFeatures;
    %trimNumberOfFrequencies;
    %RemoveMeansFromFeatureVector
end
