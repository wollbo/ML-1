%% test
%% own produced melodies

a1 = audioread('melodies/wav/hips/1.wav');
v1 = audioread('melodies/wav/summer/1.wav');
f1 = audioread('melodies/wav/uti/1.wav');

addpath GetMusicFeatures
winsize = (2*10^(-2));
fs = 44100;
A = 440;
twelveRatio = 2^(1/12);


featureMatrix1 = GetMusicFeatures(a1,fs,winsize);
featureMatrix2 = GetMusicFeatures(v1,fs,winsize);
featureMatrix3 = GetMusicFeatures(f1,fs,winsize);


%%

features1 = featureExtractContinuous(featureMatrix1,A);

fig1 = figure(1)
plot(features1(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')

%%

features2 = featureExtractContinuous(featureMatrix2,A);

fig2 = figure(2)
plot(features2(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')

%%

features3 = featureExtractContinuous(featureMatrix3,A);

fig3 = figure(3)
plot(features3(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

