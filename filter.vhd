-- Multiplexer for selecting to display the encryption, original message or seed. 

library ieee;
use ieee.std_logic_1164.all;

entity filter is

	port
	(
		I0		: in std_logic_vector(31 downto 0); -- Enrypted message space
		I1		: in std_logic_vector(4 downto 0); -- seed or original message space
		F 		: out std_logic_vector(31 downto 0) -- output message. Will have added padding if a plaintext is received
	);
end filter;

architecture arch of filter is

signal encrypted : std_logic_vector(31 downto 0);
signal plainText : std_logic_vector(4 downto 0);
signal padding : std_logic_vector(26 downto 0) := "000000000000000000000000000";

begin 
	process(I1, I0)

	begin
		encrypted <= I0;
		plainText <= I1;
	 
		if (encrypted /= "00000000000000000000000000000000") and (plainText = "00000") then
		
			F <=  encrypted;  

		elsif (encrypted = "00000000000000000000000000000000") and (plainText /= "00000")then
	
			F <= padding & plainText;
			

		end if;
	end process;
	
end architecture arch;