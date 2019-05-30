%% Run main first to create HMM's

% init
winsize = (2*10^(-2));
fs = 44100;
A = 440;
recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'}); %#ok<STRCLQT>

% record some songs live and put them in the folder /demo/
% run from the directory ML-1 
audio = classRead('Demo', '/demo/'); % should be recorded to data structure immediately

% run from terminal:
% r = audiorecorder(22050, 16, 1);
% record(r);     % hum into microphone...
% stop(r);
% p = play(r);   % listen to complete recording
% audio = getaudiodata(r, 'int16');

%% show features
% 
features = extract(audio,fs,winsize,A);
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

%% play real version of chosen song/show picture of album


