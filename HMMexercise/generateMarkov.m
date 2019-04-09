function [sequence, observation] = generateMarkov(P, E, seqlength)
% Hilding Wollbo 2019
% returns a Markov-1 source bitstream of length seqlength for a given
% transition matrix P and observations of length seqlength for a given
% emission matrix E

sequence = zeros(seqlength,1);
observation = sequence;

states = [0 1]; % corresponding to 0 1

% stationary distribution [(alpha/(alpha+beta), (beta/(alpha+beta)] )
init = rand(1); 
if init < P(1,1)
    sequence(1) = 0;
else
    sequence(1) = 1;
end
stateIndex = sequence(1)+1; % 1 or 2 used as index
observation(1) = generateObservation(E(stateIndex,:));

for i = 2:seqlength
    r = rand(1,1);
    if r < P(stateIndex,stateIndex) % get index and map to states(index)
        sequence(i) = states(stateIndex);
    else
        stateIndex = mod(stateIndex, length(states))+1; % key
        sequence(i) = states(stateIndex);
    end
    observation(i) = generateObservation(E(stateIndex,:));
end

