%% Run main first to create HMM's

hmmStruct = load('trainedhmm3.mat');
hmm = hmmStruct.hmm;

% init
winsize = (2*10^(-2));
fs = 44100;
A = 440;
recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'});

% record some songs live and put them in the folder /demo/
% run from the directory ML-1 
% audio = classRead('Demo', '/demo/'); % should be recorded to data structure immediately

% OR 

% run from terminal:
% r = audiorecorder(fs/2, 16, 1);
% record(r);     % hum into microphone...
% stop(r);
% p = play(r);   % listen to complete recording
% audio = getaudiodata(r, 'int16');
% audioC = cell(1,1)
% audioC{1} = audio

%% show features
% 
features = extract(audioC,fs,winsize,A);
plot(features{1}(1,:))

%% Evaluation
% classify using hmm's


probs = hmm.logprob(features{1});
[M, index] = max(hmm.logprob(features{1}));
maxVec = NaN(1,length(probs));
maxVec(index) = M;
stem(probs)
set(gca,'xticklabel',recNames.');
hold on
stem(maxVec,'r')
set(gca,'xticklabel',recNames.');
hold off
disp(char(recNames(index)))
