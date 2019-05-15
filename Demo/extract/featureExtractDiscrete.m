function features = featureExtractDiscrete(featureMatrix,normal,ratio)

% Hilding Wollbo 2019

pitch = featureMatrix(1,:);
rho = featureMatrix(2,:);
intensity = featureMatrix(3,:);

% (optional) logarithimical quantization
if nargin > 2 
    pitch = logQuantize(pitch,ratio);
end

rfreq = log(pitch);

% normalization
delta = 0.75;
meani = 0;
for i = 1:length(rho)
    if rho(i) > delta && intensity(i) > mean(intensity)-2*sqrt(var(intensity))
        meani = [meani i];
    else
        rfreq(i) = ceil(max(rfreq));
    end
end

rmean = sum(rfreq(meani(2:end)))/length(meani(2:end));
rfreq = rfreq-rmean;
features = round(100.*[(rfreq+log(normal)); log(1000.*intensity./min(intensity))]);

end
