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

gaussian = GaussD('Mean', A, 'StDev', 2);
%L = 1200;
%uniform = 1/L * ones(1,L); 
%discrete = [DiscreteD(uniform)]; 

% error in DiscreteD, can't init with vector components! strange
% this could mean that I have to use gaussian as observation probabilities
% regardless of feature extractor...

nStates = 6;
pD = [gaussian; gaussian]; % depending on feature extractor :(
hmm=MakeLeftRightHMM(nStates,pD,[featureLong(1,:); featureLong(2,:)],featureLengths); 
% scalar version works for discrete output distribution.

%% Main script
%

recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'});

for i = 1:length(recNames)
    hmm(i) = createHMM('Demo',char(recNames(i)),12);
end

%%
% load test files/features

 audio = classRead('Demo', ['test/' char(recNames(10))]);
 features = extract(audio{1},fs,winsize,A);
 %features = features(1,:); for discrete case
 
 
 hmm.logprob(features)
 % could be because constant length features in training, shouldn't happen!
 % could also be due to gaussD init with discrete extractor. try
 % Re(continuous) ...