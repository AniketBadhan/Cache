-------------------------------------------------------
--Entity : Decoder3_8
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Decoder3_8 is
	port(
		S : in std_logic_vector(2 downto 0);
		D : out std_logic_vector(7 downto 0));
end Decoder3_8;

architecture structural of Decoder3_8 is 

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

for and2_1, and2_2, and2_3, and2_4, and2_5, and2_6, and2_7, and2_8, and2_9, and2_10, and2_11, and2_12 : and2 use entity work.and2(structural);
for inverter_1, inverter_2, inverter_3 : inverter use entity work.inverter(structural);

signal Temp : std_logic_vector(7 downto 0);
signal Sbar : std_logic_vector(2 downto 0);

begin

	inverter_1 : inverter port map(S(2), Sbar(2));							-- Inverting S(2)
	inverter_2 : inverter port map(S(1), Sbar(1));							-- Inverting S(1)
	inverter_3 : inverter port map(S(0), Sbar(0));							-- Inverting S(0)
	
	and2_1 : and2 port map(Sbar(0), Sbar(1), Temp(0));
	and2_2 : and2 port map(Sbar(2), Temp(0), D(0));							-- Equation for D(0)
	and2_3 : and2 port map(S(0), Sbar(1), Temp(1));
	and2_4 : and2 port map(Sbar(2), Temp(1), D(1));							-- Equation for D(1)
	and2_5 : and2 port map(Sbar(0), S(1), Temp(2));
	and2_6 : and2 port map(Sbar(2), Temp(2), D(2));							-- Equation for D(2)
	and2_7 : and2 port map(S(0), S(1), Temp(3));
	and2_8 : and2 port map(Sbar(2), Temp(3), D(3));							-- Equation for D(3)
	and2_9 : and2 port map(S(2), Temp(0), D(4));							-- Equation for D(4)
	and2_10 : and2 port map(S(2), Temp(1), D(5));							-- Equation for D(5)
	and2_11 : and2 port map(S(2), Temp(2), D(6));							-- Equation for D(6)
	and2_12 : and2 port map(S(2), Temp(3), D(7));							-- Equation for D(7)
	
end structural;

