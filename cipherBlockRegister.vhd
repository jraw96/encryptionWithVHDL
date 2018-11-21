library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cipherBlockRegister is
port
(
-- Input ports
en, reset, clk : in std_logic;

previousBlock: in std_logic_vector(4 downto 0);

-- Output ports
Q    : out std_logic_vector(4 downto 0)
);
end entity cipherBlockRegister;

architecture Behaveral of cipherBlockRegister is

	signal previous : std_logic_vector(4 downto 0);

begin
   process(clk, previousBlock)
	begin
		previous <= previousBlock;
   if (reset = '1') 
		then Q <= "00000";
		
	elsif en = '1' then
		if clk'event and clk = '1' then
		
			-- Define if no previous block cipher, use '00000'
			if previous = "00000" then 
				Q <= "00100";
				
			else
				Q <= previous;
				
			end if;
			
		end if;
	end if;
	
	end process;
 end architecture Behaveral;