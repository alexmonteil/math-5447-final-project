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
    
    
    % 2. DEFINE MANUAL WEIGHTS & DELAYS
    wstrg = 12;       % Weight: Striatum -> GPe (var 16)
    wcstr = 13;       % Weight: Cortex -> Striatum (var 17)
    Tstrg = 14;       % Delay: Striatum -> GPe (ms) (var 18)
    Tcstr = 15;       % Delay: Cortex -> Striatum (ms) (var 19)
    
    % 3. RUN SCENARIO A: RESONANCE-DERIVED (Row 1)
    disp('Running Simulation: Parameter Set 1 (Resonance-derived)...');
    
    % Construct full parameter vector for resonance-derived model
    original_params_1 = var_data.weights(1, :); 
    full_var_1 = [original_params_1, wstrg, wcstr, Tstrg, Tcstr];
    
    % Run simulation (ignoring cost output)
    [~, Features_opt_1] = minfunction(full_var_1);
    
    % Plot with Flag 1 (Resonance Labels)
    generate_fig(Features_opt_1, 1);
    
    % 4. RUN SCENARIO B: FEEDBACK-DERIVED (Row 2)
    disp('Running Simulation: Parameter Set 2 (Feedback-derived)...');
    
    % Construct full parameter vector for feedback-derived model
    original_params_2 = var_data.weights(2, :);
    full_var_2 = [original_params_2, wstrg, wcstr, Tstrg, Tcstr];
    
    % Run simulation
    [~, Features_opt_2] = minfunction(full_var_2);
    
    % Plot with Flag 2 (Feedback Labels)
    generate_fig(Features_opt_2, 2);

    disp('Manual simulations complete.');
end