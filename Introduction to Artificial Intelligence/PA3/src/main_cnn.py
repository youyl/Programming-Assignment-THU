import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.autograd as autograd
import cnn
import json
import random
import os

baselrate=500
lrate=baselrate/100000.0
print("Learning Rate:",lrate)
epochnum=200
idx=[]
for i in range(0,2342):
	idx.append(i)

model=cnn.Cnn()
model.cuda()
optimizer=torch.optim.Adam(model.parameters(),lr=lrate,weight_decay=1e-5)

file=open('traindata.json','r')
data=json.load(file)
file.close()

file=open('trainlabel.json','r')
label=json.load(file)
file.close()

print("Training Set Loaded")

file=open('validdata.json','r')
validdata=json.load(file)
file.close()

file=open('validlabel.json','r')
validlabel=json.load(file)
file.close()

print("Valid Set Loaded")

batchcnt=0
validloss=[]
validacc=[]
bestloss=10000.0
issaved=False
lastbest=0

for epoch in range(0,epochnum):
	random.shuffle(idx)
	for st in range(0,52):
		batchstart=st*45
		batchend=batchstart+45
		'''
		get batch and target
		'''
		target=torch.Tensor(45)#[45]
		input=torch.Tensor(data[idx[batchstart]]).unsqueeze(0)#[1,500,300]
		for iter in range(batchstart+1,batchend):
			i=idx[iter]
			#print(iter," ",i)
			lbval=label[i].index(1)
			target[iter-batchstart]=lbval
			tmp=torch.Tensor(data[i]).unsqueeze(0)
			input=torch.cat((input,tmp),0)
		target=target.long()
		'''
		train
		'''
		model.train()
		input=input.cuda()
		target=target.cuda()
		optimizer.zero_grad()
		output=model(input)#[45,8]
		loss=F.cross_entropy(output,target)
		loss.backward()
		optimizer.step()
		
		batchcnt=batchcnt+1
		if batchcnt%25==0:
			print("Batch No.",batchcnt," Complete")
	'''
	eval on valid
	'''
	model.eval()
	sumloss=0.0
	accu=0
	for i in range(0,600):
		target=torch.Tensor(1)
		target[0]=validlabel[i].index(1)
		input=torch.Tensor(validdata[i]).unsqueeze(0)
		target=target.long()
		input=input.cuda()
		target=target.cuda()
		output=model(input)#[1,8]
		loss=F.cross_entropy(output,target)
		sumloss=sumloss+loss.item()
		res=torch.max(output,1)[1]
		if target.item()==res.item():
			accu=accu+1
	print("Epoch No.",epoch)
	print("Loss on Valid ",sumloss)
	print("Acc on Valid ",accu," ",accu/600.0)
	validloss.append(sumloss)
	validacc.append(accu/600.0)
	if sumloss<bestloss*0.99:
		bestloss=sumloss
		lastbest=epoch
		torch.save(model,"cnn_"+str(baselrate)+".pth")
		issaved=True
	else:
		if epoch-lastbest>=12:
			print("Early Stop at Epoch ",epoch)
			break
	print("Best Loss ",bestloss," On Epoch ",lastbest)

file=open("cnn_valid_loss_"+str(baselrate)+".json","w")
json.dump(validloss,file)
file.close()

file=open("cnn_valid_acc_"+str(baselrate)+".json","w")
json.dump(validacc,file)
file.close()

if issaved==False:
	print("Final Save Without Early Stopping")
	torch.save(model,"cnn_"+str(baselrate)+".pth")
