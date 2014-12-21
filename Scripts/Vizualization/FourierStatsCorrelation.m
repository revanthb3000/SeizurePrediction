fourierMatrix = dlmread(strcat('FourierStats/filteredStats/',subject,'interictalFourierMatrix.txt'));
correlationMatrix = corrcoef(fourierMatrix);
n = size(correlationMatrix,1);
L = 1 : n;

imagesc(correlationMatrix); % plot the matrix
set(gca, 'XTick', 1:n); % center x-axis ticks on bins
set(gca, 'YTick', 1:n); % center y-axis ticks on bins
set(gca, 'XTickLabel', L); % set x-axis labels
set(gca, 'YTickLabel', L); % set y-axis labels
title([subject ' Correlation Matrix For Interictal Fourier Frequencies'], 'FontSize', 14); % set title
colormap('summer'); % set the colorscheme
colorbar; % enable colorbar
saveas(gcf, ['Plots/FourierCorrelation/' subject '-InterictalFourierCorrelationPlot'], 'jpg')

fourierMatrix = dlmread(strcat('FourierStats/filteredStats/',subject,'preictalFourierMatrix.txt'));
correlationMatrix = corrcoef(fourierMatrix);
n = size(correlationMatrix,1);
L = 1 : n;

imagesc(correlationMatrix); % plot the matrix
set(gca, 'XTick', 1:n); % center x-axis ticks on bins
set(gca, 'YTick', 1:n); % center y-axis ticks on bins
set(gca, 'XTickLabel', L); % set x-axis labels
set(gca, 'YTickLabel', L); % set y-axis labels
title([subject ' Correlation Matrix For Preictal Fourier Frequencies'], 'FontSize', 14); % set title
colormap('summer'); % set the colorscheme
colorbar; % enable colorbar
saveas(gcf, ['Plots/FourierCorrelation/' subject '-PreictalFourierCorrelationPlot'], 'jpg')