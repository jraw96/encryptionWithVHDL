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
signal feedback1 : std_logic;
signal feedback2 : std_logic;
signal LSFR_random_number: std_logic_vector(15 downto 0);
signal RSFR_random_number: std_logic_vector(15 downto 0);

-- Define the hexadecimal components of the message
signal hex0 : std_logic_vector(3 downto 0);
signal hex1 : std_logic_vector(3 downto 0);
signal hex2 : std_logic_vector(3 downto 0);
signal hex3 : std_logic_vector(3 downto 0);

-- Define the intermediate encryption signals
signal encryptAdd0 : std_logic_vector(3 downto 0);
signal encryptAdd1 : std_logic_vector(3 downto 0);
signal encryptAdd2 : std_logic_vector(3 downto 0);
signal encryptAdd3 : std_logic_vector(3 downto 0);

signal encryptXOR0 : std_logic_vector(3 downto 0);
signal encryptXOR1 : std_logic_vector(3 downto 0);
signal encryptXOR2 : std_logic_vector(3 downto 0);
signal encryptXOR3 : std_logic_vector(3 downto 0);

-- Define the block cipher componets:
signal cipher0 : std_logic_vector(3 downto 0);
signal cipher1 : std_logic_vector(3 downto 0);
signal cipher2 : std_logic_vector(3 downto 0);
signal cipher3 : std_logic_vector(3 downto 0);





begin
	process (clk, mode)
	begin
		seed_value <= seed;
	
		if clear = '1' then -- Reset the block cipher chain	
			output_text <= "0000000000000000";
			
		elsif en = '1' then
			if rising_edge(clk) then
			
				-- Step 1: Initialization the seed values using LSFR and RSFR
				feedback1 <=  seed_value(15) XOR seed_value(14);  
				LSFR_random_number <= seed_value(14 downto 0) & feedback1;
						
				feedback2 <=  seed_value(0) XOR seed_value(1); 
				RSFR_random_number <=  feedback2 & seed_value(15 downto 1);
				
				-- Step 2: Break down the pseudo random numbers into 4-bit components
				encryptAdd0 <= LSFR_random_number(3 downto 0);
				encryptAdd1 <= LSFR_random_number(7 downto 4);
				encryptAdd2 <= LSFR_random_number(11 downto 8);
				encryptAdd3 <= LSFR_random_number(15 downto 12);
						
				encryptXOR0 <= RSFR_random_number(3 downto 0);
				encryptXOR1 <= RSFR_random_number(7 downto 4);
				encryptXOR2 <= RSFR_random_number(11 downto 8);
				encryptXOR3 <= RSFR_random_number(15 downto 12);			
					
				
				-- Perform the encryption -- ############################################################################
				-- Strategy: For encrypting each cipher block, add the LSFR_random_number and XOR the RSFR_random_number
				if (mode = "10") then
			
					-- If there is no previous block cipher, used the seed value as an "initialization vector"
					if blockCipher = "0000000000000000" then 		
							
						-- Step three: Assign the message and seed hexadecimal components 
						hex0 <= message(3 downto 0);
						hex1 <= message(7 downto 4);
						hex2 <= message(11 downto 8);
						hex3 <= message(15 downto 12);		
					
					-- If there is a previous block cipher, use the block cipher as the random number components
					else
					
						-- Step three: Assign the message and seed hexadecimal components 
						hex0 <= blockCipher(3 downto 0);
						hex1 <= blockCipher(7 downto 4);
						hex2 <= blockCipher(11 downto 8);
						hex3 <= blockCipher(15 downto 12);			
					
					end if; 
									
						-- Step four: Perform the block cipher operation:
						cipher0 <= std_logic_vector(signed(hex0) + signed(encryptAdd0)) XOR encryptXOR0;
						cipher1 <= std_logic_vector(signed(hex1) + signed(encryptAdd1)) XOR encryptXOR1;
						cipher2 <= std_logic_vector(signed(hex2) + signed(encryptAdd2)) XOR encryptXOR2;
						cipher3 <= std_logic_vector(signed(hex3) + signed(encryptAdd3)) XOR encryptXOR3;
						
				output_text <= cipher3 & cipher2 & cipher1 & cipher0;
					
				-- Perorm the decryption -- ############################################################################
				elsif (mode = "11") then
					
					-- If there is no seed value or message, assume a value of "00000" and pretty much do nothing
					if (seed = "0000000000000000") or (message = "0000000000000000") then 
						output_text <= "0000000000000000";
					
					-- If there is no block cipher, beging by depcrypting the message
					elsif (blockCipher = "0000000000000000") then
						-- Step three: Assign the message and seed hexadecimal components 
						hex0 <= message(3 downto 0);
						hex1 <= message(7 downto 4);
						hex2 <= message(11 downto 8);
						hex3 <= message(15 downto 12);	
						
					-- If there is a block cipher, treat that as the message
					else
						-- Step three: Assign the message and seed hexadecimal components 
						hex0 <= blockCipher(3 downto 0);
						hex1 <= blockCipher(7 downto 4);
						hex2 <= blockCipher(11 downto 8);
						hex3 <= blockCipher(15 downto 12);
					
					end if; 
					
					-- Step 4: Perform the decryption logic
					cipher0 <= std_logic_vector(signed(hex0 XOR encryptXOR0) - signed(encryptAdd0));
					cipher1 <= std_logic_vector(signed(hex1 XOR encryptXOR1) - signed(encryptAdd1));
					cipher2 <= std_logic_vector(signed(hex2 XOR encryptXOR2) - signed(encryptAdd2));
					cipher3 <= std_logic_vector(signed(hex3 XOR encryptXOR3) - signed(encryptAdd3));
					
					output_text <= cipher3 & cipher2 & cipher1 & cipher0;
					
				end if; -- End of encryption/decryption
				
		end if; 
	end if;
end process;

end options; -- end process 

				
	
	

