function features = featureExtractD(featureMatrix,ratio,normal)

% performs logarithmic quantization of featureMatrix, with approximately
% constant ratio between two consecutive indices
% should also normalize

if (nargin < 3) || isempty(normal)
    normal = 1; % used for frequency normalization
end

freqLow = floor(min(featureMatrix));
if freqLow == 0
    featureMatrix = featureMatrix./min(featureMatrix);
    freqLow = 1;
end
if round(freqLow*ratio) == round(freqLow*ratio^2)
    while round(freqLow) == round(freqLow*ratio)
        ratio = ratio^2;
    end
end
freqHigh = ceil(max(featureMatrix));

freq = 0;
i = 1;
freq(i) = freqLow;
while freq(end) < freqHigh % can become stuck if ratio is too low relative to freq(1)
    i = i+1;
    freq(i) = round(freq(i-1)*ratio); %round for DiscreteD %could be removed if we normalize afterwards
end

for i = 1:length(featureMatrix)
    [~,minIndex] = min(abs(featureMatrix(i)-freq));
    cfreq(i) = freq(minIndex);
end

if (nargin < 3) || isempty(normal) % should probably be if nargin == 3 then normalize
    normal = 1; % used for frequency normalization
end

% we want to produce the same features for transposed but otherwise identical melodies
features = cfreq; %log(cfreq)+log(normal)-log(mean(cfreq)); 

% this normalization should also perhaps be performed only over areas where rho >
% delta and medium-low intensity


end

