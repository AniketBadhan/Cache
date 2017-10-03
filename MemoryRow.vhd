-------------------------------------------------------
--Entity : MemoryRow
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity MemoryRow is
	port(
		ValidData : in std_logic;
		TagData : in std_logic_vector(2 downto 0);
		WriteDataBlock : in std_logic_vector(7 downto 0);
		WriteEnableRow : in std_logic_vector(4 downto 0);
		ReadEnableRow : in std_logic_vector(4 downto 0);
		ReadEnableRowBar : in std_logic_vector(4 downto 0);
		ValidReadData : out std_logic;
		TagReadData : out std_logic_vector(2 downto 0);
		ReadDataBlock : out std_logic_vector(7 downto 0));
end MemoryRow;

architecture structural of MemoryRow is

component SingleMemoryCell
	port(
		WriteData : in std_logic;
		WriteEnable : in std_logic;
		ReadEnable : in std_logic;
		ReadEnableBar : in std_logic;
		ReadData : out std_logic);
end component;

component MemoryBlock
	port(
		WriteDataBlock : in std_logic_vector(7 downto 0);
		WriteDataEnable : in std_logic_vector(3 downto 0);
		ReadEnableBlock : in std_logic_vector(3 downto 0);
		ReadEnableBlockBar : in std_logic_vector(3 downto 0);
		ReadDataBlock : out std_logic_vector(7 downto 0));
end component;

for SingleMemoryCell_1, SingleMemoryCell_2, SingleMemoryCell_3, SingleMemoryCell_4 : SingleMemoryCell use entity work.SingleMemoryCell(structural);
for MemoryBlock_1 : MemoryBlock use entity work.MemoryBlock(structural);

begin

	SingleMemoryCell_1 : SingleMemoryCell port map(ValidData, WriteEnableRow(4), ReadEnableRow(4), ReadEnableRowBar(4), ValidReadData);
	SingleMemoryCell_2 : SingleMemoryCell port map(TagData(0), WriteEnableRow(4), ReadEnableRow(4), ReadEnableRowBar(4), TagReadData(0));
	SingleMemoryCell_3 : SingleMemoryCell port map(TagData(1), WriteEnableRow(4), ReadEnableRow(4), ReadEnableRowBar(4), TagReadData(1));
	SingleMemoryCell_4 : SingleMemoryCell port map(TagData(2), WriteEnableRow(4), ReadEnableRow(4), ReadEnableRowBar(4), TagReadData(2));
	MemoryBlock_1 : MemoryBlock port map(WriteDataBlock(7 downto 0), WriteEnableRow(3 downto 0), ReadEnableRow(3 downto 0), ReadEnableRowBar(3 downto 0), ReadDataBlock(7 downto 0));

end structural; 