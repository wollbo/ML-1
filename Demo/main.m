addpath D:/MATLAB/Repos/ML-1/PattRecClasses
addpath melodies
addpath GetMusicFeatures

% feed working dir to classRead

winsize = (2*10^(-2));
fs = 44100;

% update 'workingDir' dynamically
audio = classRead('Demo','uti'); % maybe replace with 'workingDir, 'list of music dirs'



%%

gaussian = GaussD('Mean', 0, 'StDev', 1);

nStates = 16;
pD = gaussian;
obsData = a1;

hmm=MakeLeftRightHMM(nStates,pD,features1);