-------------------------------------------------------
--Entity : FullMemory
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity FullMemory is
	port(
		ValidData_FullMemory : in std_logic;
		TagData_FullMemory : in std_logic_vector(2 downto 0);
		WriteDataBlock_FullMemory : in std_logic_vector(7 downto 0);
		WriteEnableRow_FullMemory : in std_logic_vector(39 downto 0);
		ReadEnableRow_FullMemory : in std_logic_vector(39 downto 0);
		ReadEnableRowBar_FullMemory : in std_logic_vector(39 downto 0);
		ValidReadData_FullMemory : out std_logic;
		TagReadData_FullMemory : out std_logic_vector(2 downto 0);
		ReadDataBlock_FullMemory : out std_logic_vector(7 downto 0));
end FullMemory;

architecture structural of FullMemory is

component MemoryRow
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
end component;

for MemoryRow_1, MemoryRow_2, MemoryRow_3, MemoryRow_4, MemoryRow_5, MemoryRow_6, MemoryRow_7, MemoryRow_8 : MemoryRow use 	entity work.MemoryRow(structural);

begin

	MemoryRow_1 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(39 downto 35),  ReadEnableRow_FullMemory(39 downto 35), ReadEnableRowBar_FullMemory(39 downto 35), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_2 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(34 downto 30),  ReadEnableRow_FullMemory(34 downto 30), ReadEnableRowBar_FullMemory(34 downto 30), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_3 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(29 downto 25),  ReadEnableRow_FullMemory(29 downto 25), ReadEnableRowBar_FullMemory(29 downto 25), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_4 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(24 downto 20),  ReadEnableRow_FullMemory(24 downto 20), ReadEnableRowBar_FullMemory(24 downto 20), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_5 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(19 downto 15),  ReadEnableRow_FullMemory(19 downto 15), ReadEnableRowBar_FullMemory(19 downto 15), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_6 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(14 downto 10),  ReadEnableRow_FullMemory(14 downto 10), ReadEnableRowBar_FullMemory(14 downto 10), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_7 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(9 downto 5),  ReadEnableRow_FullMemory(9 downto 5), ReadEnableRowBar_FullMemory(9 downto 5), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));
	MemoryRow_8 : MemoryRow port map(ValidData_FullMemory, TagData_FullMemory(2 downto 0), WriteDataBlock_FullMemory(7 downto 0), WriteEnableRow_FullMemory(4 downto 0),  ReadEnableRow_FullMemory(4 downto 0), ReadEnableRowBar_FullMemory(4 downto 0), ValidReadData_FullMemory, TagReadData_FullMemory(2 downto 0), ReadDataBlock_FullMemory(7 downto 0));

end structural;