-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity locker_tb is
end;

architecture bench of locker_tb is

  component locker
  port(
  	clk,rst:in std_logic;
  	mode:in std_logic_vector(1 downto 0);
  	code:in std_logic_vector(3 downto 0);
  	unlock,err:out std_logic
  );
  end component;

  signal clk,rst: std_logic;
  signal mode: std_logic_vector(1 downto 0);
  signal code: std_logic_vector(3 downto 0);
  signal unlock,err: std_logic ;

  constant clock_period: time := 1000 ns;
  signal stop_the_clock: boolean;

begin

  uut: locker port map ( clk    => clk,
                         rst    => rst,
                         mode   => mode,
                         code   => code,
                         unlock => unlock,
                         err    => err );

  stimulus: process
  begin
  
    -- Put initialisation code here
	rst<='0';
	mode<="00";
	code<="0000";
	wait for 400ns;
	rst<='1';
	wait for 1000ns;
	rst<='0';
	code<="1000";
	wait for 1000ns;
	code<="0100";
	wait for 1000ns;
	code<="0010";
	wait for 1000ns;
	code<="0001";
	wait for 1000ns;
	
	rst<='1';
	wait for 1000ns;
	rst<='0';
	code<="1000";
	mode<="01";
	wait for 1000ns;
	code<="0100";
	wait for 1000ns;
	code<="0010";
	wait for 1000ns;
	code<="0001";
	wait for 1000ns;
	
	rst<='1';
	wait for 1000ns;
	rst<='0';
	code<="1000";
	mode<="01";
	wait for 1000ns;
	code<="0100";
	wait for 1000ns;
	code<="0010";
	wait for 1000ns;
	code<="1001";
	wait for 1000ns;
	
	rst<='1';
	wait for 1000ns;
	rst<='0';
	code<="1000";
	mode<="01";
	wait for 1000ns;
	code<="0101";
	wait for 1000ns;
	
	rst<='1';
	wait for 1000ns;
	rst<='0';
	code<="0000";
	mode<="00";
	wait for 1000ns;
	code<="0000";
	wait for 1000ns;
	code<="0000";
	wait for 1000ns;
	code<="0000";
	wait for 1000ns;
	
	rst<='1';
	wait for 1000ns;
	rst<='0';
	code<="0000";
	mode<="01";
	wait for 1000ns;
	code<="0000";
	wait for 1000ns;
	code<="0000";
	wait for 1000ns;
	code<="0000";
	wait for 1000ns;

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