import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.autograd as autograd
import cnn
import json
import random
import os
import sys
import numpy as np
from scipy.stats import pearsonr

is_cnn=False
is_rnn=False
is_mlp=False

if len(sys.argv)!=2:
	print("Error!")
	sys.exit(0)
print(sys.argv[1])
filename=sys.argv[1]
model=torch.load(filename)
model.cuda()
print("Model Loaded")

if filename[0:3]=="cnn":
	is_cnn=True
if filename[0:3]=="mlp":
	is_mlp=True
if filename[0:3]=="rnn":
	is_rnn=True
print(is_cnn,is_mlp,is_rnn)

file=open('testdata.json','r')
data=json.load(file)
file.close()

file=open('testlabel.json','r')
label=json.load(file)
file.close()

results=[]

print("Test Set Loaded")

model.eval()
accu=0

f1s=0.0
corrcef=0.0
f_matrix=[[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0]]

for i in range(0,2228):
	target=torch.Tensor(1)
	target[0]=label[i].index(1)
	if is_cnn==True:
		input=torch.Tensor(data[i]).unsqueeze(0)#cnn
	if is_mlp==True:
		input=torch.Tensor(data[i]).view(1,150000)#mlp
	if is_rnn==True:
		input=torch.Tensor(data[i]).unsqueeze(1)#rnn
	target=target.long()
	input=input.cuda()
	target=target.cuda()
	output=model(input)#[1,8]
	loss=F.cross_entropy(output,target)
	res=torch.max(output,1)[1]
	if target.item()==res.item():
		accu=accu+1
	aa=int(target.item()+0.00001)
	bb=int(res.item()+0.00001)
	f_matrix[aa][bb]=f_matrix[aa][bb]+1
	corr_pred=[]
	corr_fact=[]
	for j in range(0,8):
		corr_fact.append(float(label[i][j]))
		corr_pred.append(float(output[0][j]))
	corrf1=np.array(corr_fact)
	corrf2=np.array(corr_pred)
	corrcef=corrcef+pearsonr(corrf1,corrf2)[0]

print("Test Acc: ",accu," ",accu/2228.0)

#calc f1

epsi=1e-8
for idxx in range(0,8):
	f_final=[[0,0],[0,0]]
	for i in range(0,8):
		for j in range(0,8):
			if(i==j):
				if i==idxx:
					f_final[0][0]=f_final[0][0]+f_matrix[i][j]#i
			else:
				if i==idxx:
					f_final[0][1]=f_final[0][1]+f_matrix[i][j]#i
				if j==idxx:
					f_final[1][0]=f_final[1][0]+f_matrix[i][j]#j
	micro_r=f_final[0][0]/(f_final[0][0]+f_final[1][0]+epsi)
	micro_p=f_final[0][0]/(f_final[0][0]+f_final[0][1]+epsi)
	f1s=f1s+2*micro_p*micro_r/(micro_p+micro_r+epsi)
f1s=f1s/8.0
print("Macro F1: ",f1s)

#calc corr

corrcef=corrcef/2228.0

file=open("model_res.txt","a")
file.write(filename+":\n")
file.write("Test Accu: "+str(accu/2228.0)+"\n")
file.write("F1 Score: "+str(f1s)+"\n")
file.write("Corr: "+str(corrcef)+"\n"+"\n")