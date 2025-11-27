function generate_fig(Features_opt)
% generate_fig(Features_opt) - Plots results for the Long Loop Feedback Model

fontsize = 8;
% Extract data
minSTN  = cell2mat(Features_opt(1));
meanSTN = cell2mat(Features_opt(2));
maxSTN  = cell2mat(Features_opt(3));
minGP   = cell2mat(Features_opt(4));
meanGP  = cell2mat(Features_opt(5));
maxGP   = cell2mat(Features_opt(6)); 
freq    = cell2mat(Features_opt(7)); 

x1      = cell2mat(Features_opt(8));  % Intact
y1      = cell2mat(Features_opt(9));
x2      = cell2mat(Features_opt(10)); % wgs=0
y2      = cell2mat(Features_opt(11));
x3      = cell2mat(Features_opt(12)); % wsg=0
y3      = cell2mat(Features_opt(13));
x4      = cell2mat(Features_opt(14)); % wcs=0
y4      = cell2mat(Features_opt(15));
x5      = cell2mat(Features_opt(16)); % wsl=0
y5      = cell2mat(Features_opt(17));
x6      = cell2mat(Features_opt(18)); % Str=0
y6      = cell2mat(Features_opt(19));
x7      = cell2mat(Features_opt(20)); % wlc=0
y7      = cell2mat(Features_opt(21));

hFig = figure;
set(hFig, 'Position', [0 0 600 1000]);

% 1. Intact
subplot(8,1,1); 
    plot(x1,y1); 
    title('Intact Long Loop Model', 'FontSize', fontsize); 
    legend({'STN','GPe','E','I','L'}, 'FontSize', fontsize, 'Location', 'Best'); 
    ylabel('FR (spk/s)', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 2. WGS = 0
subplot(8,1,2); 
    plot(x2,y2); 
    title('w_{GS} = 0', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 3. WSG = 0
subplot(8,1,3); 
    plot(x3,y3); 
    title('w_{SG} = 0', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 4. WCS = 0
subplot(8,1,4); 
    plot(x4,y4); 
    title('w_{CS} = 0', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 5. WSL = 0 (Long Loop Cut 1)
subplot(8,1,5); 
    plot(x5,y5); 
    title('w_{SL} = 0', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 6. WLC = 0 (Long Loop Cut 2)
subplot(8,1,6); 
    plot(x7,y7); 
    title('w_{LC} = 0', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 7. STR = 0 (Constant Input)
subplot(8,1,7); 
    plot(x6,y6); 
    title('Str = 0', 'FontSize', fontsize); 
    axis([0 1 0 400]);
    set(gca, 'FontSize', fontsize);

% 8. STATS
subplot(8,1,8)
hold on
experimental = [5, 65, 125, 45, 100, 155, 14];
simulation = [minSTN, meanSTN, maxSTN, minGP, meanGP, maxGP, freq];

plot(experimental, 'bx', 'LineWidth', 2, 'MarkerSize', 8)
plot(simulation, 'ro', 'MarkerSize', 6)
legend({'Exp', 'Sim'}, 'FontSize', fontsize, 'Location', 'Best')
set(gca, 'XTick', 1:7, 'XTickLabel', {'minS','meanS','maxS','minG','meanG','maxG','Hz'})
grid on

% Add X-label
xlabel('Statistic / Frequency', 'FontSize', fontsize);

% Save
script_folder = fileparts(mfilename('fullpath'));
saveas(gcf, fullfile(script_folder, 'output_figure'));

end