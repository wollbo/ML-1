%% test
%% own produced melodies

v2 = audioread('melodies/vindarnaviskar/1.wma');
a1 = audioread('melodies/astralhammer/1.wma');
f10 = audioread('melodies/finland/8.wma');

addpath GetMusicFeatures

fs = 44100;
A = 440;
twelveRatio = 2^(1/12);

winsize = (2*10^(-2));

featureMatrix1 = GetMusicFeatures(a1,fs,winsize);
featureMatrix2 = GetMusicFeatures(v2,fs,winsize);
featureMatrix3 = GetMusicFeatures(f10,fs,winsize);


%%

features1 = featureExtractDiscrete(featureMatrix1,A);

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