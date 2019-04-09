alpha = 0.2;
beta = 0.4;
e1 = 0.99; % how correlated with the hidden state is this measurement?
e2 = 0.01;
len = 40;

P = [1-alpha alpha; beta 1-beta];
E = [e1 1-e1; e2 1-e2];

%stat = [0.5 0.5]*P^lim
p = [beta/(alpha+beta) alpha/(alpha+beta)];


states = [0 1];

[seq, obs] = generateMarkov(P, E, len);

pv = zeros(length(obs),2);
decoded = pv(:,1);
key = [1 -1];
index = [1 2];


%%

ind = obs2index(obs(1),key,index);
pv(1,:) = p.*E(:,ind)';
% init
for i = 2:length(obs)
%     ptot(1) = max(pv(i-1,:).*P(:,1)');
%     ptot(2) = max(pv(i-1,:).*P(:,2)');
    ptot = max(pv(i-1,:).*P', [], 2)';
    ind = obs2index(obs(i),key,index);
    pv(i,:) = ptot.*E(:,ind)';
end

%%

[~, indices] = max(pv,[],2);
for i = 1:max(size(pv))
    decoded(i) = obs2index(indices(i), index, states);
end

pvt = forwardHMM(obs, p, P, E, key, index);

dect = viterbi(pvt, index, states);


sum(xor(dect,seq))







