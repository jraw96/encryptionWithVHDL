-- Multiplexer for selecting to display the encryption, original message or seed. 

library ieee;
use ieee.std_logic_1164.all;

entity displayMux is
	port
	(
		I0		: in std_logic_vector(15 downto 0); -- Pass the encrypted or decrypted test
		I1		: in std_logic_vector(15 downto 0); -- Pass the original message
		I2		: in std_logic_vector(15 downto 0); -- Pass the seed value		
		I3		: in std_logic_vector(1 downto 0); -- Select options for the Seven Segment displays
		

		
		left_four_digits : out std_logic_vector(15 downto 0);
		right_four_digits : out std_logic_vector(15 downto 0)
		
	);
end displayMux;

architecture arch of displayMux is

signal mode : std_logic_vector(1 downto 0);

		-- Toggle/Display options:
		-- 00: Set the message from 16 binary to 4 bit hexadecimal
		-- 01: Set the seed from 16 binary to 4 bit hexadecimal
		-- 10: Start the encrypting process. This will display the original message on the left 4 LEDS, and the changing encryption on the right 4 LEDS
		-- 11: Start descryption: This will display the encrypted message on the left 4 LEDS, and the changing decrypted message on the right 4 LEDS

signal output_message : std_logic_vector(15 downto 0);
signal original_message : std_logic_vector(15 downto 0);
signal seed : std_logic_vector(15 downto 0);

begin 
	process(I0, I1, I2, I3)

	begin

		output_message <= I0;
		original_message <= I1;
		seed <= I2;
		mode <= I3;
	 
		-- Display the original 
		if (mode = "00") then
			left_four_digits <= original_message;
			right_four_digits <= "0000000000000000";
			
		-- Display the seed
		elsif (mode = "01") then
			left_four_digits <= "0000000000000000"; 
			right_four_digits <= seed;
			
		-- Display original message on the left and the encrypted text on the right
		elsif (mode = "10") then
			left_four_digits <= original_message;
			right_four_digits <= output_message;
			
		-- Display the seed on the left and the decrypted text on the right
		elsif (mode = "11") then
			left_four_digits <= output_message;
			right_four_digits <= seed;
			
		end if;
	end process;
	
end architecture arch;