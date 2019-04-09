function index = obs2index(observation, key, ind)
%requires 1-to-1 key, ind
index = zeros(length(observation),1);
for i = 1:length(ind)
    index(observation == key(i)) = ind(i);
end
end
