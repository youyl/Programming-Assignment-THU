library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity locker is
port(
	clk,rst:in std_logic;
	mode:in std_logic_vector(1 downto 0); --00设置密码，01输入密码
	code:in std_logic_vector(3 downto 0);
	unlock,err:out std_logic
);
end locker;

architecture lock of locker is
	type state is(p0,p1,p2,p3,p4,p5,p6,p7,p8);
	signal cur:state;
	signal pwd0,pwd1,pwd2,pwd3: std_logic_vector(3 downto 0);
begin
	process(clk,rst)
	begin
		if(rst='1') then --重置
			cur<=p0;
			unlock<='0';
			err<='0';
		elsif(rising_edge(clk)) then --状态机部分
			case cur is
				when p0=>
					if(mode="00") then
						pwd0<=code;
						cur<=p1;
					elsif(mode="01") then
						if(pwd0=code) then
							cur<=p4;
						else
							cur<=p8;
							err<='1';
						end if;
					end if;
				when p1=> --p1,p2,p3是设置密码部分
					if(mode="00") then
						pwd1<=code;
						cur<=p2;
					elsif(mode="01") then
						cur<=p8;
						err<='1';
					end if;
				when p2=>
					if(mode="00") then
						pwd2<=code;
						cur<=p3;
					elsif(mode="01") then
						cur<=p8;
						err<='1';
					end if;
				when p3=>
					if(mode="00") then
						pwd3<=code;
						cur<=p7;
						unlock<='1';
					elsif(mode="01") then
						cur<=p8;
						err<='1';
					end if;
				when p4=> --p4,p5,p6是输入密码部分
					if(mode="00") then
						cur<=p8;
						err<='1';
					elsif(mode="01") then
						if(pwd1=code) then
							cur<=p5;
						else
							cur<=p8;
							err<='1';
						end if;
					end if;
				when p5=>
					if(mode="00") then
						cur<=p8;
						err<='1';
					elsif(mode="01") then
						if(pwd2=code) then
							cur<=p6;
						else
							cur<=p8;
							err<='1';
						end if;
					end if;
				when p6=>
					if(mode="00") then
						cur<=p8;
						err<='1';
					elsif(mode="01") then
						if(pwd3=code) then
							cur<=p7;
							unlock<='1';
						else
							cur<=p8;
							err<='1';
						end if;
					end if;
				when others=>NULL;
			end case;
		end if;
	end process;
end lock;