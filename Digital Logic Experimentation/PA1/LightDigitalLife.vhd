library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LightDigitalLife is
	port(
		clk: in std_logic;                                 --Clock时钟输入
		rst: in std_logic;                                 --Reset输入
		display_natural: out std_logic_vector(6 downto 0); --自然数序列输出端口，使用未经译码的数码管
		display_odd: out std_logic_vector(3 downto 0);     --奇数序列输出端口，使用经过译码的数码管
		display_even: out std_logic_vector(3 downto 0)     --偶数序列输出端口，使用经过译码的数码管
	);
end LightDigitalLife;

architecture Light of LightDigitalLife is
	signal cnt: integer:=0;                                      --计数器
	signal odd_series: std_logic_vector(3 downto 0):="0001";     --奇数序列
	signal even_series: std_logic_vector(3 downto 0):="0000";    --偶数序列
	signal natural_series: std_logic_vector(3 downto 0):="0000"; --自然数序列
begin
	process(clk,rst)
	begin
		if(rst='1') then                         --重置所有序列和显示
			natural_series<="0000";
			even_series<="0000";
			odd_series<="0001";
			display_even<=even_series;
			display_odd<=odd_series;
			elsif(rising_edge(clk)) then          --遇到clk的上升沿则处理计数器+1后的情况
			if(cnt<1000000) then                  --以10^6个clk的上升沿为周期改变显示的值
				cnt<=cnt+1;
			else
				natural_series<=natural_series+1;
				if(even_series="1000") then        --判断偶数序列是否到10
					even_series<="0000";
				else
					even_series<=even_series+2;
				end if;
				if(odd_series="1001") then         --判断奇数序列是否到11
					odd_series<="0001";
				else
					odd_series<=odd_series+2;
				end if;
				display_even<=even_series;
				display_odd<=odd_series;
				cnt<=0;
			end if;
		end if;
	end process;
	process(natural_series)
	begin
		case natural_series is                  --处理需要传达给未经译码的数码管的信号
			when "0000"=>display_natural<="1111110";
			when "0001"=>display_natural<="0110000";
			when "0010"=>display_natural<="1101101";
			when "0011"=>display_natural<="1111001";
			when "0100"=>display_natural<="0110011";
			when "0101"=>display_natural<="1011011";
			when "0110"=>display_natural<="1011111";
			when "0111"=>display_natural<="1110000";
			when "1000"=>display_natural<="1111111";
			when "1001"=>display_natural<="1110011";
			when "1010"=>display_natural<="1110111";
			when "1011"=>display_natural<="0011111";
			when "1100"=>display_natural<="1001110";
			when "1101"=>display_natural<="0111101";
			when "1110"=>display_natural<="1001111";
			when "1111"=>display_natural<="1000111";
			when others=>display_natural<="0000000";
		end case;
	end process;
end Light;