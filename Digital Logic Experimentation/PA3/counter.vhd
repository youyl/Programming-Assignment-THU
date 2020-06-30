library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ff1 is
port(
	clk,d,rst:in std_logic;
	q,nq:out std_logic
);
end ff1;

architecture ff of ff1 is
begin
	process(clk,rst) --触发器，通过时钟上升沿控制
	begin
		if(rst='1') then
			q<='0';
			nq<='1';
		elsif(rising_edge(clk)) then
			q<=d;
			nq<=not d;
		end if;
	end process;
end ff;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ff4 is
port(
	clk,rst:in std_logic;
	output:out std_logic_vector(3 downto 0)
);
end ff4;

architecture ff of ff4 is
	component ff1
	port(
		clk,d,rst:in std_logic;
		q,nq:out std_logic
	);
	end component;
	signal mid: std_logic_vector(3 downto 0); --暂时存放中间变量
begin --四个触发器组成四位计数器
	f1:ff1 port map(clk=>clk,rst=>rst,d=>mid(0),q=>output(0),nq=>mid(0));
	f2:ff1 port map(clk=>mid(0),rst=>rst,d=>mid(1),q=>output(1),nq=>mid(1));
	f3:ff1 port map(clk=>mid(1),rst=>rst,d=>mid(2),q=>output(2),nq=>mid(2));
	f4:ff1 port map(clk=>mid(2),rst=>rst,d=>mid(3),q=>output(3),nq=>mid(3));
end ff;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity display7 is
port(
	input:in std_logic_vector(3 downto 0);
	output:out std_logic_vector(6 downto 0)
);
end display7;

architecture display of display7 is
begin
	process(input)
	begin
		case input is
			when "0000"=>output<="1111110";
			when "0001"=>output<="0110000";
			when "0010"=>output<="1101101";
			when "0011"=>output<="1111001";
			when "0100"=>output<="0110011";
			when "0101"=>output<="1011011";
			when "0110"=>output<="1011111";
			when "0111"=>output<="1110000";
			when "1000"=>output<="1111111";
			when "1001"=>output<="1110011";
			when "1010"=>output<="1110111";
			when "1011"=>output<="0011111";
			when "1100"=>output<="1001110";
			when "1101"=>output<="0111101";
			when "1110"=>output<="1001111";
			when "1111"=>output<="1000111";
			when others=>output<="0000000";
		end case;
	end process;
end display;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
port(
	highoutput,lowoutput:out std_logic_vector(6 downto 0);
	clk,rst,is_cnt,pause:in std_logic
);
end counter;

architecture count of counter is
	component display7
	port(
		input:in std_logic_vector(3 downto 0);
		output:out std_logic_vector(6 downto 0)
	);
	end component;
	component ff4
	port(
		clk,rst:in std_logic;
		output:out std_logic_vector(3 downto 0)
	);
	end component;
	signal highmid1,lowmid1:std_logic_vector(3 downto 0);
	signal highmid2,lowmid2:std_logic_vector(3 downto 0);
	signal cnt:integer:=0;
	signal highclock,lowclock,rstlow,rsthigh:std_logic;
begin
	f4:ff4 port map(clk=>lowclock,rst=>rstlow,output=>lowmid1);--low
	f5:ff4 port map(clk=>highclock,rst=>rsthigh,output=>highmid1);--high
	d1:display7 port map(input=>highmid2,output=>highoutput);
	d2:display7 port map(input=>lowmid2,output=>lowoutput);
	process(lowmid1,highmid1,rst)
	begin
		if(rst='1') then -- reset 操作优先级最高
			rstlow<='1';
			rsthigh<='1';
		elsif(lowmid1="1010") then -- 低位进位
			highclock<='1';
			rstlow<='1';
		elsif(highmid1="0110") then -- 恢复到00
			rsthigh<='1';
		else -- 上面两种情况运行过之后一定会再经过一遍这种情况，从而解除reset
			highmid2<=highmid1;
			lowmid2<=lowmid1;
			highclock<='0';
			rsthigh<='0';
			rstlow<='0';
		end if;
	end process;
	process(clk)
	begin
		if(pause='0') then -- pause控制全局暂停
			if(is_cnt='1') then -- is_cnt为1时是计数器，为0时是秒表
				lowclock<=clk;
			elsif(rising_edge(clk)) then
				if(cnt<1000000) then -- 做秒表时每1M个时钟上升沿加一次
					cnt<=cnt+1;
					lowclock<='0';
				else
					cnt<=0;
					lowclock<='1';
				end if;
			end if;
		end if;
	end process;
end count;