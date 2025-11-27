function run_simulation_manual
    % RUN_SIMULATION_MANUAL (Long Feedback Loop Extension)
    % Runs the model using Pavlides' original weights + new weights

    % 1. Setup
    if ~exist('model_eqs.m', 'file')
        addpath(pwd); 
    end
    
    % Load Original Optimized Weights (Row 1 = Resonance, Row 2 = Feedback)
    var_data = load('weights.mat');
    
    % 2. Define manual weights
    wlc = 12;       % Weight: Long Loop -> Cortex (var 16)
    wsl = 13;       % Weight: STN -> Long Loop (var 17)
    Tlc = 14;       % Delay: L -> Cortex (ms) (var 18)
    Tsl = 15;       % Delay: STN -> L (ms) (var 19)

    original_params = var_data.weights(2, :); 
    full_var = [original_params, wlc, wsl, Tlc, Tsl];
    
    % 3. Run sim
    disp('Manual simulation running...');
    [~, Features_opt] = minfunction(full_var);

    % 4. Plot results
    generate_fig(Features_opt); % Plot with Resonance labels

    disp('Manual simulations complete.');
end