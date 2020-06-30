-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity LightDigitalLife_tb is
end;

architecture bench of LightDigitalLife_tb is

  component LightDigitalLife
  	port(
  		clk: in std_logic;
  		rst: in std_logic;
  		display_natural: out std_logic_vector(6 downto 0);
  		display_odd: out std_logic_vector(3 downto 0);
  		display_even: out std_logic_vector(3 downto 0)
  	);
  end component;

  signal clk: std_logic;
  signal rst: std_logic;
  signal display_natural: std_logic_vector(6 downto 0);
  signal display_odd: std_logic_vector(3 downto 0);
  signal display_even: std_logic_vector(3 downto 0) ;

  constant clock_period: time := 10 ns;--时钟周期为10ns
  signal stop_the_clock: boolean;

begin

  uut: LightDigitalLife port map ( clk             => clk,
                                   rst             => rst,
                                   display_natural => display_natural,
                                   display_odd     => display_odd,
                                   display_even    => display_even );

  stimulus: process
  begin
  
    -- Put initialisation code here

	wait for 80000000ns;
	wait for 3ns;          --测试Reset功能，为了在仿真工具中区别出来，将rst和clk的上升沿分开
	rst<='1';
	wait for 4ns;
	rst<='0';
	wait for 3ns;
	wait for 80000000ns;
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