运行环境：
以下是本地测试运行环境，可以在相同环境下运行：
显卡：GTX1060
显存：6G
内存：16G
Python 3.7.5
Torch 1.5.0
Numpy 1.18.1
Scipy 1.4.1
Matplotlib 3.1.3
Torchvision 0.6.0
Cuda 10.2.150

运行步骤：
分为两种情况：完整运行流程和仅测试训练结果

仅测试训练结果：
首先进入model目录
然后使用load_and_test.py进行测试
测试方法举例：python load_and_test.py cnn_10.pth
然后就会在model_res.txt中加入最新测试的结果（接在最后）

完整运行流程：
首先将data文件夹下和src文件夹下的东西放到同一个目录里
然后从pdf中给出的网址中下载词向量，下载的是mixed-large中的word 300d
解压后文件名应当为sgns.merge.word，将其放到同一个目录下，接下来按照报告里的实验步骤即可
注意最后一步load_and_test.py需要在命令行执行的时候加上一个文件名参数