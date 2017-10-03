	-------------------------------------------------------
--Entity : Data_Write
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Data_Write is
	port(
		ReadMissOperation : in std_logic;
		WriteHitOperation : in std_logic;
		MemData : in std_logic_vector(7 downto 0);
		CPUData : in std_logic_vector(7 downto 0);
		c9, c10, c11, c12, c13, c14, c15, c16 : in std_logic;
		CPUWriteData : out std_logic_vector(7 downto 0));
end Data_Write;

architecture structural	of Data_Write is

component inverter 
	port(
		input : in std_logic;
		output : out std_logic);
end component;

component and2 
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component or2 
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component or3 
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

component tx_8                      
  port ( 
		sel8   : in std_logic;
        selnot8: in std_logic;
        input8 : in std_logic_vector(7 downto 0);  
        output8 :out std_logic_vector(7 downto 0));
end component; 

for inverter_1, inverter_2 : inverter use entity work.inverter(structural);
for and2_1 : and2 use entity work.and2(structural);
for or2_1 : or2 use entity work.or2(structural);
for or3_1, or3_2, or3_3 : or3 use entity work.or3(structural);
for tx_8_1, tx_8_2 : tx_8 use entity work.tx_8(structural);

signal temp : std_logic_vector(15 downto 0);
signal ReadMissCycles, ReadMiss, ReadMissBar, WriteHitOperationBar : std_logic;

begin

	or3_1 : or3 port map(c9, c10, c11, temp(0));
	or3_2 : or3 port map(c12, c13, c14, temp(1));
	or2_1 : or2 port map(c15, c16, temp(2));
	or3_3 : or3 port map(temp(0), temp(1), temp(2), ReadMissCycles);
	and2_1 : and2 port map(ReadMissOperation, ReadMissCycles, ReadMiss);
	
	inverter_1 : inverter port map(ReadMiss, ReadMissBar);
	inverter_2 : inverter port map(WriteHitOperation, WriteHitOperationBar);
	
	tx_8_1 : tx_8 port map(ReadMiss, ReadMissBar, MemData(7 downto 0), CPUWriteData(7 downto 0));
	tx_8_2 : tx_8 port map(WriteHitOperation, WriteHitOperationBar, CPUData(7 downto 0), CPUWriteData(7 downto 0));
	
	
end structural;


