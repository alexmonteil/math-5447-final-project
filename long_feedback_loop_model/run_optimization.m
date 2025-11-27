function run_optimization
    % RUN_OPTIMIZATION (Long Feedback Loop Extension)
    % Runs optimization TWICE: once for Parameter Set 1 (Resonance)
    % and once for Parameter Set 2 (Feedback).

    % 1. Setup
    if ~exist('model_eqs.m', 'file')
        addpath(pwd); 
    end
    
    % Load Original Optimized Weights (Row 1 = Resonance, Row 2 = Feedback)
    var_data = load('weights.mat');

    % 2. DEFINE BIOLOGICAL BOUNDS (Constraints)
    % Lower Bounds (lb)
    lb = zeros(1, 19);
    lb(9) = 1;      % Tcc min
    lb(10:11) = 10; % tau min
    lb(14) = 5;     % Me min
    lb(15) = 20;    % Mi min
    lb(18:19) = 1;  % New Delays min

    % Upper Bounds (ub)
    ub = zeros(1, 19);
    ub(1:8) = 30;   % Standard Weights
    ub(9) = 10;     % Tcc max
    ub(10:11) = 20; % tau max
    ub(12:13) = 20; % Baseline firing max
    ub(14) = 8;     % Me max
    ub(15) = 33;    % Mi max
    ub(16:17) = 30; % New Weights max (wlc, wsl)
    ub(18:19) = 50; % New Delays max (Tlc, Tsl)

    % Optimization Settings
    options = optimoptions('simulannealbnd', ...
                           'Display', 'iter', ...
                           'MaxTime', 90, ...
                           'InitialTemperature', 50);

    % 3. LOOP THROUGH BOTH PARAMETER SETS
    for set_idx = 1:2
        
        if set_idx == 1
            disp('==========================================================');
            disp('OPTIMIZING PARAMETER SET 1 (Resonance-Derived Seed)...');
            disp('==========================================================');
        else
            disp('==========================================================');
            disp('OPTIMIZING PARAMETER SET 2 (Feedback-Derived Seed)...');
            disp('==========================================================');
        end
        
        % Load Seed Parameters
        original_params = var_data.weights(set_idx, :);
    
        % Define Initial Guess for NEW parameters 
        % [wlc, wsl, Tlc, Tsl]
        new_params_guess = [12, 13, 14, 15]; 
        
        % Construct Initial Point x0
        x0 = [original_params, new_params_guess];
    
        % Run Optimization
        disp(['Starting Simulated Annealing for Set ', num2str(set_idx), '...']);
        [optimized_var, final_cost] = simulannealbnd(@minfunction, x0, lb, ub, options);
    
        % Display Results
        disp(['Optimization Complete for Set ', num2str(set_idx)]);
        disp(['Final Cost: ', num2str(final_cost)]);
        disp('Optimized Parameters:');
        disp(optimized_var);
        
        % Generate Figure
        [~, Features_opt] = minfunction(optimized_var);
        
        % Plot result using the current set index (1 or 2)
        generate_fig(Features_opt, set_idx);
        
    end
    
    disp('All optimizations complete.');
end