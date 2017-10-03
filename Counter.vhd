-------------------------------------------------------
--Entity : Counter
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity Counter is
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
end Counter;

architecture structural of Counter is 

component tilo
	port(
		output : out std_logic);
end component;

component nor2
	port(
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

component and2 
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component inverter 
	port(
		input : in std_logic;
		output : out std_logic);
end component;

component or2
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

component DFlipFlop
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;

component and3
	port (
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

component BufferTwoStage
	port(
		input : in std_logic;
		output : out std_logic);
end component;

component Latch_8Bit
	port ( 
		Latch_Input   : in  std_logic_vector(7 downto 0);
        ClkRegister : in  std_logic;
        Latch_Output   : out std_logic_vector(7 downto 0);
        Latch_OutputBar: out std_logic_vector(7 downto 0)); 
end component;

component xnor2 
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end component;

component Dlatch
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;         

component tx_8                      
  port ( 
		sel8   : in std_logic;
        selnot8: in std_logic;
        input8 : in std_logic_vector(7 downto 0);  
        output8 :out std_logic_vector(7 downto 0));
end component; 

component or3
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		input3 : in std_logic;
		output : out std_logic);
end component;

for inverter_1, inverter_2, inverter_3, inverter_4 : inverter use entity work.inverter(structural);
for and2_1, and2_2, and2_3, and2_4, and2_5, and2_6, and2_7, and2_8, and2_9, and2_10, and2_11, and2_12, and2_13, and2_14, and2_15, and2_16, and2_17, and2_18, and2_19, and2_20 : and2 use entity work.and2(structural);
for and2_21, and2_22, and2_23, and2_24, and2_25, and2_26, and2_27, and2_28, and2_29, and2_30 : and2 use entity work.and2(structural);
for and2_31, and2_32, and2_33, and2_34, and2_35, and2_36, and2_37, and2_38, and2_39 : and2 use entity work.and2(structural);
for or2_1, or2_2, or2_3, or2_4, or2_5, or2_6, or2_7, or2_8, or2_9, or2_10, or2_11 : or2 use entity work.or2(structural);
for xor2_1, xor2_2 : xor2 use entity work.xor2(structural);
for DFlipFlop_1, DFlipFlop_2, DFlipFlop_3, DFlipFlop_4, DFlipFlop_5, DFLipFlop_6 : DFlipFlop use entity work.DFlipFlop(structural);
for and3_1, and3_2, and3_3, and3_4, and3_5, and3_6, and3_7, and3_8, and3_9, and3_10, and3_11 : and3 use entity work.and3(structural);
for or3_1 : or3 use entity work.or3(structural);
for BufferTwoStage_1, BufferTwoStage_2, BufferTwoStage_3, BufferTwoStage_4, BufferTwoStage_5, BufferTwoStage_6, BufferTwoStage_7, BufferTwoStage_8, BufferTwoStage_9 : BufferTwoStage use entity work.BufferTwoStage(structural);
for tx_8_1 : tx_8 use entity work.tx_8(structural);
for tilo_1, tilo_2 : tilo use entity work.tilo(structural);
for Dlatch_1 : Dlatch use entity work.Dlatch(structural);

signal Mem_Add : std_logic_vector(1 downto 0);
signal D : std_logic_vector(4 downto 0);
signal Q : std_logic_vector(4 downto 0);
signal Qbar : std_logic_vector(4 downto 0);
signal Temp : std_logic_vector(43 downto 0);
signal ReadHitLogic, ReadMissLogic, WriteHitLogic, WriteMissLogic, TempBusyCounter, BusyCounterBar, CycleHigh_8Bar, Cycle10Bar, Cycle12Bar, Cycle14Bar : std_logic;
signal D_Intermediate : std_logic_vector(4 downto 0);
signal ResetBar : std_logic;
signal Rd_WrBar : std_logic;
signal ReadMiss_Busy, ReadHit_Busy, WriteHitMiss_Busy, CounterStart, CounterStartBar, clkfinal : std_logic;
signal Address, AddressBar : std_logic_vector(7 downto 0);
signal StartAt0, StartAt0Bar, ReadMiss_BusyBar, ReadHit_BusyBar, TempReadEnable, Orig_StartBar : std_logic;
signal DBar	: std_logic_vector(4 downto 0);
signal TempAdd : std_logic_vector(7 downto 0);

begin
	
	DFLipFlop_6 : DFLipFlop port map(Orig_Start, clk, CounterStart, CounterStartBar);

	Dlatch_1 : Dlatch port map(CounterStart, Orig_Start, StartAt0, StartAt0Bar);

	BufferTwoStage_1 : BufferTwoStage port map(Qbar(0), D_Intermediate(0)); 	-- Input D_Intermediate(0) assigned Qbar(0)
	xor2_1 : xor2 port map (Q(0), Q(1), D_Intermediate(1));						-- Input D_Intermediate(1) <= Q(0) xor Q(1)
	xor2_2 : xor2 port map (Q(0), Q(2), Temp(0));								-- Temp(0) <= Q(0) xor Q(2)
	and2_1 : and2 port map (Q(1), Temp(0), Temp(1));							-- Temp(1) <= Q(1) and Temp(0)
	and2_2 : and2 port map (Qbar(1), Q(2), Temp(2));							-- Temp(2) <= Qbar(1) and Q(2)
	or2_1 : or2 port map(Temp(1), Temp(2), D_Intermediate(2));					-- Input D_Intermediate(2) <= Temp(1) or Temp(2)
	and2_3 : and2 port map(Qbar(0), Q(1), Temp(3));								-- Temp(3) <= Qbar(0)) and Q(1)
	or2_2 : or2 port map(Qbar(1), Temp(3), Temp(4));							-- Temp(4) <= Qbar(1) or Temp(3)
	or2_3 : or2 port map(Temp(4), Qbar(2), Temp(5));							-- Temp(5) <= Temp(4) or Qbar(2)
	and2_4 : and2 port map(Q(3), Temp(5), Temp(6));								-- Temp(6) <= Q(3) and Temp(5)
	and2_5 : and2 port map(Q(0), Q(1), Temp(7));								-- Temp(7) <= Q(0) and Q(1)
	and2_6 : and2 port map(Q(2), Qbar(3), Temp(8));								-- Temp(8) <= Q(2) and Qbar(3)
	and2_7 : and2 port map(Temp(7), Temp(8), Temp(9));							-- Temp(9) <= Temp(7) and Temp(8)
	or2_4 : or2 port map(Temp(6), Temp(9), D_Intermediate(3));					-- Input D_Intermediate(3) <= Temp(8) or Temp(9)
	or2_5 : or2 port map(Qbar(3), Temp(5), Temp(10));							-- Temp(10) <= Qbar(3) or Temp(5)
	and2_8 : and2 port map(Q(4), Temp(10), Temp(11));						 	-- Temp(11) <= Q(4) and Temp(10)
	and2_9 : and2 port map(Q(2), Q(3), Temp(12));								-- Temp(12) <= Q(2)and Q(3)
	and2_10 : and2 port map(Temp(7), Temp(12), Temp(13));						-- Temp(13) <= Temp(7) and Temp(12)
	and2_11 : and2 port map(Qbar(4), Temp(13), Temp(14));						-- Temp(14) <= Qbar(4) and Temp(13)
	or2_6 : or2 port map(Temp(11), Temp(14), D_Intermediate(4));				-- Input D_Intermediate(4) <= Temp(11) or Temp(14)
	
	and2_12 : and2 port map(StartAt0, ReadHit, Temp(15));						-- Temp(15) <= Start_Reset and ReadHit
	and2_13 : and2 port map(StartAt0, ReadMiss, Temp(16));						-- Temp(16) <= Start_Reset and ReadMiss
	and2_14 : and2 port map(StartAt0, WriteHit, Temp(17));						-- Temp(17) <= Start_Reset and WriteHit
	and2_15 : and2 port map(StartAt0, WriteMiss, Temp(18));						-- Temp(18) <= Start_Reset and WriteMiss
	
	and2_16 : and2 port map(Q(0), Qbar(1), Temp(19)); 							-- Temp(19) <= Q(0) and Q(1)
	and2_17 : and2 port map(Qbar(2), Qbar(3), Temp(20));						-- Temp(20) <= Qbar(2) and Qbar(3)
	and2_18 : and2 port map(Temp(19), Temp(20), Temp(21));						-- Temp(21) <= Temp(19) and Temp(20)
	and2_19 : and2 port map(Qbar(4), Temp(21), Temp(22));						-- Temp(22) <= Qbar(4) and Temp(21)[For Read Hit]
	inverter_1 : inverter port map(Temp(22), Temp(23));							-- Temp(23) <= Inverting Temp(22) [combination of 5 outputs will be 1 until reset point occurs, so inverting when reset point occurs]
	and2_20 : and2 port map(Temp(15), Temp(23), ReadHitLogic);					-- ReadHitLogic <= Temp(15) and Temp(23) [Final Read Hit Logic]
	
	and2_21 : and2 port map(Temp(3), Temp(20), Temp(24));						-- Temp(24) <= Temp(24) and Temp(25)
	and2_22 : and2 port map(Q(4), Temp(24), Temp(25));							-- Temp(25) <= Q(4) and Temp(24)
	inverter_2 : inverter port map(Temp(25), Temp(26));							-- Temp(26) <= Inverting Temp(25) [combination of 5 outputs will be 1 until reset point occurs, so inverting when reset point occurs]
	and2_23 : and2 port map(Temp(16), Temp(26), ReadMissLogic);					-- ReadMissLogic <= Temp(16) and Temp(24) [Final Read Miss Logic]
	
	and2_24 : and2 port map(Qbar(4), Temp(24), Temp(27));						-- Temp(25) <= Qbar(4) and Temp(25)
	inverter_3 : inverter port map(Temp(27), Temp(28));							-- Temp(28) <= Inverting Temp(27) [combination of 5 outputs will be 1 until reset point occurs, so inverting when reset point occurs]
	and2_25 : and2 port map(Temp(17), Temp(28), WriteHitLogic);					-- WriteHitLogic <= Temp(17) and Temp(28) [Final Write Hit Logic]
	
	and2_26 : and2 port map(Temp(18), Temp(28), WriteMissLogic);				-- WriteMissLogic <= Temp(18) and Temp(28) [Final Write Miss Logic]
	
	or2_7 : or2 port map(ReadHitLogic, ReadMissLogic, Temp(29));				-- Temp(29) <= ReadHitLogic or ReadMissLogic
	or2_8 : or2 port map(WriteHitLogic, WriteMissLogic, Temp(30));				-- Temp(30) <= WriteHitLogic or WriteMissLogic
	or2_9 : or2 port map(Temp(29), Temp(30), Temp(31));							-- Temp(31) <= Temp(26) or Temp(27), Read Hit and Miss and Write Hit and Miss are Or'd together and given as input to each input of DFLipFlop 
	
	and2_27 : and2 port map(D_Intermediate(0), Temp(31), D(0));					-- Input D(0) <= D_Intermediate(0) and Temp(31) [AND start, reset logic]
	and2_28 : and2 port map(D_Intermediate(1), Temp(31), D(1));					-- Input D(1) <= D_Intermediate(1) and Temp(31) [AND start, reset logic]
	and2_29 : and2 port map(D_Intermediate(2), Temp(31), D(2));					-- Input D(2) <= D_Intermediate(2) and Temp(31) [AND start, reset logic]
	and2_30 : and2 port map(D_Intermediate(3), Temp(31), D(3));					-- Input D(3) <= D_Intermediate(3) and Temp(31) [AND start, reset logic]
	and2_31 : and2 port map(D_Intermediate(4), Temp(31), D(4));					-- Input D(4) <= D_Intermediate(4) and Temp(31) [AND start, reset logic]
	
	DFlipFlop_1 : DFlipFlop port map(D(0), clk, Q(0), Qbar(0));					-- LSB D FlipFLop
	DFlipFlop_2 : DFlipFlop port map(D(1), clk, Q(1), Qbar(1));
	DFlipFlop_3 : DFlipFlop port map(D(2), clk, Q(2), Qbar(2));
	DFlipFlop_4 : DFlipFlop port map(D(3), clk, Q(3), Qbar(3));
	DFlipFlop_5 : DFlipFlop port map(D(4), clk, Q(4), Qbar(4));					-- MSB D FlipFlop
	
	and2_32 : and2 port map(Temp(23), ReadHitLogic, ReadHit_Busy);	
	and2_33 : and2 port map(Temp(26), ReadMissLogic, ReadMiss_Busy);			-- ReadMiss_Busy <= ReadMissLogic and Temp(35) [For Lowering Busy at 18th Cycle for ReadMiss]
	
	or2_10 : or2 port map(WriteHitLogic, WriteMissLogic, Temp(32)); 			-- Temp(42) <= WriteHitLogic or WriteMissLogic
	and2_34 : and2 port map(Temp(32), Temp(28), WriteHitMiss_Busy);				-- WriteHitMiss_Busy <= Temp(42), Temp(41) [For lowering busy at 2nd cycle for WriteHit andd WriteMiss]
	
	or3_1 : or3 port map(ReadMiss_Busy, ReadHit_Busy, WriteHitMiss_Busy, BusyCounter);	-- Busy is OR of ReadHit_Busy, ReadMiss_Busy, WriteHitMiss_Busy (For any of the 4 actions, Remaining actions will be 0 and only corresponding action Bit will be high until the cycle before reset is reached and then just one cycle before the reset cycle, all the 3 inputs to busy signal will be 0, converting Busy to Low)
	
	and2_35 : and2 port map(Temp(16), Temp(22), Temp(33));
	BufferTwoStage_2 : BufferTwoStage port map(Temp(33), Enable);
	
	tilo_1 : tilo port map(TempAdd(1));
	tilo_2 : tilo port map(TempAdd(0));
	
	and3_1 : and3 port map(Q(0), Qbar(1), Qbar(2), Temp(35));
	and3_2 : and3 port map(Temp(35), Q(3), Qbar(4), Cycle9);					-- Temp(62) is 1 only in 9th cycle, 8th cycle after Mem En is high
	
	and2_36 : and2 port map(Q(3), Qbar(2), Temp(38));
	and3_3 : and3 port map(Qbar(4), Temp(38), Temp(7), Cycle11);				-- Cycle11 is 1 in 11th cycle,10th cycle after Mem En is high
	
	and3_4 : and3 port map(Qbar(4), Temp(19), Temp(12), Cycle13);				-- Cycle13 is 1 in 13th cycle, 12th cycle after Mem en is high
	
	BufferTwoStage_3 : BufferTwoStage port map(Temp(14), Cycle15);				-- Cycle15) is 1 in 15th cycle, 14th cycle after Mem en is high
	
	-- for Memory Address
	BufferTwoStage_4 : BufferTwoStage port map(CPU_Address(7), TempAdd(7));
	BufferTwoStage_5 : BufferTwoStage port map(CPU_Address(6), TempAdd(6));
	BufferTwoStage_6 : BufferTwoStage port map(CPU_Address(5), TempAdd(5));
	BufferTwoStage_7 : BufferTwoStage port map(CPU_Address(4), TempAdd(4));
	BufferTwoStage_8 : BufferTwoStage port map(CPU_Address(3), TempAdd(3));
	BufferTwoStage_9 : BufferTwoStage port map(CPU_Address(2), TempAdd(2));
	inverter_4 : inverter  port map(Temp(33), Temp(34));
	
	tx_8_1 : tx_8 port map(Temp(33), Temp(34), TempAdd(7 downto 0), Mem_Address(7 downto 0));
	
	and2_37 : and2 port map(ReadHit, Temp(22), Temp(39));
	and2_38 : and2 port map(ReadMiss, Temp(25), Temp(40));
	
	or2_11 : or2 port map(Temp(39), Temp(40), ReadEnable);
			
	and2_39 : and2 port map(WriteHit, Temp(27), WriteEnable);

	and3_5 : and3 port map(Qbar(4), Temp(38), Temp(3), Cycle10);
	
	and3_6 : and3 port map(Qbar(0), Qbar(1), Q(2), Temp(41));
	and3_7 : and3 port map(Q(3), Qbar(4), Temp(41), Cycle12);
	
	and3_8 : and3 port map(Qbar(0), Q(1), Q(2), Temp(42));
	and3_9 : and3 port map(Q(3), Qbar(4), Temp(42), Cycle14);
	
	and3_10 : and3 port map(Qbar(0), Qbar(1), Qbar(2), Temp(43));
	and3_11 : and3 port map(Qbar(3), Q(4), Temp(43), Cycle16);
	
end structural;
	


