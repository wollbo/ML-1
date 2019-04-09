%% main HMMexercise
% testing HMM in a simple case, ML decisions

% we have two values of observation 1 or 2
% there are two hidden states, forming a HMM
% for each sample, we make an observation 
% for a set of observations, calculate the most probable sequence of states


% Construct HMM using generateMarkov(alpha, beta, Length)
%   createMarkov should be generalized to N-dimensions and not only 2
% define new function: generateObservation(StateProb)

len = 10; % performance independent of length
lim = 1000;

alpha = 0.1;
beta = 0.1;
e1 = 0.99;
e2 = 0.97;

P = [1-alpha alpha; beta 1-beta]; % transition matrix
E = [e1 1-e1; 1-e2 e2]; % emission matrix

p = [beta/(alpha+beta) alpha/(alpha+beta)]; % stationary distribution for 2 state Markov-1 source

states = [0 1];
key = [1 -1];
index = [1 2];


for i = 1:lim

% generate sequence and observations
[seq, obs] = generateMarkov(P, E, len);

% decode using viterbi algorithm
decoded = viterbi(forwardHMM(obs, p, P, E, key, index), index, states);

errors(i) = sum(xor(decoded,seq)); % depends on how correlated the emissions are to the states

end

meanerror = mean(errors)/len % converges to 0.1 for alpha = 0.2; beta = 0.4; e1 = 0.9; e2 = 0.1;