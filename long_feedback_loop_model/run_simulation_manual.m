function run_simulation_manual
    % RUN_SIMULATION_MANUAL (Long Feedback Loop Extension)
    % Runs the model using Pavlides' original weights + your MANUAL values.
    % Plots both Resonance (Row 1) and Feedback (Row 2) scenarios.

    % 1. Setup
    if ~exist('model_eqs.m', 'file')
        addpath(pwd); 
    end
    
    % Load Original Optimized Weights (Row 1 = Resonance, Row 2 = Feedback)
    var_data = load('weights.mat');
    
    % 2. DEFINE YOUR MANUAL WEIGHTS & DELAYS HERE
    wlc = 12;       % Weight: Long Loop -> Cortex (var 16)
    wsl = 13;       % Weight: STN -> Long Loop (var 17)
    Tlc = 14;       % Delay: L -> Cortex (ms) (var 18)
    Tsl = 15;       % Delay: STN -> L (ms) (var 19)
    
    % 3. RUN SCENARIO A: RESONANCE-DERIVED (Row 1)
    disp('Running Simulation: Parameter Set 1 (Resonance-derived)...');
    
    original_params_1 = var_data.weights(1, :); 
    full_var_1 = [original_params_1, wlc, wsl, Tlc, Tsl];
    
    [~, Features_opt_1] = minfunction(full_var_1);
    generate_fig(Features_opt_1, 1); % Plot with Resonance labels
    
    % 4. RUN SCENARIO B: FEEDBACK-DERIVED (Row 2)
    disp('Running Simulation: Parameter Set 2 (Feedback-derived)...');
    
    original_params_2 = var_data.weights(2, :);
    full_var_2 = [original_params_2, wlc, wsl, Tlc, Tsl];
    
    [~, Features_opt_2] = minfunction(full_var_2);
    generate_fig(Features_opt_2, 2); % Plot with Feedback labels

    disp('Manual simulations complete.');
end