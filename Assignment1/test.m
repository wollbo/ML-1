%% test
% test for finite duration mc
addpath PattRecClasses

q = [0.75;0.25];
A = [0.5 0.01 0.49;0.01 0.5 0.49];
mu = [0 3];
sigma = [1 2];
B = [GaussD("Mean", mu(1), "Variance", sigma(1));GaussD("Mean", mu(2), "Variance", sigma(2))];
T = 10000;


mc = MarkovChain(q,A);
hm = HMM(mc,B);

nS = hm.StateGen.nStates; % 2 states, also an endstate

%S = mc.rand(T) works for finite duration

[X,S] = hm.rand(T); % works for finite duration!

