
%% Main script
% add ML-1 and all subfolders as path

gaussian = GaussD('Mean', 600, 'StDev', 10); % quite arbitrary, doesn't really affect the result
pD = [gaussian; gaussian]; 
recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'});
states = [7 7 6 8 8 5 7 8 8 9]; % by manual inspection of features

avgN = 50;
acc = zeros(avgN,1);
errorMatr = zeros(length(recNames),avgN);
for j = 1:avgN
for i = 1:length(recNames)
    shuffle(char(recNames(i)),1)
    hmm(i) = createHMM('Demo',char(recNames(i)),states(i),pD);
end
[acc(j),recErrors] = evaluateHMM(hmm,recNames,fs,winsize,A);
errorMatr(:,j) = recErrors;
end
mean(acc)
%% Evaluation
% load test files/features

%audio = classRead('Demo', [char(recNames(10))]);
%works perfectly if you test on training data, so there shouldn't be
%anything fundamentally wrong with the code
%conclusion: needs more training data and better initialization
%for testing on training data: it differs ~ 0.3*10e+03 between probability for the correct one and the other
%alternatives.
%a optimally trained classifier should be in the same area

%%

winsize = (2*10^(-2));
fs = 44100;
A = 440;
[accuracy,recErrors] = evaluateHMM(hmm,recNames,fs,winsize,A);

%%
%recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'});
audio = classRead('Demo', ['/test/', char(recNames(7))]); % big improvement with more recordings: need more 'rasputin', 'hips', 'grace' especially to improve marginals!
features = extract(audio,fs,winsize,A);
probs = hmm.logprob(features{1}) % write code to figure out how close the correct answer is to the chosen one, also how close it was to make an error
[~, index] = max(hmm.logprob(features{1}));
disp(char(recNames(index))) % observation: the correct answer is often among the most likely, and never the least likely. This is good.

% write function to play chosen song, and display top three
% alternatives/ranked list of most probable alternatives.


% consider changing init distributions, evaluate number of states and -->
% only seems to depend on the number of recordings!
% choice of extractor --> continuous seems to be the only alternative!
% fix continuous extractor --> seems to be fine!

%% This part is just debugging
% add ML-1 and all subfolders as path

winsize = (2*10^(-2));
fs = 44100;
A = 440;


%% Written in createHMM
% input: workingDir, 'dirName', nStates

% update 'workingDir' dynamically
% currently requires to be run from ML-1
audio = classRead('Demo','vindarna'); % maybe replace with 'workingDir, 'list of music dirs'
% this raw audio file has different lengths for different recordings
%%
L = size(audio,1);
features = cell(L,1);
for i = 1:L
    matr = GetMusicFeatures(audio{i},fs,winsize);
    features{i} = featureExtractDiscrete(matr,A); % continuous sometimes produces imaginary numbers?
end

%% Concatenate all feature vectors
% to be used in HMM training

% problematic that features are the same length for different length recordings
% check feature extractor but most importantly GetMusicFeatures!
% --> fixed in classRead and extract process
% reshape only works for consistent number of elements I think
% featureLong = reshape(features,size(features,1),size(features,2)*size(features,3));
featureLong = [];
for i = 1:L
    featureLengths(i) = size(features{i},2);% correct
    featureLong = [featureLong features{i}];
    % lxT(r)= length of r:th training sequence.
    % sum(lxT) == size(obsData,2)
end
featureLength = sum(featureLengths);

%%

gaussian = GaussD('Mean', 600, 'StDev', 10);
%L = 1200;
%uniform = 1/L * ones(1,L); 
%discrete = [DiscreteD(uniform)]; 

% error in DiscreteD, can't init with vector components! strange
% this could mean that I have to use gaussian as observation probabilities
% regardless of feature extractor...

nStates = 12;
pD = [gaussian; gaussian]; % depending on feature extractor :(
hmm=MakeLeftRightHMM(nStates,pD,[featureLong(1,:); featureLong(2,:)],featureLengths); 
% scalar version works for discrete output distribution.
% initial pD doesn't seem to affect very much for gaussian case
% not sensitive to mean and stDev- choose quite generally

%also test 2-GMM as init dist


%% OLD

% L = 1200;
% uniform = 1/L * ones(1,L); 
% discrete = DiscreteD(uniform); 

% should be external argument
% use domain specific knowledge of GMM distribution
% look at features from test!

%gaussian = GaussD('Mean', 600, 'StDev', 20);
%pD = [gaussian; gaussian];% needs to be gaussian for init dist

%make matrix of GMM's, use one unique GMM for each component.

% error in DiscreteD, can't init with vector components! strange
% this could mean that I have to use gaussian as observation probabilities
% regardless of feature extractor...

