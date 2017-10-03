-------------------------------------------------------
--Entity : ValidBit_TagComp
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity ValidBit_TagComp is
	port(
		Or_Start : in std_logic;
		CPU_Add : in std_logic_vector(7 downto 5);
		ValidBit : in std_logic;
		Tag : in std_logic_vector(2 downto 0);
		TempValiDTagComp : out std_logic;
		ValidBit_TagCompResult : out std_logic);
end ValidBit_TagComp;

architecture structural of ValidBit_TagComp is

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

component and3
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

component xnor2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

for and2_1, and2_2, and2_3 : and2 use entity work.and2(structural);
for and3_1 : and3 use entity work.and3(structural);
for xnor2_1, xnor2_2, xnor2_3 : xnor2 use entity work.xnor2(structural);

signal Temp : std_logic_vector(2 downto 0);
signal Temp_And_Output : std_logic_vector(1 downto 0);

begin

	xnor2_1 : xnor2 port map(Tag(2), CPU_Add(7), Temp(2));										-- compare the MSB of TagRead with 7th bit in CPU_Add
	xnor2_2 : xnor2 port map(Tag(1), CPU_Add(6), Temp(1));										-- compare the TagRead(1) with 6th bit in CPU_Add
	xnor2_3 : xnor2 port map(Tag(0), CPU_Add(5), Temp(0));										-- compare the LSB of TagRead with 5th bit in CPU_Add
	
	and2_1 : and2 port map(Temp(2), Temp(1), Temp_And_Output(1));								-- AND the outputs of xnor for MSB and next bit of Tag of address and tag actyally present
	and2_2 : and2 port map(Temp(0), ValidBit, Temp_And_Output(0));								-- AND the LSB of Tag of address and tag actyally present and the ValidReadBit value
	and2_3 : and2 port map(Temp_And_Output(1), Temp_And_Output(0), TempValiDTagComp);			-- AND the output of and2_1 and and2_2, the output is 1 if its hit, 0 if miss
	and3_1 : and3 port map(Or_Start, Temp_And_Output(1), Temp_And_Output(0), ValidBit_TagCompResult);

end structural;