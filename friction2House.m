function [mu] = friction2House(x, y)
x = abs(x);
if y > 40
    mu = 0.10;
elseif x < 0.3
    mu = 0.02;
elseif x < 0.6
    mu = 0.03;
elseif x < 0.9
    mu = 0.04;
else
    mu = 0.05;
end
end