---------------------------------------------------------
--Entity : chip
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use STD.textio.all;

entity chip is
	port(
		cpu_add : in std_logic_vector(7 downto 0);
		cpu_data : inout std_logic_vector(7 downto 0);
		cpu_rd_wrn : in std_logic;
		start : in std_logic;
		clk : in std_logic;
		reset : in std_logic;
		mem_data : in std_logic_vector(7 downto 0);
		Vdd : in std_logic;
		Gnd : in std_logic;
		busy : out std_logic;
		mem_en : out std_logic;
		mem_add : out std_logic_vector(7 downto 0));
end chip;

architecture structural of chip is

component and2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component Register_8Bit
	port ( 
		DRegister   : in  std_logic_vector(7 downto 0);
        ClkRegister : in  std_logic;
        QRegister   : out std_logic_vector(7 downto 0);
        QRegisterbar: out std_logic_vector(7 downto 0));
end component;

component DFlipFlop
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;

component or2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component nor2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component xor2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component MemoryStructure
	port(
		OriginalStart : in std_logic;
		Stored_St : in std_logic;
		Reset : in std_logic;
		StartReset : in std_logic;
		CPU_Address : in std_logic_vector(7 downto 0);
		CPU_Data : in std_logic_vector(7 downto 0);
		MemData : in std_logic_vector(7 downto 0);
		ClkMemoryStructure : in std_logic;
		ReadWrite : in std_logic;
		MemoryEnable : out std_logic;
		Busy : out std_logic;
		MemoryAddress : out std_logic_vector(7 downto 0);
		output_register : out std_logic_vector(7 downto 0));
end component;

component inverter 
	port(
		input : in std_logic;
		output : out std_logic);
end component;

component tx_8                      
  port ( 
		sel8   : in std_logic;
        selnot8: in std_logic;
        input8 : in std_logic_vector(7 downto 0);  
        output8 :out std_logic_vector(7 downto 0));
end component; 

component BufferTwoStage
	port(
		input : in std_logic;
		output : out std_logic);
end component;

for MemoryStructure_1 : MemoryStructure use entity work.MemoryStructure(structural);
for and2_1, and2_2 : and2 use entity work.and2(structural);
for Register_8Bit_1, Register_8Bit_2 : Register_8Bit use entity work.Register_8Bit(structural);
for DFlipFlop_1, DFlipFlop_2, DFlipFlop_3 : DFlipFlop use entity work.DFlipFlop(structural);
for nor2_1 : nor2 use entity work.nor2(structural);
for or2_1, or2_2 : or2 use entity work.or2(structural);
for inverter_1, inverter_2, inverter_3 : inverter use entity work.inverter(structural);
for tx_8_1 : tx_8 use entity work.tx_8(structural);
for BufferTwoStage_1 : BufferTwoStage use entity work.BufferTwoStage(structural);

signal startandreset : std_logic;
signal StoredReset, StoredResetBar, StoredStart, StoredStartBar : std_logic;
signal StoredCPU_Address, StoredCPU_AddressBar : std_logic_vector(7 downto 0);
signal StoredCPU_Data, StoredCPU_DataBar, temp_output_read, StoredMemData, StoredMemDataBar, readoutput : std_logic_vector(7 downto 0);
signal StoredReadWrite, StoredReadWriteBar : std_logic;
signal clkfinal, temp1 : std_logic;
signal startbar, st_rst, st_rstbar : std_logic;
signal tempbusy, tempbusybar, CPUDataReadEnable, CPUDataReadEnableBar : std_logic;

begin
	
	
	or2_1 : or2 port map(start, reset, st_rst);
	inverter_1 : inverter port map(st_rst, st_rstbar);
	
	nor2_1 : nor2 port map(start, reset, temp1);
	or2_2 : or2 port map(temp1, clk, clkfinal);
	
	Register_8Bit_1 : Register_8Bit port map(cpu_add(7 downto 0), st_rstbar, StoredCPU_Address(7 downto 0), StoredCPU_AddressBar(7 downto 0));		-- Storing CPU Address
	Register_8Bit_2 : Register_8Bit port map(cpu_data(7 downto 0), st_rstbar, StoredCPU_Data(7 downto 0), StoredCPU_DataBar(7 downto 0));			-- Storing CPU Data
	DFlipFlop_1 : DFlipFlop port map(cpu_rd_wrn, st_rstbar, StoredReadWrite, StoredReadWriteBar);													-- Storing RD/WR input from CPU
	DFlipFlop_2 : DFlipFlop port map(reset, clkfinal, StoredReset, StoredResetBar);
	DFlipFlop_3 : DFlipFlop port map(start, clkfinal, StoredStart, StoredStartBar);
	-- Register_8Bit_3 : Register_8Bit port map(mem_data(7 downto 0), st_rstbar, StoredMemData(7 downto 0), StoredMemDataBar(7 downto 0));
	
	and2_1 : and2 port map(StoredStart, StoredResetBar, startandreset);
	MemoryStructure_1 : MemoryStructure port map(start, StoredStart, StoredReset, startandreset, StoredCPU_Address, StoredCPU_Data(7 downto 0), mem_data(7 downto 0), clk, StoredReadWrite, mem_en, tempbusy , mem_add(7 downto 0), readoutput(7 downto 0));
	
	and2_2 : and2 port map(StoredReadWrite, tempbusybar, CPUDataReadEnable);
	
	inverter_2 : inverter port map(tempbusy, tempbusybar);
	inverter_3 : inverter port map(CPUDataReadEnable, CPUDataReadEnableBar);
	
	tx_8_1 : tx_8 port map(CPUDataReadEnable, CPUDataReadEnableBar, readoutput(7 downto 0), cpu_data(7 downto 0));
	
	-- or2_3 : or2 port map(start, tempbusy, busy);
	
	BufferTwoStage_1 : BufferTwoStage port map(tempbusy, busy);

end structural;


