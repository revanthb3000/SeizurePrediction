import os

for fileName in os.listdir(os.getcwd()):
    if("SequenceAverageInterictalPlot" in fileName):
        print fileName
        os.rename(fileName,fileName.replace("SequenceAverageInterictalPlot","SequenceAveragePreictalPlot"))
