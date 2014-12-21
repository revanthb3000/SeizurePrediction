fileHandle = open('latexSnippet.txt','r')
latexTemplate = fileHandle.read()
fileHandle.close()

fileHandle = open('input.txt','r')

subject = ''
errors = [{},{},{}]
precisions = [{},{},{}]
recalls = [{},{},{}]
fMeasures = [{},{},{}]
avgErrors = {}

numTestingPoints = 0
foldNumber = 0

for line in fileHandle.readlines():
	if(('Dog_' in line) or ('Patient_' in line)):
		subject = line.strip().replace('_',' ')
		#print "\n" + subject
	elif('testing data points' in line):
		numTestingPoints = int(line.split(":")[1].strip())
#print "Num Testing Points : " + str(numTestingPoints)
	elif('Error = ' in line):
		error = float(line.split('=')[1].strip())
		error = (error*100.0)/numTestingPoints
		errors[foldNumber%3][subject] = error
#		print "Fold : " + str(foldNumber%3)
#		print "Error : " + str(error)
	elif('Precision = ' in line):
		precision = float(line.split('=')[1].strip())
		precisions[foldNumber%3][subject] = precision
#		print "Precision : " + str(precision)
	elif('Recall = ' in line):
		recall = float(line.split('=')[1].strip())
		recalls[foldNumber%3][subject] = recall
#		print "Recall : " + str(recall)
	elif('F-Measure' in line):
		fMeasure = float(line.split('=')[1].strip())
		fMeasures[foldNumber%3][subject] = fMeasure
#		print "F-Measure : " + str(fMeasure)
		foldNumber += 1
	elif('Average Error : ' in line):
		avgError = float(line.split(':')[1].strip())
		avgError = (avgError*100.0)/numTestingPoints
		avgErrors[subject] = avgError
#		print "Average Error : " + str(avgError)
	

#print errors
#print precisions
#print recalls
#print fMeasures
#print avgErrors

for i in range(1,6):
	subject = 'Dog ' + str(i)
	for j in range(1,4):
		replacementString = '{$d'+ str(i)  +'e' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % errors[j-1][subject])
		replacementString = '{$d'+ str(i)  +'p' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % precisions[j-1][subject])
		replacementString = '{$d'+ str(i)  +'r' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % recalls[j-1][subject])
		replacementString = '{$d'+ str(i)  +'f' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % fMeasures[j-1][subject])
	replacementString = '{$d'+ str(i)  +'eMean}'
	latexTemplate = latexTemplate.replace(replacementString,"%.2f" % avgErrors[subject])

for i in range(1,3):
	subject = 'Patient ' + str(i)
	for j in range(1,4):
		replacementString = '{$pat'+ str(i)  +'e' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % errors[j-1][subject])
		replacementString = '{$pat'+ str(i)  +'p' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % precisions[j-1][subject])
		replacementString = '{$pat'+ str(i)  +'r' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % recalls[j-1][subject])
		replacementString = '{$pat'+ str(i)  +'f' + str(j)  +  '}'
		latexTemplate = latexTemplate.replace(replacementString,"%.2f" % fMeasures[j-1][subject])
	replacementString = '{$pat'+ str(i)  +'eMean}'
	latexTemplate = latexTemplate.replace(replacementString,"%.2f" % avgErrors[subject])

fileHandle.close()

writer = open('latexCode.txt','w')
writer.write(latexTemplate)
writer.close()