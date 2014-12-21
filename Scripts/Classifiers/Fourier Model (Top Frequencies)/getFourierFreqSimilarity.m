function [ similarity ] = getFourierFreqSimilarity(sequence1, sequence2)
    %similarity = norm(sequence1-sequence2,2);
    sequence1 = floor(sequence1);
    sequence2 = floor(sequence2);
    similarity = 1 + size(intersect(sequence1,sequence2),2);
end

