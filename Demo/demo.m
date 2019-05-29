%% Run main first to create HMM's

% init
winsize = (2*10^(-2));
fs = 44100;
A = 440;

% record some songs and put them in the folder /demo/
% run from the directory ML-1 
audio = classRead('Demo', '/demo/');

% show features
features = extract(audio,fs,winsize,A);

% classify using hmm's
% play real version of chosen song/show picture of album