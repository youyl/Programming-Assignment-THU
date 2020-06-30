import torch
import torch.nn as nn
import torch.nn.functional as F

class Cnn(nn.Module):
	def __init__(self):
		super(Cnn,self).__init__()
		self.conv1=nn.Conv2d(1,100,(3,300))
		self.conv2=nn.Conv2d(1,100,(4,300))
		self.conv3=nn.Conv2d(1,100,(5,300))
		self.dpout=nn.Dropout(0.5)
		self.final=nn.Linear(300,8)

	def forward(self,x):
		x=x.unsqueeze(1)#[45,1,500,300]
		
		x1=F.relu(self.conv1(x))#[45,100,298,1]
		x1=x1.squeeze(3)#[45,100,298]
		x1=F.max_pool1d(x1,x1.size(2))#[45,100,1]
		x1=x1.squeeze(2)#[45,100]
		
		x2=F.relu(self.conv2(x))#[45,100,297,1]
		x2=x2.squeeze(3)#[45,100,297]
		x2=F.max_pool1d(x2,x2.size(2))#[45,100,1]
		x2=x2.squeeze(2)#[45,100]
		
		x3=F.relu(self.conv3(x))#[45,100,296,1]
		x3=x3.squeeze(3)#[45,100,296]
		x3=F.max_pool1d(x3,x3.size(2))#[45,100,1]
		x3=x3.squeeze(2)#[45,100]
		
		x=torch.cat((x1,x2,x3),1)#[45,300]
		x=self.dpout(x)#[45,300]
		output=self.final(x)#[45,8]
		return output