function R=rand(pD,nData)
%R=rand(pD,nData) returns random scalars drawn from given Discrete Distribution.
%
%Input:
%pD=    DiscreteD object
%nData= scalar defining number of wanted random data elements
%
%Result:
%R= row vector with integer random data drawn from the DiscreteD object pD
%   (size(R)= [1, nData]
%
%----------------------------------------------------
%Code Author: Hilding Wollbo 2019
%----------------------------------------------------

if numel(pD)>1
    error('Method works only for a single DiscreteD object');
end;

%*** Insert your own code here and remove the following error message 

N = length(pD.ProbMass);
pDcdf = cumsum(pD.ProbMass);
R = zeros(1,nData);
for j = 1:nData
    index = rand(1,1);
    if pDcdf(1) > index
        R(1,j) = 1;
    else
        for i = 1:N-1
            if pDcdf(i)<index && pDcdf(i+1)>index
                R(1,j) = i+1;
                break
            end
        end
    end
end