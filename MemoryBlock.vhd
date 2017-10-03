-------------------------------------------------------
--Entity : MemoryBlock
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity MemoryBlock is
	port(
		WriteDataBlock : in std_logic_vector(7 downto 0);
		WriteDataEnable : in std_logic_vector(3 downto 0);
		ReadEnableBlock : in std_logic_vector(3 downto 0);
		ReadEnableBlockBar : in std_logic_vector(3 downto 0);
		ReadDataBlock : out std_logic_vector(7 downto 0));
end MemoryBlock;

architecture structural of MemoryBlock is

component MemoryByte
	port(
		WriteDataByte : in std_logic_vector(7 downto 0);
		WriteDataEnable : in std_logic;
		ReadEnableByte : in std_logic;
		ReadEnableByteBar : in std_logic;
		ReadDataByte : out std_logic_vector(7 downto 0));
end component;

for MemoryByte_1, MemoryByte_2, MemoryByte_3, MemoryByte_4 : MemoryByte use entity work.MemoryByte(structural);

begin

	MemoryByte_1 : MemoryByte port map(WriteDataBlock(7 downto 0), WriteDataEnable(3), ReadEnableBlock(3), ReadEnableBlockBar(3), ReadDataBlock(7 downto 0));
	MemoryByte_2 : MemoryByte port map(WriteDataBlock(7 downto 0), WriteDataEnable(2), ReadEnableBlock(2), ReadEnableBlockBar(2), ReadDataBlock(7 downto 0));
	MemoryByte_3 : MemoryByte port map(WriteDataBlock(7 downto 0), WriteDataEnable(1), ReadEnableBlock(1), ReadEnableBlockBar(1), ReadDataBlock(7 downto 0));
	MemoryByte_4 : MemoryByte port map(WriteDataBlock(7 downto 0), WriteDataEnable(0), ReadEnableBlock(0), ReadEnableBlockBar(0), ReadDataBlock(7 downto 0));

end structural;