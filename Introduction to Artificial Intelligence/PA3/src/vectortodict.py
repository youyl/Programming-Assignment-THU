import json

file=open('sgns.merge.word','r',encoding='utf-8')
lists=file.readlines()
file.close()
print(lists[0])
lists=lists[1:]

cnt=0
dict={}
for line in lists:
	words=line.split()
	cha=words[0]
	words=words[1:]
	vals=[]
	for i in range(0,300):
		vals.append(float(words[i]))
	dict[cha]=vals
	cnt=cnt+1
	if cnt%10000==0:
		print(cnt)
print(len(dict))

file=open('wordvec.json','w')
json.dump(dict,file)
file.close()