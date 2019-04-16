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

M = 25;
mc = MarkovChain(q, A);
svec = zeros(2,M);
s1 = 0;
s2 = s1;
for i = 1:M
    S = mc.rand(T);
    s1 = s1 + sum(S==1);
    s2 = s2 + T-sum(S==1);
    svec(:,i) =[s1 s2]./i;
end
snorm = svec./T;
f2 = figure('Name', 'figures/runningAverageStateProb');
plot(1:M, snorm(1,:), 1:M, snorm(2,:))
axis([1 M 0 1])
legend('State1', 'State2')
xlabel('Number of iterations')
ylabel('State probability')
title('Running Average State Probability')
%mean(s)
%sD = mc.stationaryDist
%% 3.

mc = MarkovChain(q, A);
M = 100;
h = HMM(mc, B); 
xvec = zeros(2,M);
xm = 0;
xv = xm;
for i = 1:M
    [X,~] = h.rand(T); % seems ok, again S ~75 % of the time "1"
    %xm(i) = mean(X); %~ ~0.75 = 3*0.25 = mu2*q2 (mu1 = 0!)
    %xv(i) = var(X); % ~3 = sigma1+sigma2 NO
    xm = xm + mean(X);
    xv = xv + var(X);
    xvec(:,i) =[xm xv]./i;
end


f3 = figure('Name', 'figures/runningAverageMeanVariance');
plot(1:M, xvec(1,:), 1:M, xvec(2,:))
legend('Mean', 'Variance')
xlabel('Number of iterations')
ylabel('Running Averages')
title('Running Average of first and second moment')

%% 4. 

ht = HMM(mc,B);
U = 500;

[X,S] = ht.rand(U);

f4 = figure('Name', 'figures/hmmOutput1');
plot(1:1:U,X,1:1:U,S,'-.')
xlabel('t')
ylabel('HMM output X(t)')
title('HMM output with 500 samples')
legend('HMM output', 'True state')
% Tydliga trender i upp- och nedmod. Även om den är brusig så går det att
% se tydliga mönster

%% 5.

% mc same as before, B changes

mu = [0 0];
Bnew = [GaussD("Mean", mu(1), "Variance", sigma(1));GaussD("Mean", mu(2), "Variance", sigma(2))];

htnew = HMM(mc,Bnew);
V = 500;

[X,S] = htnew.rand(V);

f5 = figure('Name', 'figures/hmmOutput2');
plot(1:1:V,X,1:1:V,S, '-.')
xlabel('t')
ylabel('HMM output X(t)')
title('HMM output with 500 samples, mu = 0')
legend('HMM output', 'True state')

% it is still possible to identify some sections with higher variance, but the
% zero mean makes this very very hard to do reliably. A distinct difference
% in mean is needed if we want to distinguish state outputs!

%% 6. test for finite duration - check S =< U

Anew = [0.97 0.01 0.02;0.03 0.93 0.04]; % ->~100 samples average length
mcfin = MarkovChain(q, Anew);
hfin = HMM(mcfin,B);
U = 10000;
N = 1000;

s = zeros(1,N);
for i = 1:N
    [~,S] = hfin.rand(U);
    s(i) = length(S);
end
mean(s)
t = (eye(2)-Anew(:,1:2))\[1;1];
q'*t

%% 7. test for vector valued output in HMM, i.e. B --> covariance matrix

L = 10000;

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

[X,S] = hmvec.rand(L);

i = 1:length(S);
S1 = i(S==1);
S2 = i(S==2);
f7 = figure('Name', 'figures/gaussianVectorOutput');
plot3(X(1,S1), X(2,S1),zeros(1,length(S1)), '.',X(1,S2), X(2,S2),zeros(1,length(S2)), '.')
view(2)
title('HMM output for 10000 samples')
legend('True State (1)', 'True State (2)')

%%

printToPdf(f2)
printToPdf(f3)
printToPdf(f4)
printToPdf(f5)
printToPdf(f7)
