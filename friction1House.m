function [mu] = friction1House(y)
% At all points y, the coefficient of friction on an
% unoiled bowling lane is mu=0.2
if y <= 40
    mu = 0.05;
else
    mu = 0.20;
end
end