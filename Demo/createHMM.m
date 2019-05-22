function hmm = createHMM(workingDir,recordingDir,nStates,pD)

winsize = (2*10^(-2));
fs = 44100;
A = 440;

audio = classRead(workingDir,recordingDir); % maybe replace with 'workingDir, 'list of music dirs'
features = extract(audio,fs,winsize,A); % perhaps add option to choose extractor

%% Concatenate all feature vectors
% to be used in HMM training

featureLong = [];
L = size(features,1);
for i = 1:L
    featureLengths(i) = size(features{i},2);% correct
    featureLong = [featureLong features{i}];
end
featureLength = sum(featureLengths);
%featureLong = featureLong(1,:); % for discrete case
%%

hmm=MakeLeftRightHMM(nStates,pD,featureLong,featureLengths); 
% scalar version works for discrete output distribution.


end

