function run_optimization
    % RUN_OPTIMIZATION (Dynamic Striatum - Feedback Only)

    if ~exist('model_eqs.m', 'file')
        addpath(pwd); 
    end
    
    var_data = load('weights.mat');

    % Setup
    original_params = var_data.weights(2, :); 
    new_params_guess = [5, 10, 14, 15]; 

    % Initial guess
    x0 = [original_params, new_params_guess];

    % Bounds
    lb = zeros(1, 19);
    lb(9) = 1; 
    lb(10:11) = 10; 
    lb(14) = 5; 
    lb(15) = 20; 
    lb(18:19) = 1;

    ub = zeros(1, 19);
    ub(1:8) = 30; 
    ub(9) = 10; 
    ub(10:11) = 20; 
    ub(12:13) = 20; 
    ub(14) = 8; 
    ub(15) = 33; 
    ub(16:17) = 30; 
    ub(18:19) = 50;

    % Run Optimizer
    disp('Starting Optimization (Feedback Model)...');
    
    % MaxTime argument is time the optimizer runs in seconds
    options = optimoptions('simulannealbnd', ...
                           'Display', 'iter', ...
                           'MaxTime', 300, ...
                           'InitialTemperature', 50);
                           
    [optimized_var, final_cost] = simulannealbnd(@minfunction, x0, lb, ub, options);

    % Display results
    disp(['Final Cost: ', num2str(final_cost)]);
    disp('Optimized Parameters:');
    disp(optimized_var);

    % Generate plots
    [~, Features_opt] = minfunction(optimized_var);
    generate_fig(Features_opt);
end