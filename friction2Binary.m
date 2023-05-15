function [mu] = friction2Binary(x, y)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
if y <= 40
    mu = 0.05;
else
    mu = 0.20;
end