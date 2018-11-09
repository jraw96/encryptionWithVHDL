-- Multiplexer for selecting to display the encryption, original message or seed. 

library ieee;
use ieee.std_logic_1164.all;

entity Mux is

generic(
	 blank : std_logic_vector(7 downto 0) := "00000000"
);
	port
	(
		I0		: in std_logic_vector(7 downto 0); -- Display the encryption
		I1		: in std_logic_vector(7 downto 0); -- Display the oiginal message
		I2		: in std_logic_vector(7 downto 0); -- Display the seed value
		toggle1 : in std_logic; -- toggle between the original message and encrypted message
		toggle2 : in std_logic; -- toggle between the original message and encrypted message
		F		: out std_logic_vector(7 downto 0) --  selected output
	);
end Mux;

architecture arch of Mux is

signal key1 : std_logic; 
signal key2 : std_logic; 
signal encrypted : std_logic_vector(7 downto 0);
signal original : std_logic_vector(7 downto 0);
signal seed : std_logic_vector(7 downto 0);

begin 
	process(key1, key2, I1, I2, I0)

	begin
		key1 <= toggle1;
		key2 <= toggle2;
		encrypted <= I0;
		original <= I1;
		seed <= I2;
	 
		if (key1 = '0') and (key2 = '0') then
			F <=  encrypted;  
		elsif (key1 = '1') and (key2 = '0') then
			F <=  original;  
			
		elsif (key1 = '0') and (key2 = '1') then
			F <= seed; 
			
		elsif (key1 = '1') and (key2 = '1') then
			F <= blank;
		end if;
	end process;
	
end architecture arch;