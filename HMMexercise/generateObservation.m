function observation = generateObservation(emissionProbabilities)

% takes as argument a binary probability
% outputs an observation (-1 or 1)

r = rand(1);
if (r < emissionProbabilities(1))
    observation = 1;
else
    observation = -1;

end

