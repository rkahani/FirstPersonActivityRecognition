function [encoded_feat] = ccf( feat, L, delta)
%
%   -------------------------------
%   Video Feature Representation:
%       R. Kahani, A. Talebpour, and A. Mahmoudi-Aznaveh, "Time series correlation for first-person videos," in Electrical Engineering (ICEE), 2016 24th Iranian Conference on, 2016, pp. 805-809.
%   -------------------------------
%   Inputs:  
%       feat:   size of the feat matrix is: [num_of_features, num_of_frames]
%       L:      number of non-overlapping intervals
%       delta:  number of series in each group
%               *delta must be divisible by num_of_features
%   Output:
%       encoded_feat: an encoded vector with length of: ((lambda * (lambda-1))/2) * L
%   -------------------------------
%   Example:
%       load('sample.mat');
%       enc_feat = ccf(feat, 1, 64);
%       enc_feat16 = ccf(feat, 16, 64);
%   -------------------------------
%   11/01/2015
%   -------------------------------
%
tic;
n_features = size(feat, 1);
n_frames = size(feat, 2);
lambda = n_features/delta;
grouped_feat = zeros(lambda, delta * n_frames);
for ft=1:lambda
    te = reshape(feat(((ft-1)*delta)+1:ft*delta, :), 1, []);
    grouped_feat(ft, :) = te;
end
encoded_feat = [];
for w=1:L
    st_w = round((w-1) * (n_frames/L) + 1);
    st = (st_w-1) * delta + 1;
    en = round(w * (n_frames/L)) * delta;
    
    thisPart = grouped_feat(:, st:en);
    CorrM = corr(thisPart', 'type', 'Pearson');
    t = triu(CorrM, 1);
    F = t(t~=0)';
    encoded_feat = [encoded_feat, F];
end
toc;
end

