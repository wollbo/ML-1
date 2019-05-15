% addpath D:/MATLAB/Repos/ML-1/PattRecClasses
% addpath melodies
% addpath GetMusicFeatures


winsize = (2*10^(-2));
fs = 44100;
A = 440;


% update 'workingDir' dynamically
audio = classRead('Demo','uti'); % maybe replace with 'workingDir, 'list of music dirs'

for i = 1:size(audio,2)
    matr = GetMusicFeatures(audio(:,i),fs,winsize);
    fMat(1:size(matr,1),1:size(matr,2),i) = matr; 
    feature = featureExtractDiscrete(fMat(:,:,i),A); % continuous sometimes produces imaginary numbers?
    features(1:size(feature,1),1:size(feature,2),i) = feature;
end

%%


gaussian = GaussD('Mean', A, 'StDev', 10);
nStates = 16;
pD = gaussian;

features

hmm=MakeLeftRightHMM(nStates,pD,features);