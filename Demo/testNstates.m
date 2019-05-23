% test2
winsize = (2*10^(-2));
fs = 44100;
A = 440;


recNames=string({'vindarna','uti','summer','rasputin','morning','hooked','hips','hearts','grace','finland'});

for i = 1:10
audio{i} = classRead('Demo', ['/test/', char(recNames(i))]);
end

%%

features = extract(audio{10},fs,winsize,A);
plot(1:length(features{1}(1,:)), features{1}(1,:), 1:length(features{1}(1,:)), features{1}(2,:))

%%