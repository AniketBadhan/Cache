-------------------------------------------------------
--Entity : Register_8Bit
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Register_8Bit is 
	port ( 
		DRegister   : in  std_logic_vector(7 downto 0);
        ClkRegister : in  std_logic;
        QRegister   : out std_logic_vector(7 downto 0);
        QRegisterbar: out std_logic_vector(7 downto 0)); 
end Register_8Bit;

architecture structural of Register_8Bit is

component DFlipFlop
  port ( 
	d   : in  std_logic;
    clk : in  std_logic;
	q   : out std_logic;
	qbar: out std_logic); 
end component;

for DFlipFlop_1, DFlipFlop_2, DFlipFlop_3, DFlipFlop_4, DFlipFlop_5, DFlipFlop_6, DFlipFlop_7, DFlipFlop_8 : DFlipFlop use entity work.DFlipFlop(structural);

begin 

	DFlipFlop_1 : DFlipFlop port map(DRegister(0), ClkRegister, QRegister(0), QRegisterbar(0));
	DFlipFlop_2 : DFlipFlop port map(DRegister(1), ClkRegister, QRegister(1), QRegisterbar(1));
	DFlipFlop_3 : DFlipFlop port map(DRegister(2), ClkRegister, QRegister(2), QRegisterbar(2));
	DFlipFlop_4 : DFlipFlop port map(DRegister(3), ClkRegister, QRegister(3), QRegisterbar(3));
	DFlipFlop_5 : DFlipFlop port map(DRegister(4), ClkRegister, QRegister(4), QRegisterbar(4));
	DFlipFlop_6 : DFlipFlop port map(DRegister(5), ClkRegister, QRegister(5), QRegisterbar(5));
	DFlipFlop_7 : DFlipFlop port map(DRegister(6), ClkRegister, QRegister(6), QRegisterbar(6));
	DFlipFlop_8 : DFlipFlop port map(DRegister(7), ClkRegister, QRegister(7), QRegisterbar(7));
	
end structural	;