-- Testbench created online at:
--   www.doulos.com/knowhow/perl/testbench_creation/
-- Copyright Doulos Ltd
-- SD, 03 November 2002

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity fourdigitadder_tb is
end;

architecture bench of fourdigitadder_tb is

  component fourdigitadder
  port(
  	a,b:in std_logic_vector(3 downto 0);
  	cin:in std_logic;
  	s:out std_logic_vector(3 downto 0);
  	cout:out std_logic
  );
  end component;

  signal a,b: std_logic_vector(3 downto 0);
  signal cin: std_logic;
  signal s: std_logic_vector(3 downto 0);
  signal cout: std_logic ;

begin

  uut: fourdigitadder port map ( a    => a,
                                 b    => b,
                                 cin  => cin,
                                 s    => s,
                                 cout => cout );

  stimulus: process
  begin
  
    -- Put initialisation code here
cin<='0';
a<="0000";
b<="0000";
wait for 100ns;
cin<='1';
a<="1111";
b<="1111";
wait for 100ns;
cin<='0';
a<="1111";
b<="0001";
wait for 100ns;
cin<='0';
a<="1011";
b<="0010";
wait for 100ns;
cin<='0';
a<="1001";
b<="0001";
wait for 100ns;
cin<='1';
a<="1011";
b<="0010";
wait for 100ns;
cin<='0';
a<="1000";
b<="1000";
wait for 100ns;

    -- Put test bench stimulus code here

    wait;
  end process;


end;