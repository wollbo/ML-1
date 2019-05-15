function file = classRead(workingDir, dirName)

% input is folder name of melodies, i.e. "vindarna" or "uti"
% output is the raw features of the selected class
% NOTE: user processing of data is done outside this function
% only utilize GetMusicFeatures

folder = [workingDir '/melodies/wav/' dirName];

for i = 1:numel(dir(fullfile(folder,'*.wav')))
    wav = sprintf('/%d.wav', i);
    audio = audioread([folder wav]);
    file(1:length(audio),i) = audio;
end
end
