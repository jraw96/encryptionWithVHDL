-- Binary to Hex converter

library ieee;
use ieee.std_logic_1164.all;

entity bin2hex is
generic( 
	n : INTEGER := 5 -- Set the the bit register to 5 
	);
	port
	(
		bin_in : in std_logic_vector(31 downto 0);
		hex_out: out std_logic_vector(3 downto 0)
		
	);
end bin2hex;

architecture mapping of bin2hex is
	signal sel : std_logic_vector(3 downto 0); 
begin
	sel <= bin_in;
	with sel select
	hex_out <= "1000000" when x"0", -- Map the corresponding 4-bit hexadecimal values to to their LED display values
					 "1111001" when x"1",
					 "0100100" when x"2",
					 "0110000" when x"3",
					 "0011001" when x"4",
					 "0010010" when x"5",
					 "0000010" when x"6",
					 "1111000" when x"7",
					 "0000000" when x"8",
					 "0011000" when x"9",
					 "0001000" when x"A",
					 "0000011" when x"B",
					 "1000110" when x"C",
					 "0100001" when x"D",
					 "0000110" when x"E",
					 "0001110" when x"F";
					 
end mapping; 