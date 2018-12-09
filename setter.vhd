-- Multiplexer for selecting to display the encryption, original message or seed. 

library ieee;
use ieee.std_logic_1164.all;

entity setter is
	port
	(
		switches : in std_logic_vector(15 downto 0); -- The 16 bit value from the switches. Can be either the message or seed. 	
		mode : in std_logic_vector(1 downto 0); -- Set the message or set the string
		set : in std_logic;
		
		saved_message : out std_logic_vector(15 downto 0);
		saved_seed : out std_logic_vector(15 downto 0)

		
	);
end setter;

architecture arch of setter is

signal mode_value : std_logic_vector(1 downto 0);


begin 
	process(mode)

	begin

		mode_value <= mode;
		
		if set = '1' then
	 
			-- Set te message value 
			if (mode = "00") then
				saved_message <= switches;
				
			-- Set the seed value
			elsif (mode = "01") then
				saved_seed <=switches;
				
			end if;
		
			
		end if;
	end process;
	
end architecture arch;