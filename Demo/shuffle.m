function shuffle(recording,number)
% Hilding Wollbo 2019

%% shuffles the training data and test data
% clears the test folder, selects 'number' of files from training folder and places them in test
% to be used in classifier performance estimation

source = ['Demo/melodies/wav/' 'test/' recording];
dest = ['Demo/melodies/wav/' recording];
movefile([source '/*.wav'],dest) % wildcard...

nmax = numel(dir(fullfile(dest,'*.wav')));
rvec = zeros(number,1);
forbidden = rvec;
for i = 1:number
    rvec(i) = randi(nmax);
    while forbidden(rvec(i)==forbidden)
        rvec(i) = randi(nmax);
    end
    forbidden(i) = rvec(i);
end

for i = 1:number
movefile([dest '/' char(string(rvec(i))) '.wav'], source)
end

end