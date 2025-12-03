function run_simulation_manual
    % RUN_SIMULATION_MANUAL (Dynamic Striatum Extension)
    % Runs the model using Pavlides original weights + our manually added
    % weights for new network connections. 
    % Does NOT optimize. Plots both Resonance and Feedback cases.

    % 1. Setup
    if ~exist('model_eqs.m', 'file')
        addpath(pwd); 
    end
    
    % Load Original Optimized Weights (Row 1 = Resonance, Row 2 = Feedback)
    var_data = load('weights.mat');
    
    
    % 2. Define manual weights
    wstrg = 3.1;       % Weight: Striatum -> GPe (var 16)
    wcstr = 9.9709;       % Weight: Cortex -> Striatum (var 17)
    Tstrg = 10;       % Delay: Striatum -> GPe (ms) (var 18)
    Tcstr = 6;       % Delay: Cortex -> Striatum (ms) (var 19)
    
    % Construct full parameter vector for feedback-derived model
    original_params = var_data.weights(2, :); 
    full_var = [original_params, wstrg, wcstr, Tstrg, Tcstr];

    % 3. Run sim
    disp('Manual simulation running...');
    [~, Features_opt] = minfunction(full_var);
    
    % Plot
    generate_fig(Features_opt);

    disp('Manual simulation complete.');
end