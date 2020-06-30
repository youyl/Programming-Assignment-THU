library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity squarer is--平方器，输入4位，输出8位
	port(
		input:in std_logic_vector(3 downto 0);
		output:out std_logic_vector(7 downto 0)
	);
end squarer;

architecture compute of squarer is
	signal tmp1,tmp2,tmp3,tmp4:std_logic_vector(7 downto 0);
begin
	process(input)--行为描述的平方器，枚举每一位是否是1，是1则左移，然后存入对应变量
	begin
		if(input(0)='1') then
			tmp1<="0000"&input;
		else
			tmp1<="00000000";
		end if;
		if(input(1)='1') then
			tmp2<="000"&input&"0";
		else
			tmp2<="00000000";
		end if;
		if(input(2)='1') then
			tmp3<="00"&input&"00";
		else
			tmp3<="00000000";
		end if;
		if(input(3)='1') then
			tmp4<="0"&input&"000";
		else
			tmp4<="00000000";
		end if;
	end process;
	process(tmp1,tmp2,tmp3,tmp4)--控制输出永远是tmp1到tmp4的和
	begin
		output<=tmp1+tmp2+tmp3+tmp4;
	end process;
end compute;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparator4 is--四位比较器，输入两个四位二进制数，输出gre表示res>ans，equ表示res==ans
	port(
		res,ans:in std_logic_vector(3 downto 0);
		gre,equ:out std_logic
	);
end comparator4;

architecture compare of comparator4 is
	signal g,e:std_logic_vector(3 downto 0);--用于比较的临时变量，g表示res>ans，e表示res=ans（对应位置）
begin
	process(res,ans)--计算g和e
	begin
		g(3)<=(res(3) and (not ans(3)));
		e(3)<=(not (res(3) xor ans(3)));
		g(2)<=(res(2) and (not ans(2)));
		e(2)<=(not (res(2) xor ans(2)));
		g(1)<=(res(1) and (not ans(1)));
		e(1)<=(not (res(1) xor ans(1)));
		g(0)<=(res(0) and (not ans(0)));
		e(0)<=(not (res(0) xor ans(0)));
	end process;
	process(g,e)--直接用比较器的式子实现
	begin
		equ<=(e(0) and e(1) and e(2) and e(3));
		gre<=(g(3) or (e(3) and g(2)) or (e(3) and e(2) and g(1)) or (e(3) and e(2) and e(1) and g(0)));
	end process;
end compare;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparator8 is--8位比较器，直接用于比较二分的结果和输入的大小
	port(
		res,ans:in std_logic_vector(7 downto 0);
		sig:out std_logic--只需要输出res是否大于ans，所以只保留一个输出，表示res>ans
	);
end comparator8;

architecture compare of comparator8 is
	component comparator4
	port(
		res,ans:in std_logic_vector(3 downto 0);
		gre,equ:out std_logic
	);
	end component;
	signal gre,equ:std_logic_vector(3 downto 0);
begin--用两个四位比较器实现八位比较器
	cp1:comparator4 port map(res(3)=>res(7),res(2)=>res(6),res(1)=>res(5),res(0)=>res(4),ans(3)=>ans(7),ans(2)=>ans(6),ans(1)=>ans(5),ans(0)=>ans(4),gre=>gre(1),equ=>equ(1));
	cp0:comparator4 port map(res(3)=>res(3),res(2)=>res(2),res(1)=>res(1),res(0)=>res(0),ans(3)=>ans(3),ans(2)=>ans(2),ans(1)=>ans(1),ans(0)=>ans(0),gre=>gre(0),equ=>equ(0));
	process(gre,equ)
	begin
		sig<=(gre(1) or (gre(0) and equ(1)));
	end process;
end compare;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sqrtmachine is--开方器本身，输入包括时钟信号，重置信号，8位的输入和4位的输出
	port(
		clk:in std_logic;
		rst:in std_logic;
		input:in std_logic_vector(7 downto 0);
		output:out std_logic_vector(3 downto 0)
	);
end sqrtmachine;

architecture sqrt of sqrtmachine is--需要平方器和比较器来实现这个部分
	component squarer
	port(
		input:in std_logic_vector(3 downto 0);
		output:out std_logic_vector(7 downto 0)
	);
	end component;
	component comparator8
	port(
		res,ans:in std_logic_vector(7 downto 0);
		sig:out std_logic
	);
	end component;
	type state is(p0,p1,p40,p41,p30,p31,p20,p21,p10,p11);--状态p0作为初始状态，p1是已经输入的状态，pi0负责决策这一位是否置1，pi1负责下一步的二分
	signal cur:state:=p0;
	signal res:std_logic_vector(7 downto 0);--临时变量存储当前二分状态下的平方值
	signal tmp:std_logic_vector(3 downto 0);--临时变量存储答案
	signal flg:std_logic;
begin
	sqr0:squarer port map(input=>tmp,output=>res);--每当临时答案改变时立刻得出他的平方
	cpr0:comparator8 port map(res=>res,ans=>input,sig=>flg);--并且得出该平方值是否大于输入
	process(clk)
	begin
		if(rising_edge(clk)) then
			case cur is
				when p0=>
					if(rst='1') then--rst为1时答案置零并进入p1
						tmp<="0000";
						cur<=p1;
					end if;
				when p1=>
					tmp(3)<='1';--让最高位置1，并进入p40
					cur<=p40;
				when p40=>
					if(flg='1') then--如果平方值大于输入，则最高位置0，并进入p41
						tmp(3)<='0';
					end if;
					cur<=p41;
				when p41=>
					tmp(2)<='1';--最高位置1，接下来几个when和这一段类似，直到最后一个
					cur<=p30;
				when p30=>
					if(flg='1') then
						tmp(2)<='0';
					end if;
					cur<=p31;
				when p31=>
					tmp(1)<='1';
					cur<=p20;
				when p20=>
					if(flg='1') then
						tmp(1)<='0';
					end if;
					cur<=p21;
				when p21=>
					tmp(0)<='1';
					cur<=p10;
				when p10=>
					if(flg='1') then
						tmp(0)<='0';
					end if;
					cur<=p11;
				when p11=>
					output<=tmp;--到达最后状态后将答案给到输出，然后当rst为0时回到p0重新开始
					if(rst='0') then
						cur<=p0;
					end if;
			end case;
		end if;
	end process;
end sqrt;