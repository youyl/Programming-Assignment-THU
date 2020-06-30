-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity sqrtmachine_tb is
end;

architecture bench of sqrtmachine_tb is

  component sqrtmachine
  	port(
  		clk:in std_logic;
  		rst:in std_logic;
  		input:in std_logic_vector(7 downto 0);
  		output:out std_logic_vector(3 downto 0)
  	);
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal input: std_logic_vector(7 downto 0);
  signal output: std_logic_vector(3 downto 0) ;

  constant clock_period: time := 100 ns;
  signal stop_the_clock: boolean;

begin

  uut: sqrtmachine port map ( clk    => clk,
                              rst    => rst,
                              input  => input,
                              output => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
input<="01111101";--125
rst<='0';
wait for 210ns;
rst<='1';
wait for 990ns;

rst<='0';
input<="11000100";--196
wait for 210ns;
rst<='1';
wait for 990ns;

rst<='0';
input<="11111111";--255
wait for 210ns;
rst<='1';
wait for 990ns;

rst<='0';
input<="01001011";--75
wait for 210ns;
rst<='1';
wait for 990ns;

rst<='0';
input<="00001001";--9
wait for 210ns;
rst<='1';
wait for 990ns;

rst<='0';
input<="00000000";--0
wait for 210ns;
rst<='1';
wait for 990ns;

rst<='0';
input<="11000000";--192
wait for 210ns;
rst<='1';
wait for 990ns;

wait for 200ns;
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;