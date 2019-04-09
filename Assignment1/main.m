%% A.1.2 %%

addpath PattRecClasses

% init
q = [0.75;0.25];
A = [0.99 0.01;0.03 0.97];
mu = [0 3];
sigma = [1 2];
B = [GaussD("Mean", mu(1), "Variance", sigma(1));GaussD("Mean", mu(2), "Variance", sigma(2))];
T = 10000;

%% 2.

mc = MarkovChain(q, A);
s = zeros(1,100);
for i = 1:10
    S = mc.rand(T);
    s(i) = sum(S==1); %seems ok, ~75 % of the time "1"
end
mean(s)
sD = mc.stationaryDist
%% 3.

M = 25;
h = HMM(mc, B); 
xm = zeros(1,M);
xv = xm;
for i = 1:M
    [X,S] = h.rand(T); % seems ok, again S ~75 % of the time "1"
    xm(i) = mean(X); % ~0.75 = 3*0.25 = mu2*q2 (mu1 = 0!)
    xv(i) = var(X); % ~3 = sigma1+sigma2
end
mean(xm)
mean(xv)

%% 4. 

ht = HMM(mc,B);
U = 500;
for i =1:U
    [X,~] = ht.rand(U);
end

plot(1:1:U,X)
xlabel('t')
ylabel('HMM output X(t)')
title('HMM output with 500 samples')
% Tydliga trender i upp- och nedmod. Även om den är brusig så går det att
% se tydliga mönster

%% 5.

% mc same as before, B changes

mu = [0 0];
sigma = [1 2];
Bnew = [GaussD("Mean", mu(1), "Variance", sigma(1));GaussD("Mean", mu(2), "Variance", sigma(2))];

htnew = HMM(mc,Bnew);
V = 500;
for i =1:V
    [X,~] = htnew.rand(V);
end
plot(1:1:V,X)
xlabel('t')
ylabel('HMM output X(t)')
title('HMM output with 500 samples, mu = 0')

% it is still possible to identify section with higher variance, but the
% zero mean makes this very very hard to do reliably. A distinct difference
% in mean is needed if we want to distinguish state outputs!

%% 6. test for finite duration - check S =< U

Anew = [0.98 0.01 0.01;0.03 0.96 0.01];
mcfin = MarkovChain(q, Anew);
hfin = HMM(mcfin,B);
U = 1000;
for i =1:U
    [X,S] = hfin.rand(U);
end
length(S)

%% 7. test for vector valued output in HMM, i.e. B --> covariance matrix

sigma1 = 3;
sigma2 = 1;
sigma3 = sqrt(2);

C1 = [sigma1 0;0 sigma2];
C2 = [sigma1 sigma3;sigma3 sigma1];

mu1 = [0; 2];
mu2 = [3; 6];

Bvec = [GaussD("Mean", mu1, "Covariance", C1);GaussD("Mean", mu2, "Covariance", C2)];

mc = MarkovChain(q, A);
hmvec = HMM(mc, Bvec);
hmvec.rand(100)

