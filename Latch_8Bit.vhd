-------------------------------------------------------
--Entity : Register_8Bit
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Latch_8Bit is 
	port ( 
		Latch_Input   : in  std_logic_vector(7 downto 0);
        ClkRegister : in  std_logic;
        Latch_Output   : out std_logic_vector(7 downto 0);
        Latch_OutputBar: out std_logic_vector(7 downto 0)); 
end Latch_8Bit;

architecture structural of Latch_8Bit is

component DLatch
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;

for DLatch_1, DLatch_2, DLatch_3, DLatch_4, DLatch_5, DLatch_6, DLatch_7, DLatch_8 : DLatch use entity work.DLatch(structural);

begin 

	DLatch_1 : DLatch port map(Latch_Input(0), ClkRegister, Latch_Output(0), Latch_OutputBar(0));
	DLatch_2 : DLatch port map(Latch_Input(1), ClkRegister, Latch_Output(1), Latch_OutputBar(1));
	DLatch_3 : DLatch port map(Latch_Input(2), ClkRegister, Latch_Output(2), Latch_OutputBar(2));
	DLatch_4 : DLatch port map(Latch_Input(3), ClkRegister, Latch_Output(3), Latch_OutputBar(3));
	DLatch_5 : DLatch port map(Latch_Input(4), ClkRegister, Latch_Output(4), Latch_OutputBar(4));
	DLatch_6 : DLatch port map(Latch_Input(5), ClkRegister, Latch_Output(5), Latch_OutputBar(5));
	DLatch_7 : DLatch port map(Latch_Input(6), ClkRegister, Latch_Output(6), Latch_OutputBar(6));
	DLatch_8 : DLatch port map(Latch_Input(7), ClkRegister, Latch_Output(7), Latch_OutputBar(7));
	
end structural	;