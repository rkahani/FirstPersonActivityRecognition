function [encoded_feat] = acf( feat, Gamma, NStrides)
%
%   -------------------------------
%   Video Feature Representation:
%       R. Kahani, A. Talebpour, and A. Mahmoudi-Aznaveh, "A Correlation Based Feature Representation for First-Person Activity Recognition," arXiv preprint arXiv:1711.05523, 2017.
%   -------------------------------
%   Inputs:  
%       feat:       size of the feat matrix is: [num_of_features, num_of_frames]
%       Gamma:      number of lags
%       NStrides:   number of strides to skip autocorr features
%                   
%   Output:
%       encoded_feat: an encoded vector with length of: (Gamma * num_of_features)
%   -------------------------------
%   Example:
%       load('sample.mat');
%       enc_feat = acf(feat, 6, 4);
%   -------------------------------
%   3/7/2016 
%   -------------------------------
%
tic;
n_features = size(feat, 1);
encoded_feat = [];
for s=1:n_features
    c = autocorr(feat(s,:), Gamma * NStrides);
    F = c(:, 2:NStrides:end);
    encoded_feat = [encoded_feat, F];
end
toc;

end

