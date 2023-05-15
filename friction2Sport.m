function [mu] = friction2Sport(x, y)
x = abs(x);
if x < 1.25 && y < 10
    mu = 0.02;
elseif x < 0.75 && y < 20
    mu = 0.03;
elseif x < 0.4 && y < 30
    mu = 0.04;
elseif y < 40
    mu = 0.05;
else
    mu = 0.10;
end
end