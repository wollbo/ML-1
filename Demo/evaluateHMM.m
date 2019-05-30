function [accuracy,recErrors] = evaluateHMM(hmm,recNames,fs,window,normal)

accuracy = [];
recErrors = zeros(length(recNames),1);
for i = 1:length(recNames) %not general for more than one recording in each test
    audio = classRead('Demo', ['/test/', char(recNames(i))]); % big improvement with more recordings: need more 'rasputin', 'hips','grace' especially to improve marginals!
    for j = 1:numel(audio)
        features = extract(audio(j),fs,window,normal); % possibly, use something other than extract for this function
        [~, index] = max(hmm.logprob(features{1}));
        if recNames(i) == recNames(index)
            accuracy = [accuracy; 1];
        else
            accuracy = [accuracy; 0];
            recErrors(i) = recErrors(i)+1;
        end
    end
end
accuracy = sum(accuracy)./length(accuracy);