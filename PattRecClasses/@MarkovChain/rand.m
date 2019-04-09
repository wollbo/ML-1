function S=rand(mc,T)
%S=rand(mc,T) returns a random state sequence from given MarkovChain object.
%
%Input:
%mc=    a single MarkovChain object
%T= scalar defining maximum length of desired state sequence.
%   An infinite-duration MarkovChain always generates sequence of length=T
%   A finite-duration MarkovChain may return shorter sequence,
%   if END state was reached before T samples.
%
%Result:
%S= integer row vector with random state sequence,
%   NOT INCLUDING the END state,
%   even if encountered within T samples
%If mc has INFINITE duration,
%   length(S) == T
%If mc has FINITE duration,
%   length(S) <= T
%
%---------------------------------------------
%Code Author: Hilding Wollbo 2019
%---------------------------------------------

% need to account for finite duration in TransitionProb-->ts

%If size(TransitionProb,2)=size(TransitionProb,1)+1, the MarkovChain can have FINITE duration,

S=zeros(1,T); %space for resulting row vector
nS=mc.nStates;

pS = DiscreteD(mc.InitialProb);
S(1) = pS.rand(1); % DiscreteD rand from initial distribution
assert(S(1)<(nS+1),'started in endstate'); % should be fine if initial prob is 0 for endState

for i = 2:T
    pD = DiscreteD(mc.TransitionProb(S(i-1),:));% DiscreteD rand on transition probability
    S(i) = pD.rand(1);
    if S(i) == nS+1
        S = S(1:i);
        break
    end
end



