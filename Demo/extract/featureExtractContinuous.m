function features = featureExtractContinuous(featureMatrix,normal)

% Hilding Wollbo 2019

pitch = featureMatrix(1,:);
rho = featureMatrix(2,:);
intensity = featureMatrix(3,:);

rfreq = log(pitch(1,:));

% normalization
delta = 0.75;
meani = 0; % temporary solution
for i = 1:length(rho)
    if rho(i) > delta && intensity(i) > mean(intensity)-2*sqrt(var(intensity))
        meani = [meani i];
    end
end

% for stability purposes
epsilon1 = 1/1000*(sqrt(var(rfreq)));
epsilon2 = 1/1000*(sqrt(var(intensity)));
for i = 1:size(featureMatrix,2)-1
    if rfreq(i+1) == rfreq(i)
        rfreq(i+1) = rfreq(i+1)+epsilon1*randn(1,1);
    elseif intensity(i+1) == intensity(i)
        intensity(i+1) = intensity(i+1)+epsilon2*randn(1,1);
    end
end

rmean = sum(rfreq(meani(2:end)))/length(meani(2:end));
rfreq = rfreq-rmean;

features = 100.*[(rfreq+log(normal)); log(1000.*intensity./min(intensity))];

end

