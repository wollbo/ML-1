m1 = audioread('songs/melody_1.wav');
m2 = audioread('songs/melody_2.wav');
m3 = audioread('songs/melody_3.wav');

addpath GetMusicFeatures

fs = 44100;
A = 440;
twelveRatio = 2^(1/12);

winsize = (2*10^(-2));

featureMatrix1 = GetMusicFeatures(m1,fs,winsize);
featureMatrix2 = GetMusicFeatures(m2,fs,winsize); % does not have the distinct silence peaks of the other two
featureMatrix3 = GetMusicFeatures(m3,fs,winsize);

%% Pitch Profile of the melodies

f1 = figure('Name','figures/pitchProfiles')
subplot(1,3,1), plot(featureMatrix1(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')
subplot(1,3,2), plot(featureMatrix2(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')
subplot(1,3,3), plot(featureMatrix3(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

%% Intensity Profile of the Melodies

f2 = figure('Name','figures/intensityProfiles')
subplot(1,3,1), plot(featureMatrix1(3,:)) 
ylabel('RMS Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')
subplot(1,3,2), plot(featureMatrix2(3,:))
ylabel('RMS Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')
subplot(1,3,3), plot(featureMatrix3(3,:))
ylabel('RMS Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

%% Features from continuous feature extractor

feat1C = featureExtractContinuous(featureMatrix1,A);
feat2C = featureExtractContinuous(featureMatrix2,A);
feat3C = featureExtractContinuous(featureMatrix3,A);

f3 = figure('Name','figures/pitchFeaturesC')
subplot(1,3,1), plot(feat1C(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')
subplot(1,3,2), plot(feat2C(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')
subplot(1,3,3), plot(feat3C(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

%%

f4 = figure('Name','figures/intensityFeaturesC')
subplot(1,3,1), plot(feat1C(2,:)) 
ylabel('Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')
subplot(1,3,2), plot(feat2C(2,:))
ylabel('Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')
subplot(1,3,3), plot(feat3C(2,:))
ylabel('Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

%% Features from discrete feature extractor

feat1D = featureExtractDiscrete(featureMatrix1,A);
feat2D = featureExtractDiscrete(featureMatrix2,A);
feat3D = featureExtractDiscrete(featureMatrix3,A);

f5 = figure('Name','figures/pitchFeaturesD')
subplot(1,3,1), plot(feat1C(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')
subplot(1,3,2), plot(feat2C(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')
subplot(1,3,3), plot(feat3C(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

%%

f6 = figure('Name','figures/intensityFeaturesD')
subplot(1,3,1), plot(feat1D(2,:)) 
ylabel('Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 1')
subplot(1,3,2), plot(feat2D(2,:))
ylabel('Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 2')
subplot(1,3,3), plot(feat3D(2,:))
ylabel('Intensity')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Melody 3')

%% Transposition comparison

s = 1.5;

featureMatrixT = featureMatrix1;
featureMatrixT(1,:) = s.*featureMatrixT(1,:);
feat1Dtransp = featureExtractDiscrete(featureMatrixT,A);

f7 = figure('Name','figures/pitchTranspositionComparison')
subplot(1,2,1), plot(feat1D(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
title('Melody 1')
subplot(1,2,2), plot(feat1Dtransp(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
title('Melody 1 transposed')

%% Logarithmic quantization comparison

feat1DQ = featureExtractDiscrete(featureMatrix1,A,twelveRatio);

f8 = figure('Name','figures/pitchFeaturesDlogquant')
subplot(1,2,1), plot(feat1D(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Discrete')
subplot(1,2,2), plot(feat1DQ(1,:))
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Discrete Logarithmical Quantization')

%% Compare Cont and Disc

f9 = figure('Name','figures/pitchComparisonCD')
subplot(1,2,1), plot(feat1C(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Continuous')
subplot(1,2,2), plot(feat1D(1,:)) 
ylabel('Frequency [Hz]')
xlabel('Window')
set(gca, 'YScale', 'log')
title('Discrete')



%% 

printToPdf(f1)
printToPdf(f2)
printToPdf(f3)
printToPdf(f4)
printToPdf(f5)
printToPdf(f6)
printToPdf(f7)
printToPdf(f8)
printToPdf(f9)