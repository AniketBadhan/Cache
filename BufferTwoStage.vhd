-------------------------------------------------------
--Entity : BufferTwoStage
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity BufferTwoStage is
	port(
		input : in std_logic;
		output : out std_logic);
end BufferTwoStage;

architecture structural of BufferTwoStage is

component inverter 
	port(
		input : in std_logic;
		output : out std_logic);
end component;

for inverter_1, inverter_2 : inverter use entity work.inverter(structural);

signal tempoutput : std_logic;

begin

	inverter_1 : inverter port map(input, tempoutput);
	inverter_2 : inverter port map(tempoutput, output);
  
end structural;