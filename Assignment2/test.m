m1 = audioread('songs/melody_1.wav');
m2 = audioread('songs/melody_2.wav');
m3 = audioread('songs/melody_3.wav');

addpath GetMusicFeatures

fs = 44100;
L = length(m1);
A = 440;
twelveRatio = 2^(1/12);
fourRatio = 2^(1/4);

winsize = (2*10^(-2));

featureMatrix1 = GetMusicFeatures(m1,fs,winsize);
featureMatrix2 = GetMusicFeatures(m2,fs,winsize); % does not have the distinct silence peaks of the other two
featureMatrix3 = GetMusicFeatures(m3,fs,winsize);

%%

features1D = [featureExtractD(featureMatrix1(1,:), twelveRatio); featureExtractD(featureMatrix1(3,:), twelveRatio)];
features2D = [featureExtractD(featureMatrix2(1,:), twelveRatio); featureExtractD(featureMatrix2(3,:), twelveRatio)];

figure(1)
plot(1:length(features1D(1,:)), features1D(1,:), 1:length(features1D(1,:)), featureMatrix1(1,:)) 
%plot(1:length(features1D(2,:)), features1D(2,:), 1:length(features1D(1,:)), featureMatrix1(3,:)./min(featureMatrix1(3,:))) 

figure(2)
plot(1:length(features2D(1,:)), features2D(1,:), 1:length(features2D(1,:)), featureMatrix2(1,:)) 
%plot(1:length(features2D(2,:)), features2D(2,:), 1:length(features2D(1,:)), featureMatrix2(3,:)./min(featureMatrix2(3,:))) 
%set(gca, 'YScale', 'log')

%% 

feat1 = featureExtractDE(featureMatrix1, A, twelveRatio);
feat2 = featureExtractDE(featureMatrix2, A, twelveRatio);
figure(3)
plot(feat1(1,:))
hold on
plot(feat2(1,:))

%%

% each window corresponds to fs*winsize

subplot(1,3,1), plot(featureMatrix1(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
subplot(1,3,2), plot(featureMatrix2(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
subplot(1,3,3), plot(featureMatrix3(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')


%%
%Quantization for discrete distributions is solved
%next: try to get the same features from scaled melodies "insensitive to
%transposition" (while still retaining the characteristics of the melody)

featureMatrixS = featureMatrix1; featureMatrixS(1,:) = 2.*featureMatrixS(1,:);

featT1 = featureExtractExperimental(featureMatrix1,A);
featT1Scaled = featureExtractExperimental(featureMatrixS,A);
featT2 = featureExtractExperimental(featureMatrix2,A);

figure(1)
plot(featT1(1,:))
hold on
plot(featT1Scaled(1,:))
figure(2)
plot(featT2(1,:))

figure(3)
plot(featT1(2,:))
hold on
plot(featT1Scaled(2,:))
figure(4)
plot(featT2(2,:))


%%
signal1 = MusicFromFeatures(featureMatrix1,fs);
signal2 = MusicFromFeatures(featureMatrix2,fs);
signal3 = MusicFromFeatures(featureMatrix3,fs);

soundsc(signal1,fs)
