import json

charlistfile=open("charlist.txt",mode='r')
lines=charlistfile.readlines()
n=0
chartospell={}
spelltochar={}
for line in lines:
	words=line.split()
	spell=words[0]
	words=words[1:]
	spelltochar[spell]=[]
	for word in words:
		if word not in chartospell:
			chartospell[word]=[]
		chartospell[word].append(spell)
		spelltochar[spell].append(word)
charlistfile.close()

print(len(chartospell))

charfile=open("chartospell.json",'w')
spellfile=open("spelltochar.json",'w')
json.dump(chartospell,charfile)
json.dump(spelltochar,spellfile)
charfile.close()
spellfile.close()