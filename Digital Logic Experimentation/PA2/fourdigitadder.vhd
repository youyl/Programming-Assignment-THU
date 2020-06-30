library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity halfadder is
port(
	a,b:in std_logic;
	s,cout:out std_logic
);
end halfadder;

architecture halfadd of halfadder is
begin
	process(a,b)
	begin
		s<=a xor b;
		cout<=a and b;
	end process;
end halfadd;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity orgate is
port(
	a,b:in std_logic;
	s:out std_logic
);
end orgate;

architecture orprocess of orgate is
begin
	process(a,b)
	begin
		s<=a or b;
	end process;
end orprocess;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fulladder is
port(
	a,b,cin:in std_logic;
	s,cout:out std_logic;
	p,g,k:buffer std_logic
);
end fulladder;

architecture fulladd of fulladder is
	component halfadder
	port(
		a,b:in std_logic;
		s,cout:out std_logic
	);
	end component;
	component orgate
	port(
		a,b:in std_logic;
		s:out std_logic
	);
	end component;
begin
	hf0:halfadder port map(a,b,p,g);
	hf1:halfadder port map(p,cin,s,k);
	op0:orgate port map(k,g,cout);
end fulladd;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity advancedcarrier is
port(
	p,g:in std_logic_vector(3 downto 0);
	cin:in std_logic;
	carry:out std_logic_vector(3 downto 0);
	cout:out std_logic
);
end advancedcarrier;

architecture carryon of advancedcarrier is
begin
	process(p,g)
	begin
		carry(0)<=g(0) or (p(0) and cin);
		carry(1)<=g(1) or (p(1) and g(0)) or (p(1) and p(0) and cin);
		carry(2)<=g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and cin);
		cout<=g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2) and p(1) and p(0) and cin);
	end process;
end carryon;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity fourdigitadder is
port(
	a,b:in std_logic_vector(3 downto 0);
	cin:in std_logic;
	s:out std_logic_vector(3 downto 0);
	cout:out std_logic
);
end fourdigitadder;

architecture normalcarry of fourdigitadder is
	component fulladder
	port(
		a,b,cin:in std_logic;
		s,cout:out std_logic;
		p,g,k:buffer std_logic
	);
	end component;
	signal carry:std_logic_vector(2 downto 0);
begin
	fa0:fulladder port map(a=>a(0),b=>b(0),cin=>cin,s=>s(0),cout=>carry(0));
	fa1:fulladder port map(a=>a(1),b=>b(1),cin=>carry(0),s=>s(1),cout=>carry(1));
	fa2:fulladder port map(a=>a(2),b=>b(2),cin=>carry(1),s=>s(2),cout=>carry(2));
	fa3:fulladder port map(a=>a(3),b=>b(3),cin=>carry(2),s=>s(3),cout=>cout);
end normalcarry;

architecture advancedcarry of fourdigitadder is
	component fulladder
	port(
		a,b,cin:in std_logic;
		s,cout:out std_logic;
		p,g,k:buffer std_logic
	);
	end component;
	component advancedcarrier
	port(
		p,g:in std_logic_vector(3 downto 0);
		cin:in std_logic;
		carry:out std_logic_vector(3 downto 0);
		cout:out std_logic
	);
	end component;
	signal p,g,carry:std_logic_vector(3 downto 0);
begin
	fa0:fulladder port map(a=>a(0),b=>b(0),cin=>cin,s=>s(0),p=>p(0),g=>g(0));
	fa1:fulladder port map(a=>a(1),b=>b(1),cin=>carry(0),s=>s(1),p=>p(1),g=>g(1));
	fa2:fulladder port map(a=>a(2),b=>b(2),cin=>carry(1),s=>s(2),p=>p(2),g=>g(2));
	fa3:fulladder port map(a=>a(3),b=>b(3),cin=>carry(2),s=>s(3),p=>p(3),g=>g(3));
	cry0:advancedcarrier port map(p,g,cin,carry,cout);
end advancedcarry;
