% test2
winsize = (2*10^(-2));
fs = 44100;
A = 440;


recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'});

for i = 1:10
    audio{i} = classRead('Demo', ['/test/', char(recNames(i))]);
end

%%

features = extract(audio{2},fs,winsize,A);
plot(1:length(features{1}(1,:)), features{1}(1,:), 1:length(features{1}(1,:)), features{1}(2,:))

%%

% test for 'uti' GMM --> This doesn't work since feeding pD to createHMM
% will create a hmm with the output distribution GMM for each state!
nStates = 7;
gaussians = [];
meanVec = [545 564 574 557 588 605 1000]; % can be saved in larger cell structure
varVec = [1 4 3 2 3 3 10]; % 
weightVec = [2 5 2 1 3 1 3]; %
for i = 1:nStates
    gaussians = [gaussians;GaussD('Mean', meanVec(i), 'StDev', sqrt(varVec(i)))];
end
weights = weightVec./sum(weightVec);
pD = GaussMixD(gaussians,weights);


%%
% create HMM and compare with arbitrary init of pD

audioTest = classRead('Demo', ['/test/', char(recNames(2))]);
testFeatures = extract(audioTest,fs,winsize,A);

gauss1 = GaussD('Mean', 600, 'StDev', 100);
gauss2 = GaussD('Mean', 440, 'StDev', 100);

hmm1 = createHMM('Demo', char(recNames(2)), nStates, [gauss1;gauss1]); 
hmm2 = createHMM('Demo', char(recNames(2)), nStates, [gauss2;gauss2]);

%%

hmm = [hmm1;hmm2];
[~,indices] = max(hmm.logprob(testFeatures{1}))

