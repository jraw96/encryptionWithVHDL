-- Algorithm Logic Unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity ALU is

port(		message : IN std_logic_vector(15 downto 0); -- The 16 bit entered message
			seed : IN std_logic_vector(15 downto 0); -- The 16 bit entered seed
			mode : IN std_logic_vector(1 downto 0); -- The algorithm mode: Encryption or Decryption
			
			blockCipher: IN std_logic_vector(15 downto 0); --  A block cipher
			
			en,clear,clk : in std_logic ; -- Used for keep track of state
			
			
			output_text : OUT std_logic_vector(15 downto 0) -- Output is a 32 bit string. The length is 2^n - 1, where n = 5
			
			
	);
end ALU;

	
architecture options of ALU is

signal seed_value : std_logic_vector(15 downto 0);
signal output_text_value: std_logic_vector(15 downto 0);
signal feedback : std_logic;

begin
	process (clk, mode)
	begin
	
		if clear = '1' then -- Reset the block cipher chain	
			output_text <= "0000000000000000";
			
		elsif en = '1' then
			if rising_edge(clk) then
				
				-- Perform the encryption
				if (mode = "10") then
			
					-- If there is no previous block cipher, used the seed value
					if blockCipher = "0000000000000000" then 
						output_text <= "1010101010101010";
					
					-- If there is a previous block cipher, use the block cipher
					else
						 output_text <= "0000000011111111";
					
					end if; 
					
				-- Perorm the decryption
				elsif (mode = "11") then
					
					-- If there is no seed value, assume a value of "00000" and pretty much do nothing
					if (seed = "0000000000000000") then 
						output_text <= message;
					
					-- If there is a seed value, use the seed value to decrypt
					else
						 output_text <= "1111111100000000";
					
					end if; 
					
			end if;
				
		end if; 
	end if;
end process;



			
	-- feedback <=  seed(4) XOR seed(3);  
	-- encrypted <= seed(3 downto 0) & feedback;
				

end options; -- end process 

				
	
	

