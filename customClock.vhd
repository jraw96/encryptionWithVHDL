library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

		entity customClock is

port
(
-- Input ports
clk_source : in std_logic;
reset      : in std_logic;
-- Output ports
clk_out    : out std_logic
);
end entity customClock;

architecture clock_arch of customClock is

signal count: unsigned(24 downto 0) := (others=> '0');
signal togglebit: std_logic := '0';

begin
Process(reset,clk_source) is
    -- Declaration(s)
begin
	if (reset = '1') then
		 count <= (others => '0');
	elsif(clk_source'event and clk_source = '1') then
		 count <= count + 1;
	 
		if count = "1011111010111100001000000" then
		 toggleBit <= not toggleBit;
		 count <= (others => '0');
		end if;
	end if;
end process;
clk_out <= toggleBit;
end architecture clock_arch ;