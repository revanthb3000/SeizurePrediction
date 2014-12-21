interictalMean = dlmread(strcat('Stats/',subject,'interictalMeanAveraged.txt'));
interictalVariance = dlmread(strcat('Stats/',subject,'interictalVarianceAveraged.txt'));

preictalMean = dlmread(strcat('Stats/',subject,'preictalMeanAveraged.txt'));
preictalVariance = dlmread(strcat('Stats/',subject,'preictalVarianceAveraged.txt'));


cmap = hsv(size(interictalMean,2));  %# Creates a 6-by-3 set of colors from the HSV colormap

x = -160:1e-3:160;

for i=1:size(interictalMean,2)
    mu = interictalMean(i); 
    sigma = sqrt(interictalVariance(i));
    y = pdf('normal', x, mu, sigma);
    plot(x,y,'-s','Color',cmap(i,:));
    hold on 
end

