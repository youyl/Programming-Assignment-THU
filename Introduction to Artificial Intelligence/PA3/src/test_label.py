import json

file=open('wordvec.json','r')
dict=json.load(file)
file.close()

cutlen=500

file=open('sinanews.test','r',encoding='utf-8')
lines=file.readlines()
file.close()
data=[]
label=[]
for str in lines:
	splitstr=str.split()
	scorename=splitstr[2:10]
	score=[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]
	for i in range(0,8):
		ss=scorename[i]
		sslist=ss.split(':')
		score[i]=float(sslist[1])
	print(score)
	words=splitstr[10:]
	tmpvec=[]
	tmpscore=[]
	for word in words:
		if word in dict:
			tmpvec.append(dict[word])
		if len(tmpvec)==cutlen:
			break
	while len(tmpvec)<cutlen:
		zerov=[]
		for i in range(0,300):
			zerov.append(0)
		tmpvec.append(zerov)
	if len(tmpvec)!=cutlen:
		print("Vec len Error!")
	data.append(tmpvec)
	mxval=max(score)
	tmplb=[0,0,0,0,0,0,0,0]
	for i in range(0,8):
		if score[i]==mxval:
			tmplb[i]=1
			break
	label.append(tmplb)

trainlabelfile=open('testlabel.json','w')
json.dump(label,trainlabelfile)
trainlabelfile.close()

traindatafile=open('testdata.json','w')
json.dump(data,traindatafile)
traindatafile.close()
