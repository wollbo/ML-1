function quantized = logQuantize(feature,ratio)

% Hilding Wollbo 2019

% perfoms logarithimical quantization
% with the ratio 'ratio' between two consecutive intervals

freqLow = floor(min(feature));
if freqLow == 0
    feature = feature./min(feature);
    freqLow = 1;
end
freqHigh = ceil(max(feature));

freq = 0;
i = 1;
freq(i) = freqLow;
while freq(end) < freqHigh 
    i = i+1;
    freq(i) = freq(i-1)*ratio;
end

quantized = zeros(1,length(feature));
for i = 1:length(feature)
    [~,minIndex] = min(abs(feature(i)-freq));
    quantized(i) = freq(minIndex);
end