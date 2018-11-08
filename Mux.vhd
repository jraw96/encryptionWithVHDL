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
		sel	: in std_logic_vector(1 downto 0);
		F		: out std_logic_vector(7 downto 0) --  selected output
	);
end entity Mux;

architecture arch of Mux is
begin 
	with sel select 
		F <=  I0 when "00",
				I1 when "01",
				I2 when "10",
				blank when "11";
	
end architecture arch;