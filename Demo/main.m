% add ML-1 and all subfolders as path

winsize = (2*10^(-2));
fs = 44100;
A = 440;


%% Could be written as a big function 
% input: workingDir, 'dirName', nStates, extractor

% update 'workingDir' dynamically
% currently requires to be run from ML-1
audio = classRead('Demo','uti'); % maybe replace with 'workingDir, 'list of music dirs'

for i = 1:size(audio,2)
    matr = GetMusicFeatures(audio(:,i),fs,winsize);
    fMat(1:size(matr,1),1:size(matr,2),i) = matr; 
    featurei = featureExtractDiscrete(fMat(:,:,i),A); % continuous sometimes produces imaginary numbers?
    features(1:size(featurei,1),1:size(featurei,2),i) = featurei;
end

%% Concatenate all feature vectors
% to be used in HMM training

% problematic that features are the same length for different length recordings
% check feature extractor but most importantly GetMusicFeatures!
% reshape only works for consistent number of elements I think
featureLong = reshape(features,size(features,1),size(features,2)*size(features,3)); 
for i = 1:size(features,3)
    feat = features(:,:,i);
    featureLengths(i) = size(feat,2);
end
%%

gaussian = GaussD('Mean', A, 'StDev', 10);
nStates = 12;
pD = gaussian; % depending on feature extractor
hmm=MakeLeftRightHMM(nStates,pD,featureLong(1,:),featureLengths); 
% check MakeLeftRightHMM for vector observation input 'not enough data'


