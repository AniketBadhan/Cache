-------------------------------------------------------
--Entity : Decoder2_4
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Decoder2_4 is
	port(
		S : in std_logic_vector(1 downto 0);
		D : out std_logic_vector(3 downto 0));
end Decoder2_4;

architecture structural of Decoder2_4 is

component and2 
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component inverter 
	port(
		input : in std_logic;
		output : out std_logic);
end component;

for and2_1, and2_2, and2_3, and2_4 : and2 use entity work.and2(structural);
for inverter_1, inverter_2 : inverter use entity work.inverter(structural);

signal Sbar : std_logic_vector(1 downto 0);

begin

	inverter_1 : inverter port map(S(0), Sbar(0));				-- Inverting S(0)
	inverter_2 : inverter port map(S(1), Sbar(1));				-- Inverting S(1)
	and2_1 : and2 port map(Sbar(0), Sbar(1), D(0));				-- Equation for D(0)
	and2_2 : and2 port map(S(0), Sbar(1), D(1));				-- Equation for D(1)
	and2_3 : and2 port map(Sbar(0), Sbar(1), D(2));				-- Equation for D(2)
	and2_4 : and2 port map(S(0), S(1), D(3));					-- Equation for D(3)
	
end structural;