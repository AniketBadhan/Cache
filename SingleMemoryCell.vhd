-------------------------------------------------------
--Entity : SingleMemoryCell
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

Entity SingleMemoryCell is 
	port(
		WriteData : in std_logic;
		WriteEnable : in std_logic;
		ReadEnable : in std_logic;
		ReadEnableBar : in std_logic;
		ReadData : out std_logic);
end SingleMemoryCell;

architecture structural of SingleMemoryCell is

component DLatch
  port ( 
		d   : in  std_logic;
		clk : in  std_logic;
        q   : out std_logic;
        qbar: out std_logic); 
end component;

component tx
  port ( 
		sel   : in std_logic;
        selnot: in std_logic;
        input : in std_logic;  
        output: out std_logic);
end component;	

for DLatch_1 : DLatch use entity work.DLatch(structural);
for tx_1 : tx use entity work.tx(structural);

signal Temp, Tempbar : std_logic;

begin
	
	DLatch_1 : DLatch port map(WriteData, WriteEnable, Temp, Tempbar);
	tx_1 : tx port map(ReadEnable, ReadEnableBar, Temp, ReadData);
	
end structural;
	
	
	
