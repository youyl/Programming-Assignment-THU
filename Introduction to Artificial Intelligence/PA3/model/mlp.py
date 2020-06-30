import torch
import torch.nn as nn
import torch.nn.functional as F

class Mlp(nn.Module):
	def __init__(self):
		super(Mlp,self).__init__()
		self.final=nn.Linear(150000,8)

	def forward(self,x):
		#[45,150000]
		output=self.final(x)#[45,8]
		return output