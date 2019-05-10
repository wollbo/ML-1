%% infinite duration test
% Problem 5.1 in the book

Ainf = [0.3 0.7 0;0 0.5 0.5;0 0 1];
q = [1;0;0];

mcInf = MarkovChain(q,Ainf);
z = [1 2 4 4 1];

d1 = DiscreteD([1 0 0 0]);
d2 = DiscreteD([0 0.5 0.4 0.1]);
d3 = DiscreteD([0.1 0.1 0.2 0.6]);

hmmInf = HMM(mcInf,[d1;d2;d3]);
probZ = hmmInf.OutputDistr.prob(z);

% note that dim(cInf) = dim(x)
[alfaHatInf, cInf] = hmmInf.StateGen.forward(probZ)
hmmInf.logprob(z)

