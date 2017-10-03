-------------------------------------------------------
--Entity : Register_3Bit
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Register_3Bit is 
	port ( 
		DRegister   : in  std_logic_vector(2 downto 0);
        ClkRegister : in  std_logic;
        QRegister   : out std_logic_vector(2 downto 0);
        QRegisterbar: out std_logic_vector(2 downto 0)); 
end Register_3Bit;

architecture structural of Register_3Bit is

component DFlipFlop
  port ( 
	d   : in  std_logic;
    clk : in  std_logic;
	q   : out std_logic;
	qbar: out std_logic); 
end component;

for DFlipFlop_1, DFlipFlop_2, DFlipFlop_3 : DFlipFlop use entity work.DFlipFlop(structural);

begin 

	DFlipFlop_1 : DFlipFlop port map(DRegister(0), ClkRegister, QRegister(0), QRegisterbar(0));
	DFlipFlop_2 : DFlipFlop port map(DRegister(1), ClkRegister, QRegister(1), QRegisterbar(1));
	DFlipFlop_3 : DFlipFlop port map(DRegister(2), ClkRegister, QRegister(2), QRegisterbar(2));
	
end structural	;