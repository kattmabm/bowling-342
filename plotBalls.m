clc;
clear;
close all;

% ONE-DIMENSIONAL EXAMPLES
% ballPath1D(0, 25, -1.87, @friction1Dry, "Unoiled Lane");
% ballPath1D(0, 25, -1.87, @friction1House, "House Oil Pattern");
% ballPath1D(0, 25, -1.87, @friction1Sport, "Sport Oil Pattern");
% ballPath1Dx(-1, -0.5, -1, @friction1Dry, "Unoiled Lane (x)");

% TWO-DIMENSIONAL AMATEUR
ballPath2D(-0.25, 0, -0.75, 20, -3, -1, @friction2Dry, "Unoiled Lane");
ballPath2D(-0.25, 0, -0.75, 20, -3, -1, @friction2House, "House Oil Pattern");
ballPath2D(-0.25, 0, -0.75, 20, -3, -1, @friction2Sport, "Sport Oil Pattern");

% TWO-DIMENSIONAL PROFESSIONAL
% ballPath2D(0.5, 0, -1.8, 25, -12, -2, @friction2Dry, "Unoiled Lane");
% ballPath2D(0.5, 0, -1.8, 25, -12, -2, @friction2House, "House Oil Pattern");
% ballPath2D(0.5, 0, -1.8, 25, -12, -2, @friction2Sport, "Sport Oil Pattern");

% TWO-DIMENSIONAL MISTAKE
% ballPath2D(0.5, 0, -1.7, 24, -12, -2, @friction2House, "House Oil Pattern");
% ballPath2D(0.5, 0, -1.7, 22, -13, -2, @friction2Sport, "Sport Oil Pattern");
