-- Algorithm Logic Unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity ALU is

port(message : IN std_logic_vector(4 downto 0);
	  seed : IN std_logic_vector(4 downto 0);
			algorithm : IN std_logic_vector(1 downto 0);
			encrypted : OUT std_logic_vector(4 downto 0) -- Output is a 32 bit string. The length is 2^n - 1, where n = 5
	);
end ALU;

	
architecture options of ALU is

signal encryptedMessage : std_logic_vector(63 downto 0);
signal feedback : std_logic;

begin
	process(algorithm)
		begin 
		case algorithm is
			when "00" => -- Perform the LSFR
			
				feedback <=  seed(4) XOR seed(3) XOR seed(2) XOR seed(1) XOR seed(0);  
				encrypted <= seed(3 downto 0) & feedback;
				
			when "01"=> -- Perform the second guy
				encrypted <= (others => '0');
				
			when "10"=> -- Perform the third guy
				encrypted <= "10101";
			
			when "11" => -- Display all 1's
				encrypted <= "11111";
				
			end case;
		end process;
end options; -- end process 

				
	
	

