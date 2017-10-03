-------------------------------------------------------
--Entity : MemoryByte
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity MemoryByte is
	port(
		WriteDataByte : in std_logic_vector(7 downto 0);
		WriteDataEnable : in std_logic;
		ReadEnableByte : in std_logic;
		ReadEnableByteBar : in std_logic;
		ReadDataByte : out std_logic_vector(7 downto 0));
end MemoryByte;

architecture structural of MemoryByte is

component SingleMemoryCell
	port(
		WriteData : in std_logic;
		WriteEnable : in std_logic;
		ReadEnable : in std_logic;
		ReadEnableBar : in std_logic;
		ReadData : out std_logic);
end component;

for SingleMemoryCell_1, SingleMemoryCell_2, SingleMemoryCell_3, SingleMemoryCell_4, SingleMemoryCell_5, SingleMemoryCell_6, SingleMemoryCell_7, SingleMemoryCell_8 : SingleMemoryCell use entity work.SingleMemoryCell(structural);

begin
	
	SingleMemoryCell_1 : SingleMemoryCell port map(WriteDataByte(0), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(0));
	SingleMemoryCell_2 : SingleMemoryCell port map(WriteDataByte(1), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(1));
	SingleMemoryCell_3 : SingleMemoryCell port map(WriteDataByte(2), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(2));
	SingleMemoryCell_4 : SingleMemoryCell port map(WriteDataByte(3), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(3));
	SingleMemoryCell_5 : SingleMemoryCell port map(WriteDataByte(4), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(4));
	SingleMemoryCell_6 : SingleMemoryCell port map(WriteDataByte(5), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(5));
	SingleMemoryCell_7 : SingleMemoryCell port map(WriteDataByte(6), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(6));
	SingleMemoryCell_8 : SingleMemoryCell port map(WriteDataByte(7), WriteDataEnable, ReadEnableByte, ReadEnableByteBar, ReadDataByte(7));
	
end structural;