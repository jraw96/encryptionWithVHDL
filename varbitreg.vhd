-- Variable Bit register

library ieee;
use ieee.std_logic_1164.all;

entity varbitreg is
generic( 
	n : INTEGER := 16 -- Set the the bit register to 16. It will contains four hexadecimanl values
	);
	port
	(
		D : IN std_logic_vector(n-1 DOWNTO 0) ;
		en, clk : IN std_logic;
		Q : OUT std_logic_vector(n-1 DOWNTO 0) 
	);
end varbitreg;

architecture arch of varbitreg is
begin 
	process(en, clk) is 
	begin 
		if(en = '0' and rising_edge(clk)) then
			Q <= D;
		end if;
	end process; 
end arch;