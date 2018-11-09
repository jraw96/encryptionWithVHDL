-- Variable Bit register

library ieee;
use ieee.std_logic_1164.all;

entity varbitreg is
generic( 
	n : INTEGER := 8 -- Set the the bit register to 8 
	);
port( -- Scale the ports with the size of the selected register
	D : IN std_logic_vector(n-1 DOWNTO 0) ;
	Reset : IN std_logic;
	E, Clock : IN std_logic;
	Q : OUT std_logic_vector(n-1 DOWNTO 0) 
	);
end varbitreg;

architecture memory of varbitreg is
begin
	process(Reset, Clock)
begin
		if Reset = '0' then
			Q <= (others => '0');
		elsif Clock'event and Clock = '1' then	
			if E = '1' then -- If the enable is turned on
			Q <= D ;
			end if;
		end if;
	end process;
end memory;