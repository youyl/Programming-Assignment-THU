import json
import math
import sys

cmdoutput=0
ans=[]
freq2c={}
freq1c={}
spelltochar={}
tempfile=open('spelltochar.json','r')
spelltochar=json.load(tempfile)
tempfile.close()
tempfile=open('c1freq.json','r')
freq1c=json.load(tempfile)
tempfile.close()
tempfile=open('c2freq.json','r')
freq2c=json.load(tempfile)
tempfile.close()
print("Data Loaded.")

def calcp_log2(c1,s1,c2,s2):
	stich=c1+" "+s1+" "+c2+" "+s2
	if stich not in freq2c:
		f12=0
	else:
		f12=freq2c[stich]
	f1=freq1c[c1+" "+s1]
	alp=0.000000000001
	tmp=alp*f1+(1-alp)*f12/f1
	return math.log(tmp,2)

def infreq1c(s1):
	if s1 in freq1c:
		return True
	else:
		return False

def processline(line):
	words=line.split()
	fr=[]
	dp=[]
	splen=[]
	n=len(words)
	if n==0:
		return
	for i in range(0,n):
		words[i]=words[i].lower()
		if words[i] not in spelltochar:
			print("Input Error!")
			return
		splen.append(len(spelltochar[words[i]]))
	for i in range(0,n):
		temparray=[]
		for j in range(0,splen[i]):
			temparray.append(-10000000.0)
		fr.append(temparray)
		temparray=[]
		for j in range(0,splen[i]):
			temparray.append(-10000000.0)
		dp.append(temparray)
		if i==0:
			for j in range(0,splen[i]):
				if infreq1c(spelltochar[words[i]][j]+" "+words[i])==True:
					dp[i][j]=math.log(freq1c[spelltochar[words[i]][j]+" "+words[i]],2);
		else:
			for j in range(0,splen[i]):
				if infreq1c(spelltochar[words[i]][j]+" "+words[i])==True:
					for k in range(0,splen[i-1]):
						if infreq1c(spelltochar[words[i-1]][k]+" "+words[i-1])==True:
							res=dp[i-1][k]+calcp_log2(spelltochar[words[i-1]][k],words[i-1],spelltochar[words[i]][j],words[i])
							if res>dp[i][j]:
								dp[i][j]=res
								fr[i][j]=k
	tmpstr=""
	plc=-1
	mxv=-10000000.0
	for i in range(0,splen[n-1]):
		if dp[n-1][i]>mxv:
			mxv=dp[n-1][i]
			plc=i
	for i in range(n-1,-1,-1):
		tmpstr=spelltochar[words[i]][plc]+tmpstr
		plc=fr[i][plc]
	ans.append(tmpstr)

if len(sys.argv)!=3:
	print("Illegal Parameter!")
	sys.exit()
	
inputfilename=sys.argv[1]
outputfilename=sys.argv[2]

inputfile=open(inputfilename,'r')
lines=inputfile.readlines()
cntlines=0
for str in lines:
	processline(str)
	cntlines+=1
	if cntlines%100==0:
		print(cntlines,"Lines Complete.")
inputfile.close()

outputfile=open(outputfilename,'w')
for str in ans:
	outputfile.write(str+'\n')
outputfile.close()

print("Finished.")

if cmdoutput==1:
	n=len(lines)
	for i in range(0,n):
		print(lines[i])
		print(ans[i])
