function features = extract(audio,fs,window,normal)
% perhaps allow choice of continuous and discrete extractor
L = size(audio,1);
features = cell(L,1);
for i = 1:L
    matr = GetMusicFeatures(audio{i},fs,window);
    features{i} = featureExtractContinuous(matr,normal); % continuous sometimes produces imaginary numbers?
end
end

%%

%