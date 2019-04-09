function decoded = viterbi(pvprob, index, states)

% receives a vector of observations
% calculates the most probable source of these observations
decoded = zeros(length(pvprob),1);
[~, indices] = max(pvprob,[],2);
for i = 1:max(size(pvprob))
    decoded(i) = obs2index(indices(i), index, states);
end
end
