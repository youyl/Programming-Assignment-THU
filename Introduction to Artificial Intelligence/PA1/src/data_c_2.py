import json
from pypinyin import lazy_pinyin

cnt=0
linecnt=0
cntc=0
freq={}
chartospell={}
tempfile=open('chartospell.json','r')
chartospell=json.load(tempfile)
tempfile.close()

def inserttuplesimple(tup):
	if tup not in freq:
		freq[tup]=0
	freq[tup]+=1

def inserttuplehard(tup):
	if tup not in freq:
		freq[tup]=0
	freq[tup]+=5

def stringprocess(sentence):
	global cnt
	global cntc
	n=len(sentence)
	if n>1:
		spell=lazy_pinyin(sentence)
		for i in range(0,n):
			if spell[i] not in chartospell[sentence[i:i+1]]:
				spell[i]=chartospell[sentence[i:i+1]][0]
		for i in range(0,n-1):
			inserttuplesimple(sentence[i:i+1]+" "+spell[i]+" "+sentence[i+1:i+2]+" "+spell[i+1])
			cntc+=1
			if cntc%1000000==0:
				print("Complete ",cntc," Characters!")
		cnt+=1
		if cnt%50000==0:
			print("Complete ",cnt," sentences!")

def fileread(filename):
	global linecnt
	file=open(filename,'r')
	list=file.readlines()
	for str in list:
		dict=json.loads(str)
		words=dict['html']
		curlist=""
		l=len(words)
		for i in range(0,l):
			tmpstr=words[i:i+1]
			if tmpstr not in chartospell:
				stringprocess(curlist)
				curlist=""
			else:
				curlist+=tmpstr
		linecnt+=1
		if linecnt%1000==0:
			print("Complete ",linecnt," lines!")
	file.close()

fileread("../traindata/2016-02.txt")
fileread("../traindata/2016-04.txt")
fileread("../traindata/2016-05.txt")
fileread("../traindata/2016-06.txt")
fileread("../traindata/2016-07.txt")
fileread("../traindata/2016-08.txt")
fileread("../traindata/2016-09.txt")
fileread("../traindata/2016-10.txt")
fileread("../traindata/2016-11.txt")

print(len(freq))
tempfile=open("c2freq.json",'w')
json.dump(freq,tempfile)
tempfile.close()
