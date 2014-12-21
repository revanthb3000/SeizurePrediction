% Given a matrix of size numOfElectrodes x numOfReadings, this script plots
% a graph for all electrodes at one place.

function [] = plotData( sig , fileName)
numberOfPoints = size(sig,2);
numberOfElectrodes = size(sig,1);
t = linspace(0,10,numberOfPoints);

% calculate shift
mi = min(sig,[],2);
ma = max(sig,[],2);
shift = cumsum([0; abs(ma(1:end-1))+abs(mi(2:end))]);
shift = repmat(shift,1,numberOfPoints);

figure('Visible','off');
%plot 'eeg' data
plot(t,sig+shift)

xlabel('Time (10 minute interval)');
ylabel('Electrode Data');
title(fileName);

% edit axes
set(gca,'ytick',mean(sig+shift,2),'yticklabel',1:numberOfElectrodes)
grid on
ylim([mi(1) max(max(shift+sig))])

saveas(gcf, ['Plots/' fileName], 'jpg')
end