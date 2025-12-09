function weight_sweep(var,sweepVars, sweepRange, sweepStep)
    % Var is the list of variables needed to run sim
    % sweepVars is the index of the two variables that need to be swept.
    % sweepRange is a 2x2 matrix of values to sweep
        % - row 1 is min and max values of sweepVar(1)
        % - row 2 is min and max values of sweepVar(2)
    % sweepStep is the step size of values in sweepRange

    % out is the frequency of oscillations observed in STN at each pair of
    %   swept variables

    sweepVals1 = sweepRange(1,1):sweepStep:sweepRange(1,2);
    sweepVals2 = sweepRange(2,1):sweepStep:sweepRange(2,2);
    
    out = nan(length(sweepVals1),length(sweepVals2));
    for w1 = 1:length(sweepVals1)
        var(sweepVars(1)) = sweepVals1(w1);
        for w2 = 1:length(sweepVals2)
            var(sweepVars(2)) = sweepVals2(w2);
            
            [~, Features_opt] = minfunction(var);
            out(w1,w2) = cell2mat(Features_opt(7)); % index 7 is the detected oscillation frequency
        end
    end
    figure
    heatmap(sweepVals1,sweepVals2,out,'Colormap',jet)
    xlabel('w_C_Str')
    ylabel('w_Str_G')

end