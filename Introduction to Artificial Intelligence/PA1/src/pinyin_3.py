import json
import math
import sys

cmdoutput=0
ans=[]
freq2c={}
freq3c={}
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
tempfile=open('c3freq.json','r')
freq3c=json.load(tempfile)
tempfile.close()
print("Data Loaded.")

def make_array(w,h,val):
	tmplis=[]
	for i in range(w):
		tmprow=[]
		for j in range(h):
			tmprow.append(val)
		tmplis.append(tmprow)
	return tmplis

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

def calcp_log3(c1,s1,c2,s2,c3,s3):
	stich=c1+" "+s1+" "+c2+" "+s2+" "+c3+" "+s3
	if stich not in freq3c:
		f123=0
	else:
		f123=freq3c[stich]
	stich2=c1+" "+s1+" "+c2+" "+s2
	if stich2 not in freq2c:
		f12=0
	else:
		f12=freq2c[stich2]
	f1=freq1c[c1+" "+s1]
	alp=0.00000000001
	if f12==0:
		tmp=alp*f1
	else:
		tmp=alp*f1+(1-alp)*f123/f12
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
		if i==0:
			dp.append(make_array(splen[i],1,-10000000.0))
			fr.append(make_array(splen[i],1,0))
			for j in range(0,splen[i]):
				if infreq1c(spelltochar[words[i]][j]+" "+words[i])==True:
					dp[i][j][0]=math.log(freq1c[spelltochar[words[i]][j]+" "+words[i]],2)
		if i==1:
			dp.append(make_array(splen[i],splen[i-1],-10000000.0))
			fr.append(make_array(splen[i],splen[i-1],0))
			for j in range(0,splen[i]):
				for k in range(0,splen[i-1]):
					if infreq1c(spelltochar[words[i]][j]+" "+words[i])==True:
						if infreq1c(spelltochar[words[i-1]][k]+" "+words[i-1])==True:
							dp[i][j][k]=dp[i-1][k][0]+calcp_log2(spelltochar[words[i-1]][k],words[i-1],spelltochar[words[i]][j],words[i])
		if i>1:
			dp.append(make_array(splen[i],splen[i-1],-10000000.0))
			fr.append(make_array(splen[i],splen[i-1],0))
			for j in range(0,splen[i]):
				for k in range(0,splen[i-1]):
					if infreq1c(spelltochar[words[i]][j]+" "+words[i])==True:
						if infreq1c(spelltochar[words[i-1]][k]+" "+words[i-1])==True:
							for l in range(0,splen[i-2]):
								if infreq1c(spelltochar[words[i-2]][l]+" "+words[i-2])==True:
									res=dp[i-1][k][l]+calcp_log3(spelltochar[words[i-2]][l],words[i-2],spelltochar[words[i-1]][k],words[i-1],spelltochar[words[i]][j],words[i])
									if res>dp[i][j][k]:
										dp[i][j][k]=res
										fr[i][j][k]=l
	tmpstr=""
	plc1=-1
	plc2=-1
	mxv=-100000.0
	for i in range(0,splen[n-1]):
		for j in range(0,splen[n-2]):
			if dp[n-1][i][j]>mxv:
				mxv=dp[n-1][i][j]
				plc1=i
				plc2=j
	for i in range(n-1,-1,-1):
		tmpstr=spelltochar[words[i]][plc1]+tmpstr
		tmpint=plc2
		plc2=fr[i][plc1][plc2]
		plc1=tmpint
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
	if cntlines%20==0:
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
