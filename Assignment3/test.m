%test2
% for ML upg. 5.1

clear all

q = [1;0;0];
A = [0.3 0.7 0; 0 0.5 0.5; 0 0 1];
B = [1 0 0 0; 0 0.5 0.4 0.1; 0.1 0.1 0.2 0.6];

z = [1 2 4 4 1];

alfatemp(:,1) = q.*B(:,z(1));
c(1) = sum(alfatemp(:,1));
alfahat(:,1) = alfatemp(:,1)/c(1);

for i = 2:length(z)
    alfatemp(:,i) = B(:,z(i)).*(alfahat(:,i-1)'*A)';
    c(i) = sum(alfatemp(:,i));
    alfahat(:,i) = alfatemp(:,i)/c(i);
end
