/********************************************************
*	Strategy.h : 策略接口文件                           *
*	张永锋                                              *
*	zhangyf07@gmail.com                                 *
*	2010.8                                              *
*********************************************************/

#ifndef STRATEGY_H_
#define	STRATEGY_H_

#include "Point.h"
#include <cmath>
#include <ctime>
#include <iostream>
#include <cstring>
#include <cstdlib>

//using std::cerr;
//using std::endl;

Point* getPoint(const int M, const int N, const int* top, const int* _board, 
	const int lastX, const int lastY, const int noX, const int noY);

void clearPoint(Point* p);

void clearArray(int M, int N, int** board);

/*
	添加你自己的辅助函数
*/

class selfQueue
{
	private:
		int head,tail;
		int val[2200000];
	public:
		inline void clear()
		{
			head=0;
			tail=0;
		}
		inline void push(int x)
		{
			tail++;
			if(tail>=2000000)tail-=2000000;
			val[tail]=x;
		}
		inline int pop()
		{
			head++;
			if(head>=2000000)head-=2000000;
			return val[head];
		}
};

class UCTClass
{
	private:
		int root,nodecnt,n,m,totsize,nox,noy,numstats,lastplayed;
		int size[2000000];
		int curboard[25][25],rootboard[25][25],curtop[25],roottop[25];
		int edge[20][2000000],fat[2000000];
		int N[2000000],stat[2000000];//0--unknown;1,2--win;3---draw
		int myturn[2000000];
		double confi[2000000],Q[2000000],preln[2000000];
		selfQueue unusednode;
		
		inline void updateconfi_ucb1(int x)
		{
			confi[x]=Q[x]/N[x]+(std::sqrt(preln[N[fat[x]]]/N[x]));
		}
		
		inline int pickdicision()
		{
			int tmp=-1;
			for (int i=0;i<n;i++)
			{
				if(edge[i][root]!=0)tmp=i;
			}
			for (int i=0;i<n;i++)
			{
				if(edge[i][root]!=0)
				{
					//cerr<<i<<':'<<N[edge[i][root]]<<' '<<Q[edge[i][root]]<<' '<<Q[edge[i][root]]/N[edge[i][root]]<<endl;
					if((Q[edge[i][root]]/N[edge[i][root]])>(Q[edge[tmp][root]]/N[edge[tmp][root]]))tmp=i;
				}
			}//cerr<<endl;
			return tmp;
		}
		
		inline void placeoncurnojudge(int y,int id)
		{
			int x=curtop[y]-1;
			int cx=x+4,cy=y+4;
			curboard[cx][cy]=id;
			if(noy==y&&nox==curtop[y]-2)curtop[y]-=2;
			else curtop[y]--;
		}
		
		inline bool placeoncur(int y,int id)
		{
			int x=curtop[y]-1;
			int cx=x+4,cy=y+4,c1=0,c2=0,c3=0,c4=0,c5=0,c6=0,c7=0,c8=0;
			curboard[cx][cy]=id;
			if(noy==y&&nox==curtop[y]-2)curtop[y]-=2;
			else curtop[y]--;
			while ((curboard[cx+c1+1][cy]&id))c1++;
			while ((curboard[cx-c2-1][cy]&id))c2++;
			while ((curboard[cx][cy+c3+1]&id))c3++;
			while ((curboard[cx][cy-c4-1]&id))c4++;
			while ((curboard[cx+c5+1][cy+c5+1]&id))c5++;
			while ((curboard[cx-c6-1][cy-c6-1]&id))c6++;
			while ((curboard[cx+c7+1][cy-c7-1]&id))c7++;
			while ((curboard[cx-c8-1][cy+c8+1]&id))c8++;
			if(c1+c2>2)return true;
			if(c3+c4>2)return true;
			if(c5+c6>2)return true;
			if(c7+c8>2)return true;
			return false;
		}
		
		inline void rootmove(int y,int id)
		{
			int x=roottop[y]-1;
			int cx=x+4,cy=y+4;
			rootboard[cx][cy]=id;
			if(noy==y&&nox==roottop[y]-2)roottop[y]-=2;
			else roottop[y]--;
		}
		
		int expand(int x)
		{
			for (int i=0;i<n;i++)
			{
				if(edge[i][x]==0&&curtop[i]!=0)
				{
					int c=unusednode.pop();
					edge[i][x]=c;
					fat[c]=x;
					N[c]=0;
					nodecnt++;
					Q[c]=0;
					size[c]=size[x]+1;
					myturn[c]=3-myturn[x];
					for (int j=0;j<n;j++)
					{
						edge[j][c]=0;
					}
					if(placeoncur(i,myturn[x]))
					{
						stat[c]=myturn[x];
						Q[x]=-1e10;
						Q[c]=1e10;
					}
					else if(size[c]==totsize)stat[c]=3;
					else stat[c]=0;
					return c;
				}
			}
			return -1;
		}
		
		int bestchild(int x)
		{
			int bestc=0;
			for (int i=0;i<n;i++)
			{
				if(confi[edge[bestc][x]]<confi[edge[i][x]])bestc=i;
			}
			return bestc;
		}
		
		int treepolicy(int x)
		{
			int y;
			while (1)
			{
				if(stat[x]!=0)return x;
				y=expand(x);
				if(y==-1)
				{
					y=bestchild(x);
					placeoncurnojudge(y,myturn[x]);
					x=edge[y][x];
				}
				else return y;
			}
		}
		
		double defaultpolicy(int x)//draw=0,lose=-1,win=1
		{
			if(stat[x]==1||stat[x]==2)
			{
				if(stat[x]==myturn[x])return -1;
				else return 1;
			}
			if(stat[x]==3)return 0;
			numstats++;
			int numrem=0,rem[20],pos;
			int tmpid=myturn[x];
			for (int i=0;i<n;i++)
			{
				if(curtop[i]!=0)
				{
					rem[numrem]=i;
					numrem++;
				}
			}
			while (1)
			{
				pos=(std::rand())%numrem;
				if(placeoncur(rem[pos],tmpid))
				{
					if(tmpid!=myturn[x])return 1;
					return -1;
				}
				if(curtop[rem[pos]]==0)
				{
					for (int i=pos;i<numrem-1;i++)
					{
						rem[i]=rem[i+1];
					}
					numrem--;
					if(numrem==0)return 0;
				}
				tmpid=3-tmpid;
			}
		}
		
		void backup(int x,double val)
		{
			while (x!=root)
			{
				N[x]++;
				Q[x]+=val;
				val=-val;
				for (int i=0;i<n;i++)
				{
					if(edge[i][x]!=0)updateconfi_ucb1(edge[i][x]);
				}
				x=fat[x];
			}
			N[x]++;
			for (int i=0;i<n;i++)
			{
				if(edge[i][x]!=0)updateconfi_ucb1(edge[i][x]);
			}
		}
		
		void releasenode(int x)
		{
			unusednode.push(x);
			nodecnt--;
			for (int i=0;i<n;i++)
			{
				if(edge[i][x]!=0)releasenode(edge[i][x]);
			}
		}
		
	public:
		int uctstrategy(int lastx,int lasty,const int *top,const int *board)
		{
			int start_clock=std::clock();
			std::srand(std::time(0));
			numstats=0;
			for (int i=0;i<n;i++)
			{
				if(edge[i][root]!=0)
				{
					if(i!=lastplayed)
					{
						releasenode(edge[i][root]);
					}
				}
			}
			root=edge[lastplayed][root];
			rootmove(lastplayed,2);
			if(root!=0)
			{
				for (int i=0;i<n;i++)
				{
					if(edge[i][root]!=0)
					{
						if(i!=lasty)
						{
							releasenode(edge[i][root]);
						}
					}
				}
				root=edge[lasty][root];
			}
			rootmove(lasty,1);
			if(root==0)
			{
				nodecnt++;
				root=unusednode.pop();
				N[root]=0;
				Q[root]=0;
				size[root]=0;
				for (int i=0;i<m;i++)
				{
					for (int j=0;j<n;j++)
					{
						if(board[i*n+j]!=0)size[root]++;
					}
				}
				myturn[root]=2;
				stat[root]=0;
				for (int i=0;i<m+8;i++)
				{
					for (int j=0;j<n+8;j++)
					{
						rootboard[i][j]=0;
					}
				}
				for (int i=0;i<m;i++)
				{
					for (int j=0;j<n;j++)
					{
						rootboard[i+4][j+4]=board[i*n+j];
					}
				}
				for (int i=0;i<n;i++)
				{
					roottop[i]=top[i];
				}
				for (int i=0;i<n;i++)
				{
					edge[i][root]=0;
				}
			}
			//---------------------------------
			/*for (int i=0;i<m;i++)
			{
				for (int j=0;j<n;j++)cerr<<rootboard[i+4][j+4]<<' ';
				cerr<<endl;
			}
			for (int i=0;i<n;i++)
			{
				cerr<<i<<':'<<roottop[i]<<' ';
			}cerr<<endl;*/
			//-----------------------------------
			//cerr<<"Start Uct Process! "<<nodecnt<<endl;
			while (1.0*(std::clock()-start_clock)<2.7*(CLOCKS_PER_SEC)&&nodecnt<1950000&&N[root]<1950000)
			{
				for (int i=0;i<m;i++)
				{
					for (int j=0;j<n;j++)
					{
						curboard[i+4][j+4]=rootboard[i+4][j+4];
					}
				}
				for (int i=0;i<n;i++)
				{
					curtop[i]=roottop[i];
				}
				int xnode=treepolicy(root);
				double xval=defaultpolicy(xnode);
				backup(xnode,xval);
			}
			//cerr<<numstats<<' '<<nodecnt<<endl;
			lastplayed=pickdicision();
			return lastplayed;
		}
		
		int init(const int _m,const int _n,const int *top, const int* board,int lastx,int lasty,int _nox,int _noy)
		{
			int start_clock=std::clock();
			std::srand(std::time(0));
			numstats=0;
			confi[0]=-1e14;
			nox=_nox;
			noy=_noy;
			n=_n;
			m=_m;
			unusednode.clear();
			for (int i=1;i<1980000;i++)
			{
				preln[i]=std::log(i);
				unusednode.push(i);
			}
			for (int i=0;i<m+8;i++)
			{
				for (int j=0;j<n+8;j++)
				{
					rootboard[i][j]=0;
				}
			}
			for (int i=0;i<m;i++)
			{
				for (int j=0;j<n;j++)
				{
					rootboard[i+4][j+4]=board[i*n+j];
				}
			}
			for (int i=0;i<n;i++)
			{
				roottop[i]=top[i];
			}
			nodecnt=1;
			totsize=n*m-1;
			root=unusednode.pop();
			N[root]=0;
			Q[root]=0;
			if(lastx!=-1)size[root]=1;
			else size[root]=0;
			myturn[root]=2;
			stat[root]=0;
			for (int i=0;i<n;i++)
			{
				edge[i][root]=0;
			}
			//---------------------------------
			/*for (int i=0;i<m;i++)
			{
				for (int j=0;j<n;j++)cerr<<rootboard[i+4][j+4]<<' ';
				cerr<<endl;
			}
			for (int i=0;i<n;i++)
			{
				cerr<<i<<':'<<roottop[i]<<' ';
			}cerr<<endl;*/
			//-----------------------------------
			//cerr<<"init uct process "<<n<<' '<<m<<endl;
			while (1.0*(std::clock()-start_clock)<2.7*(CLOCKS_PER_SEC)&&nodecnt<1950000&&N[root]<1950000)
			{
				for (int i=0;i<m;i++)
				{
					for (int j=0;j<n;j++)
					{
						curboard[i+4][j+4]=rootboard[i+4][j+4];
					}
				}
				for (int i=0;i<n;i++)
				{
					curtop[i]=roottop[i];
				}
				int xnode=treepolicy(root);
				double xval=defaultpolicy(xnode);
				backup(xnode,xval);
			}
			//cerr<<numstats<<' '<<nodecnt<<endl;
			lastplayed=pickdicision();
			return lastplayed;
		}
};

#endif