addpath PattRecClasses

q = [1; 0];
A = [0.9 0.1 0; 0 0.9 0.1];

mc = MarkovChain(q,A);
x = [-0.2 2.6 1.3];

T = length(x);
N = size(A,1);

mu1 = 0;
mu2 = 3;

sigma1 = 1;
sigma2 = 2;

g1 = GaussD("Mean", mu1, "StDev", sigma1);
g2 = GaussD("Mean", mu2, "StDev", sigma2);

hmm = HMM(mc,[g1 g2]);

probX=hmm.OutputDistr.prob(x);

%%

[alfaHat, c] = mc.forward(probX);

%%

[betaHat] = mc.backward(probX,c);