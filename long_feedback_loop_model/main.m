function main

% for more information see readme.txt
addpath('C:\Users\monte427\Documents\git\math-5447-final-project\long_feedback_loop_model');

% load data
var = load('weights.mat');

% adding additional variables for long feedback loop extension
wlc = [12; 12];
wsl = [13; 13];
Tlc = [14; 14];
Tsl = [15; 15];
var.weights = [var.weights, wlc, wsl, Tlc, Tsl];

[~, Features_opt] = minfunction(var.weights(1,:));
generate_fig(Features_opt, 1)

[~, Features_opt] = minfunction(var.weights(2,:));
generate_fig(Features_opt, 2)


