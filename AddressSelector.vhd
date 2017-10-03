-- Entity: AddressSelector
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/11/2003
--
  
library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity AddressSelector is                      
  port (
		CPUAdd : in std_logic_vector(1 downto 0);
		Read_Miss : in std_logic;
		c9, c10 : in std_logic;
		c11, c12 : in std_logic;
		c13, c14 : in std_logic;
		c15, c16 : in std_logic;
		Address : out std_logic_vector(1 downto 0));
end AddressSelector;          

architecture structural of AddressSelector is

component inverter 
	port(
		input : in std_logic;
		output : out std_logic);
end component;

component tx2Bit
  port ( 
		readenable     : in std_logic;
        readenablebar  : in std_logic;
        input2  : in std_logic_vector(1 downto 0);  
        output2 :out std_logic_vector(1 downto 0));
end component;

component tihi
	port(
		output : out std_logic);
end component;

component tilo
	port(
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
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

component DFlipFlop
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;

for tx2Bit_1, tx2Bit_2, tx2Bit_3, tx2Bit_4, tx2Bit_5, tx2Bit_6 : tx2Bit use entity work.tx2Bit(structural);
for tilo_1, tilo_2, tilo_3, tilo_4 : tilo use entity work.tilo(structural);
for tihi_1, tihi_2, tihi_3, tihi_4 : tihi use entity work.tihi(structural);
for inverter_1, inverter_2, inverter_3, inverter_4, inverter_5, inverter_6, inverter_7 : inverter use entity work.inverter(structural);
for and2_1, and2_2, and2_3, and2_4, and2_5 : and2 use entity work.and2(structural);
for or3_1 : or3 use entity work.or3(structural);
for or2_1, or2_2, or2_3, or2_4, or2_5 : or2 use entity work.or2(structural);

signal temp1, temp2, temp3, temp4, tempadd, AddressBar : std_logic_vector(1 downto 0);
signal tempread, tempreadbar : std_logic_vector(4 downto 0);
signal temp, tempAddressEnable, AddressEnable, ReadMissOtherCycles, ReadMissOtherCyclesBar, c910, c1112,c1314, c1516 : std_logic;

begin
	
	
	or2_1 : or2 port map(c9, c10, c910);
	or2_2 : or2 port map(c11, c12, c1112);
	or2_3 : or2 port map(c13, c14, c1314);
	or2_4 : or2 port map(c15, c16, c1516);
	
	and2_1 : and2 port map(Read_Miss, c910, tempread(1));
	and2_2 : and2 port map(Read_Miss, c1112, tempread(2));
	and2_3 : and2 port map(Read_Miss, c1314, tempread(3));
	and2_4 : and2 port map(Read_Miss, c1516, tempread(4));
	
	inverter_1 : inverter port map(tempread(1), tempreadbar(1));
	inverter_2 : inverter port map(tempread(2), tempreadbar(2));
	inverter_3 : inverter port map(tempread(3), tempreadbar(3));
	inverter_4 : inverter port map(tempread(4), tempreadbar(4));
	inverter_5 : inverter port map(Read_Miss, tempread(0));
	
	tilo_1 : tilo port map(temp1(0));
	tilo_2 : tilo port map(temp1(1));
	tilo_3 : tilo port map(temp2(1));
	tilo_4 : tilo port map(temp3(0));
	tihi_1 : tihi port map(temp2(0));
	tihi_2 : tihi port map(temp3(1));
	tihi_3 : tihi port map(temp4(0));
	tihi_4 : tihi port map(temp4(1));
	
	tx2Bit_1 : tx2Bit port map(tempread(1), tempreadbar(1), temp1(1 downto 0), Address(1 downto 0));
	tx2Bit_2 : tx2Bit port map(tempread(2), tempreadbar(2), temp2(1 downto 0), Address(1 downto 0));
	tx2Bit_3 : tx2Bit port map(tempread(3), tempreadbar(3), temp3(1 downto 0), Address(1 downto 0));
	tx2Bit_4 : tx2Bit port map(tempread(4), tempreadbar(4), temp4(1 downto 0), Address(1 downto 0));
	tx2Bit_5 : tx2Bit port map(tempread(0), Read_Miss, CPUAdd(1 downto 0), Address(1 downto 0));
	
	or3_1 : or3 port map(c910, c1112, c1314, temp);
	or2_5 : or2 port map(c1516, temp, tempAddressEnable);
	
	inverter_6 : inverter port map(tempAddressEnable, AddressEnable);
	
	and2_5 : and2 port map(AddressEnable, Read_Miss, ReadMissOtherCycles);
	inverter_7 : inverter port map(ReadMissOtherCycles, ReadMissOtherCyclesBar); 
	
	tx2Bit_6 : tx2Bit port map(ReadMissOtherCycles, ReadMissOtherCyclesBar, CPUAdd(1 downto 0), Address(1 downto 0));
	

end structural;
 