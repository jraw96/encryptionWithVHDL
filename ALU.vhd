-- Algorithm Logic Unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity ALU is

port(message : IN std_logic_vector(7 downto 0);
	  seed : IN std_logic_vector(7 downto 0);
			algorithm : IN std_logic_vector(1 downto 0);
			encrypted : OUT std_logic_vector(7 downto 0)
	);
end ALU;

	
	
architecture options of ALU is
begin 
	process(algorithm)
		begin 
		case algorithm is
			when "00" => -- Perform the LSFR
			
				encrypted <= message;
				
			when "01"=> -- Perform the second guy
				encrypted <= "00000000";
				
			when "10"=> -- Perform the third guy
				encrypted <= "10101010";
			
			when "11" => -- Display all 1's
				encrypted <= "11111111";
				
			end case;
		end process;
end options; -- end process 

				
	
	

