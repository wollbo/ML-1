function features = extract(audio,fs,window,normal)
% this should perhaps produce one long feature vector and its respective
% sub length instead of a "ugly" matrix
for i = 1:size(audio,2)
    matr = GetMusicFeatures(audio(:,i),fs,window);
    fMat(1:size(matr,1),1:size(matr,2),i) = matr; 
    featurei = featureExtractDiscrete(fMat(:,:,i),normal); % continuous sometimes produces imaginary numbers?
    features(1:size(featurei,1),1:size(featurei,2),i) = featurei;
end
end

%%

% featureLong = reshape(features,size(features,1),size(features,2)*size(features,3)); 
% for i = 1:size(features,3)
%     feat = features(:,:,i);
%     featureLengths(i) = size(feat,2); % correct
%     % lxT(r)= length of r:th training sequence.
%     % sum(lxT) == size(obsData,2)
% end