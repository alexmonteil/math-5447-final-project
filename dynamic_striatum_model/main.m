function main

% for more information see readme.txt
addpath('C:\Users\monte427\Documents\git\math-5447-final-project\dynamic_striatum_model');

% load data
var = load('weights.mat');

% adding additional variables for striatum extension
wstrg = [12; 12];
wcstr = [13; 13];
Tstrg = [14; 14];
Tcstr = [15; 15];
var.weights = [var.weights, wstrg, wcstr, Tstrg, Tcstr];

[~, Features_opt] = minfunction(var.weights(1,:));
generate_fig(Features_opt, 1)

[~, Features_opt] = minfunction(var.weights(2,:));
generate_fig(Features_opt, 2)


