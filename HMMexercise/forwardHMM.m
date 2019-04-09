function pvprob = forwardHMM(observation, p, P, E, key, index)

ind = obs2index(observation(1),key,index);
pvprob(1,:) = p.*E(:,ind)';
% init
for i = 2:length(observation)
%     ptot(1) = max(pv(i-1,:).*P(:,1)');
%     ptot(2) = max(pv(i-1,:).*P(:,2)');
    ptot = max(pvprob(i-1,:).*P', [], 2)';
    ind = obs2index(observation(i),key,index);
    pvprob(i,:) = ptot.*E(:,ind)';
end
end
