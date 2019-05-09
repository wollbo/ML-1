%% infinite duration test

Ainf = [0.9 0.1;0.2 0.8];
q = [1;0];

mcInf = MarkovChain(q,Ainf);
x = [-0.2 2.6 1.3];

mu1 = 0;
mu2 = 3;

sigma1 = 1;
sigma2 = 2;

g1 = GaussD('Mean', mu1, 'StDev', sigma1);
g2 = GaussD('Mean', mu2, 'StDev', sigma2);

hmmInf = HMM(mcInf,[g1 g2]);
probXi = hmmInf.OutputDistr.prob(x);

% note that dim(cInf) = dim(x)
[alfaHatInf, cInf] = hmmInf.StateGen.forward(probXi) 

