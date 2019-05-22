function file = classRead(workingDir, dirName)

% input is folder name of melodies, i.e. "vindarna" or "uti"
% output is the raw features of the selected class
% NOTE: user processing of data is done outside this function
% only utilize GetMusicFeatures

folder = [workingDir '/melodies/wav/' dirName];
% file should be a cell array in order to avoid zero padding/allow
% different lengths
L = numel(dir(fullfile(folder,'*.wav')));
file = cell(L,1);
for i = 1:L
    wav = sprintf('/%d.wav', i);
    audio = audioread([folder wav]);
    file{i} = audio;
    %file(1:length(audio),i) = audio;
end
end
