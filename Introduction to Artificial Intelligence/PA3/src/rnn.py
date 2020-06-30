import torch
import torch.nn as nn
import torch.nn.functional as F

class Rnn(nn.Module):
	def __init__(self):
		super(Rnn,self).__init__()
		self.lstm=nn.LSTM(input_size=300,hidden_size=150,bidirectional=True)
		self.final=nn.Linear(600,8)

	def forward(self,x):
		tmp1,tmp2=self.lstm(x)#[500,45,300]
		x=torch.cat((tmp1[0],tmp1[-1]),1)#[45,600]
		output=self.final(x)#[45,8]
		return output