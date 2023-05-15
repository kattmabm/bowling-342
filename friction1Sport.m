function [mu] = friction1Sport(y)
if y < 10
    mu = 0.04;
elseif y < 20
    mu = 0.06;
elseif y < 30
    mu = 0.08;
elseif y < 40
    mu = 0.1;
else
    mu = 0.20;
end
end