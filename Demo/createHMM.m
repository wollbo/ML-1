function hmm = createHMM(workingDir,recordingDir,nStates)

winsize = (2*10^(-2));
fs = 44100;
A = 440;

audio = classRead(workingDir,recordingDir); % maybe replace with 'workingDir, 'list of music dirs'

% for i = 1:size(audio,2)
%     matr = GetMusicFeatures(audio(:,i),fs,winsize);
%     fMat(1:size(matr,1),1:size(matr,2),i) = matr; 
%     featurei = featureExtractDiscrete(fMat(:,:,i),A); % continuous sometimes produces imaginary numbers?
%     features(1:size(featurei,1),1:size(featurei,2),i) = featurei;
% end

features = extract(audio,fs,winsize,A);
% features = features(1,:,:); % discrete output distr only works with one
% feature

%% Concatenate all feature vectors
% to be used in HMM training

% problematic that features are the same length for different length recordings
% check feature extractor but most importantly GetMusicFeatures!
% reshape only works for consistent number of elements I think
featureLong = reshape(features,size(features,1),size(features,2)*size(features,3)); 
for i = 1:size(features,3)
    feat = features(:,:,i);
    featureLengths(i) = size(feat,2); % correct
    % lxT(r)= length of r:th training sequence.
    % sum(lxT) == size(obsData,2)
end

%%

% L = 1200;
% uniform = 1/L * ones(1,L); 
% discrete = DiscreteD(uniform); 
% pD = discrete;

% error in DiscreteD, can't init with vector components! strange
% this could mean that I have to use gaussian as observation probabilities
% regardless of feature extractor...


gaussian = GaussD('Mean', A, 'StDev', 10);
pD = [gaussian; gaussian];% depending on feature extractor :(

%%


hmm=MakeLeftRightHMM(nStates,pD,featureLong,featureLengths); 
% scalar version works for discrete output distribution.



end

