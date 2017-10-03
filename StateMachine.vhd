-------------------------------------------------------
--Entity : StateMachine
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity StateMachine is
	port(
		Start_Reset : in std_logic;
		ReadHit : in std_logic;
		ReadMiss : in std_logic;
		WriteHit : in std_logic;
		WriteMiss : in std_logic;
		clk : in  std_logic;
        Vdd : in  std_logic;
        Gnd : in  std_logic);
end StateMachine;

architecture structural of StateMachine

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

component DFLipFlop
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end component;

inverter_1, inverter_2, inverter_3, inverter_4, inverter_5, inverter_6, inverter_7, inverter_8 : inverter use entity work.inverter(structural);
and2_1, and2_2, and2_3, and2_4, and2_5, and2_6, and2_7, and2_8, and2_9, and2_10, and2_11, and2_12, and2_13, and2_14, and2_15, and2_16, and2_17, and2_18, and2_19, and2_20 : and2 use entity work.and2(structural);
and2_21, and2_22, and2_23, and2_24, and2_25, and2_26, and2_27, and2_28, and2_29, and2_30 : and2 use entity work.and2(structural);
and2_31, and2_32, and2_33, and2_34, and2_35, and2_36 : and2 use entity work.and2(structural);
or2_1, or2_2, or2_3, or2_4, or2_5, or2_6, or2_7, or2_8, or2_9, or2_10 : or2 use entity work.or2(structural);
xor2_1, xor2_2 : xor2 use entity work.xor2(structural);
DFLipFlop_1, DFLipFlop_2, DFLipFlop_3, DFLipFlop_4, DFLipFlop_5 : DFLipFlop use entity work.DFLipFlop(structural);


signal D : std_logic_vector(4 downto 0);
signal Q : std_logic_vector(4 downto 0);
signal Qbar : std_logic_vector(4 downto 0);
signal Temp : std_logic_vector(30 downto 0);
signal ReadHitLogic, ReadMissLogic, WriteHitLogic, WriteMissLogic : std_logic;
signal D_Intermediate : std_logic_vector(4 downto 0);
signal ResetBar : std_logic;
signal Rd_WrBar : std_logic;

begin

	D_Intermediate(0) <= Qbar(0);												-- Input D_Intermediate(0) assigned Qbar(0)
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
	
	and2_12 : and2 port map(Start_Reset, ReadHit, Temp(15));					-- Temp(15) <= Start_Reset and ReadHit
	and2_13 : and2 port map(Start_Reset, ReadMiss, Temp(16));					-- Temp(16) <= Start_Reset and ReadMiss
	and2_14 : and2 port map(Start_Reset, WriteHit, Temp(17));					-- Temp(17) <= Start_Reset and WriteHit
	and2_15 : and2 port map(Start_Reset, WriteMiss, Temp(18));					-- Temp(18) <= Start_Reset and WriteMiss
	
	and2_16 : and2 port map(Q(0), Q(1), Temp(19)); 								-- Temp(19) <= Q(0) and Q(1)
	and2_17 : and2 port map(Qbar(2), Qbar(3), Temp(20));						-- Temp(20) <= Qbar(2) and Qbar(3)
	and2_18 : and2 port map(Temp(19), Temp(20), Temp(21));						-- Temp(21) <= Temp(19) and Temp(20)
	and2_19 : and2 port map(Qbar(4), Temp(21), Temp(22));						-- Temp(22) <= Qbar(4) and Temp(21)[For Read Hit]
	inverter_1 : inverter port map(Temp(22), Temp(23));							-- Temp(23) <= Inverting Temp(22) [combination of 5 outputs will be 1 until reset point occurs, so inverting when reset point occurs]
	and2_20 : and2 port map(Temp(15), Temp(23), ReadHitLogic);					-- ReadHitLogic <= Temp(15) and Temp(23) [Final Read Hit Logic]
	
	and2_21 : and2 port map(Qbar(0), Qbar(1), Temp(24));						-- Temp(24) <= Qbar(0) and Qbar(1)
	and2_22 : and2 port map(Q(2), Qbar(3), Temp(25));							-- Temp(25) <= Q(2) and Qbar(3)
	and2_23 : and2 port map(Temp(24), Temp(25), Temp(26));						-- Temp(26) <= Temp(24) and Temp(25)
	and2_24 : and2 port map(Q(4), Temp(26), Temp(27));							-- Temp(27) <= Q(4) and Temp(26)
	inverter_2 : inverter port map(Temp(27), Temp(28));							-- Temp(28) <= Inverting Temp(27) [combination of 5 outputs will be 1 until reset point occurs, so inverting when reset point occurs]
	and2_25 : and2 port map(Temp(16), Temp(28), ReadMissLogic);					-- ReadMissLogic <= Temp(16) and Temp(26) [Final Read Miss Logic]
	
	and2_26 : and2 port map(Qbar(4), Temp(26), Temp(29));						-- Temp(27) <= Qbar(4) and Temp(25)
	inverter_3 : inverter port map(Temp(29), Temp(30));							-- Temp(30) <= Inverting Temp(29) [combination of 5 outputs will be 1 until reset point occurs, so inverting when reset point occurs]
	and2_27 : and2 port map(Temp(17), Temp(30), WriteHitLogic);					-- WriteHitLogic <= Temp(17) and Temp(30) [Final Write Hit Logic]
	
	and2_28 : and2 port map(Temp(18), Temp(30), WriteMissLogic);				-- WriteMissLogic <= Temp(18) and Temp(30) [Final Write Miss Logic]
	
	or2_7 : or2 port map(ReadHitLogic, ReadMissLogic, Temp(31));				-- Temp(28) <= ReadHitLogic or ReadMissLogic
	or2_8 : or2 port map(WriteHitLogic, WriteMissLogic, Temp(32));				-- Temp(29) <= WriteHitLogic or WriteMissLogic
	or2_9 : or2 port map(Temp(31), Temp(32), Temp(33));							-- Temp(30) <= Temp(28) or Temp(29)
	
	and2_29 : and2 port map(D_Intermediate(0), Temp(33), D(0));					-- Input D(0) <= D_Intermediate(0) and Temp(33) [AND set, reset logic]
	and2_30 : and2 port map(D_Intermediate(1), Temp(33), D(1));					-- Input D(1) <= D_Intermediate(1) and Temp(33) [AND set, reset logic]
	and2_31 : and2 port map(D_Intermediate(2), Temp(33), D(2));					-- Input D(2) <= D_Intermediate(2) and Temp(33) [AND set, reset logic]
	and2_32 : and2 port map(D_Intermediate(3), Temp(33), D(3));					-- Input D(3) <= D_Intermediate(3) and Temp(33) [AND set, reset logic]
	and2_33 : and2 port map(D_Intermediate(4), Temp(33), D(4));					-- Input D(4) <= D_Intermediate(4) and Temp(33) [AND set, reset logic]
	
	DFLipFlop_1 : DFLipFlop port map(D(0), clk, Q(0), Qbar(0));					-- LSB D FlipFLop
	DFLipFlop_2 : DFLipFlop port map(D(1), clk, Q(1), Qbar(1));
	DFLipFlop_3 : DFLipFlop port map(D(2), clk, Q(2), Qbar(2));
	DFLipFlop_4 : DFLipFlop port map(D(3), clk, Q(3), Qbar(3));
	DFLipFlop_5 : DFLipFlop port map(D(4), clk, Q(4), Qbar(4));					-- MSB D FlipFlop
	
end structural;
	


