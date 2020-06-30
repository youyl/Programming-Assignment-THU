import sys

if len(sys.argv)!=2:
	print("Error Check Input!")
	sys.exit()

caseidx=sys.argv[1]
print("TestCase ",caseidx,":")
outputfilename="../data/case"+caseidx+".out"
answerfilename="../data/case"+caseidx+".ans"

outputfile=open(outputfilename,'r')
answerfile=open(answerfilename,'r',encoding='utf-8')

outputlist=outputfile.readlines()
answerlist=answerfile.readlines()

lines=len(outputlist)
correctlines=0
chars=0
correctchars=0

for i in range(0,lines):
	output=outputlist[i].split()[0]
	answer=answerlist[i].split()[0]
	'''
	print(output)
	print(answer)
	'''
	if output==answer:
		correctlines+=1
	ll=len(output)
	if len(output)!=len(answer):
		print(output)
		print(answer)
	chars+=ll
	for j in range(0,ll):
		if output[j]==answer[j]:
			correctchars+=1

print("Total Lines =",lines)
print("Correct Lines =",correctlines)
print("Correct Rate =",correctlines*1.0/lines)
print("Total Chars =",chars)
print("Correct Chars =",correctchars)
print("Correct Rate =",correctchars*1.0/chars)