function accuracy = evaluateHMM(hmm,recNames,fs,window,normal)

accuracy = [];
for i = 1:length(recNames) %not general for more than one recording in each test
    audio = classRead('Demo', ['/test/', char(recNames(i))]); % big improvement with more recordings: need more 'rasputin', 'hips', 'grace' especially to improve marginals!
    features = extract(audio,fs,window,normal); % possibly, use something other than extract for this function
    probs(i,:) = hmm.logprob(features{1}); % write code to figure out how close the correct answer is to the chosen one, also how close it was to make an error
    [~, index] = max(hmm.logprob(features{1}));
    if recNames(i) == recNames(index)
        accuracy = [accuracy; 1];
    else
        accuracy = [accuracy; 0];
    end
end
accuracy = sum(accuracy)./length(accuracy);