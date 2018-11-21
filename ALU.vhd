-- Algorithm Logic Unit

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity ALU is

port(		message : IN std_logic_vector(4 downto 0);
			seed : IN std_logic_vector(4 downto 0);
			algorithm : IN std_logic_vector(1 downto 0);
			
			blockCipher: IN std_logic_vector(4 downto 0);
			
			en,clear,clk : in std_logic ; -- Used for keep track of state
			
			
			encrypted : OUT std_logic_vector(4 downto 0) -- Output is a 32 bit string. The length is 2^n - 1, where n = 5
			
			
	);
end ALU;

	
architecture options of ALU is

signal encryptedMessage : std_logic_vector(63 downto 0);
signal feedback : std_logic;

begin
	process (clk)
	begin
	
		if clear = '1' then -- Reset the block cipher chain	
			encrypted <= "00000";
			
		elsif en = '1' then
			if rising_edge(clk) then
			
				-- If there is no previous block cipher, used the seed value
				if blockCipher = "00000" then 
					encrypted <= "10101";
				
				-- If there is a previous block cipher, use the block cipher
				else
					 encrypted <= "01110";
				
				end if; 
		end if; 
	end if;
end process;



			
	-- feedback <=  seed(4) XOR seed(3);  
	-- encrypted <= seed(3 downto 0) & feedback;
				

end options; -- end process 

				
	
	

