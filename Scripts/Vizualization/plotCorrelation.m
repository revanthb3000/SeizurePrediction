correlationMatrix = dlmread(strcat('Stats/',subject,'interictalCorrelationAveraged.txt'));
n = size(correlationMatrix,1);
L = 1 : n;

imagesc(correlationMatrix); % plot the matrix
set(gca, 'XTick', 1:n); % center x-axis ticks on bins
set(gca, 'YTick', 1:n); % center y-axis ticks on bins
set(gca, 'XTickLabel', L); % set x-axis labels
set(gca, 'YTickLabel', L); % set y-axis labels
title([subject ' Correlation Matrix For Interictal Data'], 'FontSize', 14); % set title
colormap('summer'); % set the colorscheme
colorbar; % enable colorbar
saveas(gcf, ['Plots/' subject '-InterictalCorrelationPlot'], 'jpg')

correlationMatrix = dlmread(strcat('Stats/',subject,'preictalCorrelationAveraged.txt'));
n = size(correlationMatrix,1);
L = 1 : n;

imagesc(correlationMatrix); % plot the matrix
set(gca, 'XTick', 1:n); % center x-axis ticks on bins
set(gca, 'YTick', 1:n); % center y-axis ticks on bins
set(gca, 'XTickLabel', L); % set x-axis labels
set(gca, 'YTickLabel', L); % set y-axis labels
title([subject ' Correlation Matrix For Preictal Data'], 'FontSize', 14); % set title
colormap('summer'); % set the colorscheme
colorbar; % enable colorbar
saveas(gcf, ['Plots/' subject '-PreictalCorrelationPlot'], 'jpg')