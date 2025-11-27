function generate_fig(Features_opt, plot_flag)

% function plotting(Features_opt, data_type)
% This contains functions for plotting output from model
% INPUTS
% Features_opt - A vector of features (firing rates and frequency)
%                obtained from the model.
% plot_flag    - If plot_flag = 1 then it plots figures from 
%                full_long_weight20_pooled.mat. If plot_flag = 2 then it
%                plots figures from zerowsc_long_weight20_pooled.mat. 

% Set plot layout parameters
fontsize = 5;
labelsize = 6;
annotation_horz_pos = -1.6;
annotation_vert_pos = 0.5;
annotate_fontsize = 8;

% extract variables
minSTN  = cell2mat(Features_opt(1));
meanSTN = cell2mat(Features_opt(2));
maxSTN  = cell2mat(Features_opt(3));
minGPe  = cell2mat(Features_opt(4));
meanGPe = cell2mat(Features_opt(5));
maxGPe  = cell2mat(Features_opt(6)); 
freq    = cell2mat(Features_opt(7)); 
x1      = cell2mat(Features_opt(8));  %STN firing rate of intact model
y1      = cell2mat(Features_opt(9));  %GPe firing rate of intact model
x2      = cell2mat(Features_opt(10)); %STN firing rate of model with wgs = 0
y2      = cell2mat(Features_opt(11)); %GPe firing rate of modelwith wgs = 0
x3      = cell2mat(Features_opt(12)); %STN firing rate of model with wsg = 0
y3      = cell2mat(Features_opt(13)); %GPe firing rate of model with wsg = 0
x4      = cell2mat(Features_opt(14)); %STN firing rate of model with wcs = 0
y4      = cell2mat(Features_opt(15)); %GPe firing rate of model with wcs = 0
x5      = cell2mat(Features_opt(18)); %STN firing rate of model with wsl = 0
y5      = cell2mat(Features_opt(19)); %GPe firing rate of model with wsl = 0
x6      = cell2mat(Features_opt(16)); %STN firing rate of model with str = 0
y6      = cell2mat(Features_opt(17)); %GPe firing rate of model with str = 0
x7      = cell2mat(Features_opt(20)); %STN firing rate of model with wlc = 0
y7      = cell2mat(Features_opt(21)); %GPe firing rate of model with wlc = 0

%% Plot Setup
    % firing rates of single neurons
    experimental = [5, 65, 125, 45, 100, 155, 14];
    simulation = [minSTN, meanSTN, maxSTN, minGPe, meanGPe, maxGPe, freq];
    
if plot_flag == 1;    
    hFig = figure;
    set(hFig, 'Position', [0 0 700 1200])   
    plot_flag_vec = [1,3,5,7,9,11,13,15];
elseif plot_flag == 2; 
    plot_flag_vec = [2,4,6,8,10,12,14,16];
    hold on;
end

% 1. SUMMARY STATS PLOT (Placed at the bottom row, index 8)
subplot(8,2, plot_flag_vec(8))
plot(experimental, 'x',...
    'LineStyle','none',...
    'LineWidth', 2, ...
    'MarkerSize',6,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0, 0, 1])

set(gca, 'Units', 'Normalized');
Labels = {'minSTN','meanSTN','maxSTN','minGPe','meanGPe','maxGPe','freq'};
xticks = 1:7; 
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'XMinorTick'  , 'off'                        , ...
    'YMinorTick'  , 'off'                        , ...
    'XTick'       , xticks                       , ...
    'XTickLabel'  , Labels                       , ...
    'FontSize'    , fontsize                         );

hold on;
subplot(8,2,plot_flag_vec(8))
plot(simulation,'o',...
    'LineStyle','none',...
    'MarkerSize',5,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[1, 0, 0])

grid on
h_legend = legend('experimental','simulation');
if plot_flag == 1;
lh=findall(gcf,'tag','legend');
lp=get(lh,'position');
set(lh,'position',[0.40,0.185,lp(3:4)]);

set(h_legend,'FontSize',fontsize);
ylabel({'Firing rate (spk/s) or' ;'oscillation frequency (Hz)'},'fontsize',fontsize)
hold off
end

% 2. INTACT MODEL
subplot(8,2,plot_flag_vec(1))
plot(x1,y1)

if plot_flag == 1;
ylabel('Firing rate (spk/s)','fontsize',fontsize)
end

% Add legend for both parameter sets
h_legend = legend('STN','GP', 'E', 'I', 'L');
set(h_legend,'FontSize',fontsize);

% Headers for set of subplots
if plot_flag == 1;
    % Note: now both sets of parameters represent a feedback model
    title('Parameter Set 1 (Resonance-derived)', 'FontSize', 10);
elseif plot_flag == 2;
    % Note: now both sets of parameters represent a feedback model
    title('Parameter Set 2 (Feedback-derived)', 'FontSize', 10);
end

set(gca, 'Units', 'Normalized');
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'FontSize'    , labelsize                           );

descr = {'Intact'};
ax = gca;
axes(ax) 
h = text(annotation_horz_pos,annotation_vert_pos,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

% 3. WGS = 0 MODEL
subplot(8,2,plot_flag_vec(2))
plot(x2,y2)
if plot_flag == 1;
ylabel('Firing rate (spk/s)','fontsize',fontsize)
end

set(gca, 'Units', 'Normalized');
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'FontSize'    , labelsize                               );

descr = {'w_{GS} = 0'};
ax = gca;
axes(ax) 
h = text(annotation_horz_pos,annotation_vert_pos,0,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

% 4. WSG = 0 MODEL
subplot(8,2,plot_flag_vec(3))
plot(x3,y3)
if plot_flag == 1;
ylabel('Firing rate (spk/s)','fontsize',fontsize)
end

set(gca, 'Units', 'Normalized');
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'FontSize'    , labelsize                               );

descr = {'w_{SG} = 0'};
ax = gca;
axes(ax) 
h = text(annotation_horz_pos,annotation_vert_pos,0,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

% 5. WCS = 0 MODEL
subplot(8,2,plot_flag_vec(4))
plot(x4,y4)
if plot_flag == 1;
ylabel('Firing rate (spk/s)','fontsize',fontsize)
end

set(gca, 'Units', 'Normalized');
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'FontSize'    , labelsize                               );

descr = {'w_{CS} = 0'};
ax = gca;
axes(ax) 
h = text(annotation_horz_pos,annotation_vert_pos,0,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

% 6. WSL = 0 MODEL
subplot(8,2,plot_flag_vec(5))
plot(x5,y5)
if plot_flag == 1;
ylabel('Firing rate (spk/s)','fontsize',fontsize)
end

set(gca, 'Units', 'Normalized');
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'FontSize'    , labelsize                               );

descr = {'w_{SL} = 0'};
ax = gca;
axes(ax) 
h = text(annotation_horz_pos,annotation_vert_pos,0,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

% 7. STR = 0 MODEL
subplot(8,2,plot_flag_vec(6))
plot(x6,y6)
if plot_flag == 1;
ylabel('Firing rate (spk/s)','fontsize',fontsize)
end
xlabel('Time (s)','fontsize',fontsize)
xlabh = gca();

if plot_flag == 1;
    ylimits = ylim; 
set(get(xlabh, 'XLabel'), 'Position', [0.5 -ylimits(2)/6 0])
elseif plot_flag == 2;
    ylimits = ylim; 
set(get(xlabh, 'XLabel'), 'Position', [0.5 -ylimits(2)/6 0])
end

set(gca, 'Units', 'Normalized');
set(gca, ...
    'Box'         , 'on'                        , ...
    'LooseInset'  , get(gca, 'TightInset') * 1.5 , ...
    'TickDir'     , 'in'                         , ...
    'TickLength'  , [.02 .02]                    , ...
    'LineWidth'   , 1                            , ...
    'FontSize'    , labelsize                               );

descr = {'Str = 0'};
ax = gca;
axes(ax) 
h = text(annotation_horz_pos,annotation_vert_pos,0,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

% 8. WLC = 0 MODEL
subplot(8,2,plot_flag_vec(7))
plot(x7,y7)
if plot_flag == 1; ylabel('Firing rate (spk/s)','fontsize',fontsize); end
xlabel('Time (s)','fontsize',fontsize) % Axis label goes on the last time series

set(gca, 'Units', 'Normalized', 'Box', 'on', 'TickDir', 'in', 'FontSize', labelsize);
descr = {'w_{LC} = 0'};
ax = gca; axes(ax); 
h = text(annotation_horz_pos,annotation_vert_pos,0,descr,'fontsize',annotate_fontsize);
set(h, 'rotation', 90)

%% Save Figure

% Get the directory where this specific script (generate_fig.m) is located
script_folder = fileparts(mfilename('fullpath'));

% Construct the full path to save 'output_figure.fig' in that folder
output_path = fullfile(script_folder, 'output_figure');

saveas(gcf, output_path);

end 