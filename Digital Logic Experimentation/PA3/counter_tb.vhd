library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity counter_tb is
end;

architecture bench of counter_tb is

  component counter
  port(
  	highoutput,lowoutput:out std_logic_vector(6 downto 0);
  	clk,rst,is_cnt,pause:in std_logic
  );
  end component;

  signal highoutput,lowoutput: std_logic_vector(6 downto 0);
  signal clk,rst,is_cnt,pause: std_logic ;

  constant clock_period: time := 50 ns;
  signal stop_the_clock: boolean;

begin

  uut: counter port map ( highoutput => highoutput,
                          lowoutput  => lowoutput,
                          clk        => clk,
                          rst        => rst,
                          is_cnt     => is_cnt,
                          pause      => pause );

  stimulus: process
  begin
  
    -- Put initialisation code here
	 rst<='1';
	 wait for 100ns;
	 rst<='0';
	 is_cnt<='1';
	 pause<='0';
	 wait for 50000ns;
	 rst<='1';
	 wait for 100ns; -- 测试reset功能
	 rst<='0';
	 wait for 50000ns;


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