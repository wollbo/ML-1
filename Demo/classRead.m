function file = classRead(workingDir, dirName)

% input is folder name of melodies, i.e. "vindarna" or "uti"
% output is the raw features of the selected class
% NOTE: user processing of data is done outside this function
% only utilize GetMusicFeatures

folder = [workingDir '/melodies/wav/' dirName];
% file should be a cell array in order to avoid zero padding/allow
% different lengths
audio_files = dir(fullfile(folder,'*.wav'));
file = cell(numel(audio_files),1);
for i = 1:numel(audio_files)
    %wav = sprintf('/%d.wav', i);
    audio = audioread([folder '/' audio_files(i).name]);
    file{i} = audio;
    %file(1:length(audio),i) = audio;
end
end
