addpath D:\MATLAB\Repos\ML-1\PattRecClasses

folder = 'D:\MATLAB\Repos\ML-1\Demo\melodies'
noFiles = dir(fullfile(folder,'*.wav'))
for i = 1:noFiles
    songs = audioread('melodies/wav/' + i)
end

winsize = (2*10^(-2));
fs = 44100;
A = 440;

for i = 1:
features(:,:,i) = featureExtractContinuous(featureMatrix1,A);





gaussian = GaussD('Mean', 0, 'StDev', 1);

nStates = 16;
pD = gaussian;
obsData = a1;

hmm=MakeLeftRightHMM(nStates,pD,features1);