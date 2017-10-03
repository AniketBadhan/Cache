-------------------------------------------------------
--Entity : MemoryStructure
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity MemoryStructure is
	port(
		OriginalStart : in std_logic;
		Stored_St : in std_logic;
		Reset : in std_logic;
		CPU_Address : in std_logic_vector(7 downto 0);
		CPU_Data : in std_logic_vector(7 downto 0);
		MemData : in std_logic_vector(7 downto 0);
		ClkMemoryStructure : in std_logic;
		ReadWrite : in std_logic;
		MemoryEnable : out std_logic;
		Busy : out std_logic;
		MemoryAddress : out std_logic_vector(7 downto 0);
		output_register : out std_logic_vector(7 downto 0));
end MemoryStructure;

architecture structural of MemoryStructure is

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

component nand2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component nand3
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

component and3
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

component Decoder3_8
	port(
		S : in std_logic_vector(2 downto 0);
		D : out std_logic_vector(7 downto 0));
end component;

component Decoder2_4
	port(
		S : in std_logic_vector(1 downto 0);
		D : out std_logic_vector(3 downto 0));
end component;

component FullMemory
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
end component;

component ValidBit_TagComp
	port(
		Or_Start : in std_logic;
		CPU_Add : in std_logic_vector(7 downto 5);
		ValidBit : in std_logic;
		Tag : in std_logic_vector(2 downto 0);
		TempValiDTagComp : out std_logic;
		ValidBit_TagCompResult : out std_logic);
end component;

component Counter
	port(
		CPU_Address : in std_logic_vector(7 downto 2);
		Orig_Start : in std_logic;
		ReadHit : in std_logic;
		ReadMiss : in std_logic;
		WriteHit : in std_logic;
		WriteMiss : in std_logic;
		clk : in  std_logic;
		BusyCounter : out std_logic;
		Enable : out std_logic;
		Mem_Address : out std_logic_vector(7 downto 0);
		Cycle9 : out std_logic;
		Cycle11 : out std_logic;
		Cycle13 : out std_logic;
		Cycle15 : out std_logic;
		ReadEnable : out std_logic;
		WriteEnable : out std_logic;
		Cycle10, Cycle12, CYcle14, Cycle16 : out std_logic);
end component;

component Register_3Bit
	port ( 
		DRegister   : in  std_logic_vector(2 downto 0);
        ClkRegister : in  std_logic;
        QRegister   : out std_logic_vector(2 downto 0);
        QRegisterbar: out std_logic_vector(2 downto 0)); 
end component;

component tihi
	port(
		output : out std_logic);
end component;

component BufferTwoStage
	port(
		input : in std_logic;
		output : out std_logic);
end component;

component DFlipFlop
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;

component xor2
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component DLatch
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic);
end component;

component Register_8Bit
	port ( 
		DRegister   : in  std_logic_vector(7 downto 0);
        ClkRegister : in  std_logic;
        QRegister   : out std_logic_vector(7 downto 0);
        QRegisterbar: out std_logic_vector(7 downto 0)); 
end component;

component Data_Write
	port(
		ReadMissOperation : in std_logic;
		WriteHitOperation : in std_logic;
		MemData : in std_logic_vector(7 downto 0);
		CPUData : in std_logic_vector(7 downto 0);
		c9, c10, c11, c12, c13, c14, c15, c16 : in std_logic;
		CPUWriteData : out std_logic_vector(7 downto 0));
end component;

component AddressSelector
  port (
		CPUAdd : in std_logic_vector(1 downto 0);
		Read_Miss : in std_logic;
		c9, c10 : in std_logic;
		c11, c12 : in std_logic;
		c13, c14 : in std_logic;
		c15, c16 : in std_logic;
		Address : out std_logic_vector(1 downto 0));
end component;

for Decoder2_4_1 : Decoder2_4 use entity work.Decoder2_4(structural);
for Decoder3_8_1 : Decoder3_8 use entity work.Decoder3_8(structural);
for FullMemory_1 : FullMemory use entity work.FullMemory(structural);
for or2_1, or2_2, or2_3, or2_4, or2_5, or2_6, or2_7, or2_8, or2_9, or2_10, or2_11, or2_12 : or2 use entity work.or2(structural);
for inverter_1, inverter_2, inverter_3, inverter_4, inverter_5, inverter_6, inverter_7, inverter_8, inverter_9, inverter_10 : inverter use entity work.inverter(structural);
for inverter_11, inverter_12, inverter_13, inverter_14, inverter_15, inverter_16, inverter_17, inverter_18, inverter_19, inverter_20 : inverter use entity work.inverter(structural);
for inverter_21, inverter_22, inverter_23, inverter_24, inverter_25, inverter_26, inverter_27, inverter_28, inverter_29, inverter_30 : inverter use entity work.inverter(structural);
for inverter_31, inverter_32, inverter_33, inverter_34, inverter_35, inverter_36, inverter_37, inverter_38, inverter_39, inverter_40 : inverter use entity work.inverter(structural);
for inverter_41 : inverter use entity work.inverter(structural);
for ValidBit_TagComp_1 : ValidBit_TagComp use entity work.ValidBit_TagComp(structural);
for Counter_1 : Counter use entity work.Counter(structural);
for and3_1, and3_2, and3_3, and3_4, and3_5, and3_6, and3_7, and3_8, and3_9, and3_10 : and3 use entity work.and3(structural);
for and3_11, and3_12, and3_13, and3_14, and3_15, and3_16, and3_17, and3_18, and3_19, and3_20 : and3 use entity work.and3(structural);
for and3_21, and3_22, and3_23, and3_24, and3_25, and3_26, and3_27, and3_28, and3_29, and3_30 : and3 use entity work.and3(structural);
for and3_31, and3_32, and3_33, and3_34, and3_35, and3_36, and3_37, and3_38, and3_39, and3_40 : and3 use entity work.and3(structural);
for and3_41, and3_42, and3_43, and3_44, and3_45, and3_46, and3_47, and3_48, and3_49, and3_50 : and3 use entity work.and3(structural);
for and3_51, and3_52, and3_53, and3_54, and3_55, and3_56, and3_57, and3_58, and3_59, and3_60 : and3 use entity work.and3(structural);
for and3_61, and3_62, and3_63, and3_64, and3_65, and3_66, and3_67, and3_68, and3_69, and3_70, and3_71, and3_72 : and3 use entity work.and3(structural);
for and2_1, and2_2, and2_3, and2_4, and2_5, and2_6 : and2 use entity work.and2(structural);
for tihi_1 : tihi use entity work.tihi(structural);
for BufferTwoStage_1, BufferTwoStage_2, BufferTwoStage_3, BufferTwoStage_4, BufferTwoStage_5, BufferTwoStage_6, BufferTwoStage_7, BufferTwoStage_8 : BufferTwoStage use entity work.BufferTwoStage(structural);
for BufferTwoStage_9, BufferTwoStage_10, BufferTwoStage_11, BufferTwoStage_12, BufferTwoStage_13, BufferTwoStage_14 : BufferTwoStage use entity work.BufferTwoStage(structural);
for Dlatch_1, Dlatch_2, Dlatch_3, Dlatch_4, Dlatch_5, Dlatch_6 : Dlatch use entity work.Dlatch(structural);
for Data_Write_1 : Data_Write use entity work.Data_Write(structural);
for AddressSelector_1 : AddressSelector use entity work.AddressSelector(structural);

signal ValidTagComp, ValidTagCompBar, ValidClk, TempReadHit, TempReadMiss, TempWriteHit, TempWriteMiss, TempValid, WriteEn, WriteEnableMem : std_logic;
signal DecoderOutput3_8, DecoderOutputBar3_8, NewCPUAddress : std_logic_vector(7 downto 0);
signal DecoderOutput2_4 : std_logic_vector(3 downto 0);
signal DecoderOutputBar2_4 : std_logic_vector(3 downto 0);
signal DecoderAnd : std_logic_vector(31 downto 0);
signal DecodedReadEnable : std_logic_vector(39 downto 0);
signal DecodedReadEnableBar : std_logic_vector(39 downto 0);
signal ReadWriteBar, EnableHi, TempWriteEn, TempWriteEnBar : std_logic;
signal TempValidTagCompOutput, ValidReadBit: std_logic;
signal ReadHit, ReadHitBar, ReadMiss, ReadMissBar, WriteHit, WriteHitBar ,WriteMiss, WriteMissBar : std_logic;													-- TO and ValidTagComp Bit with RD/WR input to know which of the 4 options is the operation
signal TagRead : std_logic_vector(2 downto 0);
signal CycleHigh0Bar, MemEnable, TempMemEn : std_logic;
signal WriteEnableMemoryStructure : std_logic_vector(39 downto 0);
signal temp : std_logic_vector(51 downto 0);
signal ReadDataMemoryStructure : std_logic_vector(7 downto 0);
signal ValidHi, ValidWriteData, ResetBar, TempReadEnable : std_logic;
signal TempValidTagCompOutputBar, Cycle9High, CycleHigh0, Cycle11High, Cycle13High, Cycle15High, MemoryEnableBar, Tempclk, TempRead_Miss : std_logic;
signal Cycle10High, Cycle12High, Cycle14High, Cycle16High : std_logic;
signal input_register : std_logic_vector(7 downto 0);

begin
	
	-- Register_8Bit_1 : Register_8Bit port map(CPU_Data(7 downto 0), ClkMemoryStructure, input_register(7 downto 0), input_registerbar(7 downto 0));
	
	Decoder3_8_1 : Decoder3_8 port map(NewCPUAddress(4 downto 2), DecoderOutput3_8(7 downto 0));		-- Get the row number which is to be enabled from the CPU_Address(4 downto 2), i.e., the block number
	
	Decoder2_4_1 : Decoder2_4 port map(NewCPUAddress(1 downto 0), DecoderOutput2_4(3 downto 0));		-- Decoding the Block number based on last 2 bits in CPU Address
	
	tihi_1 : tihi port map(ValidHi);
	inverter_1 : inverter port map(Reset, ResetBar);
	inverter_2 : inverter port map(ReadWrite, ReadWriteBar);
	and2_1 : and2 port map(ValidHi, ResetBar, ValidWriteData);										-- Reset AND ValidHi, combination will tell whether to write 1 or 0 to ValidBits
	
	and3_65 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(7), temp(40));
	and3_66 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(6), temp(41));
	and3_67 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(5), temp(42));
	and3_68 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(4), temp(43));
	and3_69 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(3), temp(44));
	and3_70 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(2), temp(45));
	and3_71 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(1), temp(46));
	and3_72 : and3 port map(Cycle9High, ReadMiss, DecoderOutput3_8(0), temp(47));
	
	or2_1 : or2 port map(Reset, temp(40), WriteEnableMemoryStructure(39));
	or2_2 : or2 port map(Reset, temp(41), WriteEnableMemoryStructure(34));
	or2_3 : or2 port map(Reset, temp(42), WriteEnableMemoryStructure(29));
	or2_4 : or2 port map(Reset, temp(43), WriteEnableMemoryStructure(24));
	or2_5 : or2 port map(Reset, temp(44), WriteEnableMemoryStructure(19));
	or2_6 : or2 port map(Reset, temp(45), WriteEnableMemoryStructure(14));
	or2_7 : or2 port map(Reset, temp(46), WriteEnableMemoryStructure(9));
	or2_8 : or2 port map(Reset, temp(47), WriteEnableMemoryStructure(4));
	
	or2_9 : or2 port map(Cycle9High, Cycle11High, temp(48));
	or2_10 : or2 port map(Cycle13High, Cycle15High, temp(49));
	or2_11 : or2 port map(temp(48), temp(49), temp(50));
	and2_2 : and2 port map(temp(50), ReadMiss, temp(51));
	
	Dlatch_1 : Dlatch port map(temp(51), ClkMemoryStructure, TempWriteEn, TempWriteEnBar);
	
	or2_12 : or2 port map(TempWriteEn, WriteEn, WriteEnableMem);
	
	and3_1 : and3 port map(WriteEnableMem, DecoderOutput3_8(7), DecoderOutput2_4(3), WriteEnableMemoryStructure(38));
	and3_2 : and3 port map(WriteEnableMem, DecoderOutput3_8(7), DecoderOutput2_4(2), WriteEnableMemoryStructure(37));
	and3_3 : and3 port map(WriteEnableMem, DecoderOutput3_8(7), DecoderOutput2_4(1), WriteEnableMemoryStructure(36));
	and3_4 : and3 port map(WriteEnableMem, DecoderOutput3_8(7), DecoderOutput2_4(0), WriteEnableMemoryStructure(35));
	and3_5 : and3 port map(WriteEnableMem, DecoderOutput3_8(6), DecoderOutput2_4(3), WriteEnableMemoryStructure(33));
	and3_6 : and3 port map(WriteEnableMem, DecoderOutput3_8(6), DecoderOutput2_4(2), WriteEnableMemoryStructure(32));
	and3_7 : and3 port map(WriteEnableMem, DecoderOutput3_8(6), DecoderOutput2_4(1), WriteEnableMemoryStructure(31));
	and3_8 : and3 port map(WriteEnableMem, DecoderOutput3_8(6), DecoderOutput2_4(0), WriteEnableMemoryStructure(30));
	and3_9 : and3 port map(WriteEnableMem, DecoderOutput3_8(5), DecoderOutput2_4(3), WriteEnableMemoryStructure(28));
	and3_10 : and3 port map(WriteEnableMem, DecoderOutput3_8(5), DecoderOutput2_4(2), WriteEnableMemoryStructure(27));
	and3_11 : and3 port map(WriteEnableMem, DecoderOutput3_8(5), DecoderOutput2_4(1), WriteEnableMemoryStructure(26));
	and3_12 : and3 port map(WriteEnableMem, DecoderOutput3_8(5), DecoderOutput2_4(0), WriteEnableMemoryStructure(25));
	and3_13 : and3 port map(WriteEnableMem, DecoderOutput3_8(4), DecoderOutput2_4(3), WriteEnableMemoryStructure(23));
	and3_14 : and3 port map(WriteEnableMem, DecoderOutput3_8(4), DecoderOutput2_4(2), WriteEnableMemoryStructure(22));
	and3_15 : and3 port map(WriteEnableMem, DecoderOutput3_8(4), DecoderOutput2_4(1), WriteEnableMemoryStructure(21));
	and3_16 : and3 port map(WriteEnableMem, DecoderOutput3_8(4), DecoderOutput2_4(0), WriteEnableMemoryStructure(20));
	and3_17 : and3 port map(WriteEnableMem, DecoderOutput3_8(3), DecoderOutput2_4(3), WriteEnableMemoryStructure(18));
	and3_18 : and3 port map(WriteEnableMem, DecoderOutput3_8(3), DecoderOutput2_4(2), WriteEnableMemoryStructure(17));
	and3_19 : and3 port map(WriteEnableMem, DecoderOutput3_8(3), DecoderOutput2_4(1), WriteEnableMemoryStructure(16));
	and3_20 : and3 port map(WriteEnableMem, DecoderOutput3_8(3), DecoderOutput2_4(0), WriteEnableMemoryStructure(15));
	and3_21 : and3 port map(WriteEnableMem, DecoderOutput3_8(2), DecoderOutput2_4(3), WriteEnableMemoryStructure(13));
	and3_22 : and3 port map(WriteEnableMem, DecoderOutput3_8(2), DecoderOutput2_4(2), WriteEnableMemoryStructure(12));
	and3_23 : and3 port map(WriteEnableMem, DecoderOutput3_8(2), DecoderOutput2_4(1), WriteEnableMemoryStructure(11));
	and3_24 : and3 port map(WriteEnableMem, DecoderOutput3_8(2), DecoderOutput2_4(0), WriteEnableMemoryStructure(10));
	and3_25 : and3 port map(WriteEnableMem, DecoderOutput3_8(1), DecoderOutput2_4(3), WriteEnableMemoryStructure(8));
	and3_26 : and3 port map(WriteEnableMem, DecoderOutput3_8(1), DecoderOutput2_4(2), WriteEnableMemoryStructure(7));
	and3_27 : and3 port map(WriteEnableMem, DecoderOutput3_8(1), DecoderOutput2_4(1), WriteEnableMemoryStructure(6));
	and3_28 : and3 port map(WriteEnableMem, DecoderOutput3_8(1), DecoderOutput2_4(0), WriteEnableMemoryStructure(5));
	and3_29 : and3 port map(WriteEnableMem, DecoderOutput3_8(0), DecoderOutput2_4(3), WriteEnableMemoryStructure(3));
	and3_30 : and3 port map(WriteEnableMem, DecoderOutput3_8(0), DecoderOutput2_4(2), WriteEnableMemoryStructure(2));
	and3_31 : and3 port map(WriteEnableMem, DecoderOutput3_8(0), DecoderOutput2_4(1), WriteEnableMemoryStructure(1));
	and3_32 : and3 port map(WriteEnableMem, DecoderOutput3_8(0), DecoderOutput2_4(0), WriteEnableMemoryStructure(0));

	
	BufferTwoStage_1 : BufferTwoStage port map(DecoderOutput3_8(7), DecodedReadEnable(39));				
	inverter_35 : inverter port map(DecodedReadEnable(39), DecodedReadEnableBar(39));				
	BufferTwoStage_2 : BufferTwoStage port map(DecoderOutput3_8(6), DecodedReadEnable(34));
	inverter_36 : inverter port map(DecodedReadEnable(34), DecodedReadEnableBar(34));
	BufferTwoStage_3 : BufferTwoStage port map(DecoderOutput3_8(5), DecodedReadEnable(29));
	inverter_37 : inverter port map(DecodedReadEnable(29), DecodedReadEnableBar(29));	
	BufferTwoStage_4 : BufferTwoStage port map(DecoderOutput3_8(4), DecodedReadEnable(24));
	inverter_38 : inverter port map(DecodedReadEnable(24), DecodedReadEnableBar(24));	
	BufferTwoStage_5 : BufferTwoStage port map(DecoderOutput3_8(3), DecodedReadEnable(19));
	inverter_39 : inverter port map(DecodedReadEnable(19), DecodedReadEnableBar(19));
	BufferTwoStage_6 : BufferTwoStage port map(DecoderOutput3_8(2), DecodedReadEnable(14));
	inverter_40 : inverter port map(DecodedReadEnable(14), DecodedReadEnableBar(14));	
	BufferTwoStage_7 : BufferTwoStage port map(DecoderOutput3_8(1), DecodedReadEnable(9));
	inverter_41 : inverter port map(DecodedReadEnable(9), DecodedReadEnableBar(9));	
	BufferTwoStage_8 : BufferTwoStage port map(DecoderOutput3_8(0), DecodedReadEnable(4));
	inverter_42 : inverter port map(DecodedReadEnable(4), DecodedReadEnableBar(4));
	
	and3_33 : and3 port map(TempReadEnable, DecoderOutput3_8(7), DecoderOutput2_4(3), DecodedReadEnable(38));			-- DecodedReadEnableBar will be zero, if ReadWrite, DecoderOutput3_8 and DecoderOutput2_4 are all 1
	inverter_3 : inverter port map(DecodedReadEnable(38), DecodedReadEnableBar(38));									-- If DecodedReadEnableBar is 0,then it makes DecodedReadEnable as 1
	and3_34 : and3 port map(TempReadEnable, DecoderOutput3_8(7), DecoderOutput2_4(2), DecodedReadEnable(37));
	inverter_4 : inverter port map(DecodedReadEnable(37), DecodedReadEnableBar(37));	
	and3_35 : and3 port map(TempReadEnable, DecoderOutput3_8(7), DecoderOutput2_4(1), DecodedReadEnable(36));
	inverter_5 : inverter port map(DecodedReadEnable(36), DecodedReadEnableBar(36));	
	and3_36 : and3 port map(TempReadEnable, DecoderOutput3_8(7), DecoderOutput2_4(0), DecodedReadEnable(35));
	inverter_6 : inverter port map(DecodedReadEnable(35), DecodedReadEnableBar(35));
	
	and3_37 : and3 port map(TempReadEnable, DecoderOutput3_8(6), DecoderOutput2_4(3), DecodedReadEnable(33));
	inverter_7 : inverter port map(DecodedReadEnable(33), DecodedReadEnableBar(33));	
	and3_38 : and3 port map(TempReadEnable, DecoderOutput3_8(6), DecoderOutput2_4(2), DecodedReadEnable(32));
	inverter_8 : inverter port map(DecodedReadEnable(32), DecodedReadEnableBar(32));	
	and3_39 : and3 port map(TempReadEnable, DecoderOutput3_8(6), DecoderOutput2_4(1), DecodedReadEnable(31));
	inverter_9 : inverter port map(DecodedReadEnable(31), DecodedReadEnableBar(31));	
	and3_40 : and3 port map(TempReadEnable, DecoderOutput3_8(6), DecoderOutput2_4(0), DecodedReadEnable(30));
	inverter_10 : inverter port map(DecodedReadEnable(30), DecodedReadEnableBar(30));
	
	and3_41 : and3 port map(TempReadEnable, DecoderOutput3_8(5), DecoderOutput2_4(3), DecodedReadEnable(28));
	inverter_11 : inverter port map(DecodedReadEnable(28), DecodedReadEnableBar(28));	
	and3_42 : and3 port map(TempReadEnable, DecoderOutput3_8(5), DecoderOutput2_4(2), DecodedReadEnable(27));
	inverter_12 : inverter port map(DecodedReadEnable(27), DecodedReadEnableBar(27));	
	and3_43 : and3 port map(TempReadEnable, DecoderOutput3_8(5), DecoderOutput2_4(1), DecodedReadEnable(26));
	inverter_13 : inverter port map(DecodedReadEnable(26), DecodedReadEnableBar(26));	
	and3_44 : and3 port map(TempReadEnable, DecoderOutput3_8(5), DecoderOutput2_4(0), DecodedReadEnable(25));
	inverter_14 : inverter port map(DecodedReadEnable(25), DecodedReadEnableBar(25));
	
	and3_45 : and3 port map(TempReadEnable, DecoderOutput3_8(4), DecoderOutput2_4(3), DecodedReadEnable(23));
	inverter_15 : inverter port map(DecodedReadEnable(23), DecodedReadEnableBar(23));	
	and3_46 : and3 port map(TempReadEnable, DecoderOutput3_8(4), DecoderOutput2_4(2), DecodedReadEnable(22));
	inverter_16 : inverter port map(DecodedReadEnable(22), DecodedReadEnableBar(22));	
	and3_47 : and3 port map(TempReadEnable, DecoderOutput3_8(4), DecoderOutput2_4(1), DecodedReadEnable(21));
	inverter_17 : inverter port map(DecodedReadEnable(21), DecodedReadEnableBar(21));	
	and3_48 : and3 port map(TempReadEnable, DecoderOutput3_8(4), DecoderOutput2_4(0), DecodedReadEnable(20));
	inverter_18 : inverter port map(DecodedReadEnable(20), DecodedReadEnableBar(20));
	
	and3_49 : and3 port map(TempReadEnable, DecoderOutput3_8(3), DecoderOutput2_4(3), DecodedReadEnable(18));
	inverter_19 : inverter port map(DecodedReadEnable(18), DecodedReadEnableBar(18));	
	and3_50 : and3 port map(TempReadEnable, DecoderOutput3_8(3), DecoderOutput2_4(2), DecodedReadEnable(17));
	inverter_20 : inverter port map(DecodedReadEnable(17), DecodedReadEnableBar(17));	
	and3_51 : and3 port map(TempReadEnable, DecoderOutput3_8(3), DecoderOutput2_4(1), DecodedReadEnable(16));
	inverter_21 : inverter port map(DecodedReadEnable(16), DecodedReadEnableBar(16));	
	and3_52 : and3 port map(TempReadEnable, DecoderOutput3_8(3), DecoderOutput2_4(0), DecodedReadEnable(15));
	inverter_22 : inverter port map(DecodedReadEnable(15), DecodedReadEnableBar(15));
	
	and3_53 : and3 port map(TempReadEnable, DecoderOutput3_8(2), DecoderOutput2_4(3), DecodedReadEnable(13));
	inverter_23 : inverter port map(DecodedReadEnable(13), DecodedReadEnableBar(13));
	and3_54 : and3 port map(TempReadEnable, DecoderOutput3_8(2), DecoderOutput2_4(2), DecodedReadEnable(12));
	inverter_24 : inverter port map(DecodedReadEnable(12), DecodedReadEnableBar(12));
	and3_55 : and3 port map(TempReadEnable, DecoderOutput3_8(2), DecoderOutput2_4(1), DecodedReadEnable(11));
	inverter_25 : inverter port map(DecodedReadEnable(11), DecodedReadEnableBar(11));
	and3_56 : and3 port map(TempReadEnable, DecoderOutput3_8(2), DecoderOutput2_4(0), DecodedReadEnable(10));
	inverter_26 : inverter port map(DecodedReadEnable(10), DecodedReadEnableBar(10));
	
	and3_57 : and3 port map(TempReadEnable, DecoderOutput3_8(1), DecoderOutput2_4(3), DecodedReadEnable(8));
	inverter_27 : inverter port map(DecodedReadEnable(8), DecodedReadEnableBar(8));	
	and3_58 : and3 port map(TempReadEnable, DecoderOutput3_8(1), DecoderOutput2_4(2), DecodedReadEnable(7));
	inverter_28 : inverter port map(DecodedReadEnable(7), DecodedReadEnableBar(7));	
	and3_59 : and3 port map(TempReadEnable, DecoderOutput3_8(1), DecoderOutput2_4(1), DecodedReadEnable(6));
	inverter_29 : inverter port map(DecodedReadEnable(6), DecodedReadEnableBar(6));	
	and3_60 : and3 port map(TempReadEnable, DecoderOutput3_8(1), DecoderOutput2_4(0), DecodedReadEnable(5));
	inverter_30 : inverter port map(DecodedReadEnable(5), DecodedReadEnableBar(5));
	
	and3_61 : and3 port map(TempReadEnable, DecoderOutput3_8(0), DecoderOutput2_4(3), DecodedReadEnable(3));
	inverter_31 : inverter port map(DecodedReadEnable(3), DecodedReadEnableBar(3));	
	and3_62 : and3 port map(TempReadEnable, DecoderOutput3_8(0), DecoderOutput2_4(2), DecodedReadEnable(2));
	inverter_32 : inverter port map(DecodedReadEnable(2), DecodedReadEnableBar(2));	
	and3_63 : and3 port map(TempReadEnable, DecoderOutput3_8(0), DecoderOutput2_4(1), DecodedReadEnable(1));
	inverter_33 : inverter port map(DecodedReadEnable(1), DecodedReadEnableBar(1));	
	and3_64 : and3 port map(TempReadEnable, DecoderOutput3_8(0), DecoderOutput2_4(0), DecodedReadEnable(0));
	inverter_34 : inverter port map(DecodedReadEnable(0), DecodedReadEnableBar(0));
	
	Data_Write_1 : Data_Write port map(ReadMiss, WriteHit, MemData(7 downto 0), CPU_Data(7 downto 0), Cycle9High, Cycle10High, Cycle11High, Cycle12High, Cycle13High, Cycle14High, Cycle15High, Cycle16High, input_register(7 downto 0));
	
	BufferTwoStage_9 : BufferTwoStage port map(CPU_Address(7), NewCPUAddress(7));
	BufferTwoStage_10 : BufferTwoStage port map(CPU_Address(6), NewCPUAddress(6));
	BufferTwoStage_11 : BufferTwoStage port map(CPU_Address(5), NewCPUAddress(5));
	BufferTwoStage_12 : BufferTwoStage port map(CPU_Address(4), NewCPUAddress(4));
	BufferTwoStage_13 : BufferTwoStage port map(CPU_Address(3), NewCPUAddress(3));
	BufferTwoStage_14 : BufferTwoStage port map(CPU_Address(2), NewCPUAddress(2));
	
	AddressSelector_1 : AddressSelector  port map(CPU_Address(1 downto 0), ReadMiss, Cycle9High, Cycle10High, Cycle11High, Cycle12High, Cycle13High, Cycle14High, Cycle15High, Cycle16High, NewCPUAddress(1 downto 0));
	
	FullMemory_1 : FullMemory port map(ValidWriteData, NewCPUAddress(7 downto 5), input_register(7 downto 0), WriteEnableMemoryStructure(39 downto 0), DecodedReadEnable(39 downto 0), DecodedReadEnableBar(39 downto 0), ValidReadBit, TagRead(2 downto 0), output_register(7 downto 0));
	
	ValidBit_TagComp_1 : ValidBit_TagComp port map(Stored_St, CPU_Address(7 downto 5), ValidReadBit, TagRead(2 downto 0), TempValid, TempValidTagCompOutput);							-- Getting output from the ValidBit_TagComp in TempValidTagCompOutput 
		
	Dlatch_2 : DLatch port map(TempValidTagCompOutput, OriginalStart, ValidTagComp, ValidTagCompBar);
	
	and2_3 : and2 port map(ReadWrite, ValidTagComp, TempReadHit);												-- ReadHit - ReadWrite AND TempValidTagCompOutput; OUtput tells whether its ReadHit or not
	and2_4 : and2 port map(ReadWrite, ValidTagCompBar, TempReadMiss);											-- ReadMiss - ReadWrite AND TempValidTagCompOutput; Output tell us whether its ReadMiss or not
	and2_5 : and2 port map(ValidTagComp, ReadWriteBar, TempWriteHit);											-- WriteHit - ReadWrite AND TempValidTagCompOutput; Output tells us whether its WriteHit or not
	and2_6 : and2 port map(ReadWriteBar, ValidTagCompBar, TempWriteMiss);										-- WriteMiss - ReadWrite AND TempValidTagCompOutput; Output tells us whether its WriteMiss or not
	
	Dlatch_3 : DLatch port map(TempReadHit, Stored_St, ReadHit, ReadHitBar);
	Dlatch_4 : DLatch port map(TempReadMiss, Stored_St, ReadMiss, ReadMissBar);
	Dlatch_5 : DLatch port map(TempWriteHit, Stored_St, WriteHit, WriteHitBar);
	Dlatch_6 : DLatch port map(TempWriteMiss, Stored_St, WriteMiss, WriteMissBar);
	
	Counter_1 : Counter port map(CPU_Address(7 downto 2), OriginalStart, ReadHit, ReadMiss, WriteHit, WriteMiss, ClkMemoryStructure, Busy, MemoryEnable, MemoryAddress(7 downto 0), Cycle9High, Cycle11High, Cycle13High, Cycle15High, TempReadEnable, WriteEn, Cycle10High, Cycle12High, Cycle14High, Cycle16High);	-- Getting Busy as output from Counter

	
end structural;




	
