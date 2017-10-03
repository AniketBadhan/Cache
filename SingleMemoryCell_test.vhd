-------------------------------------------------------
--Entity : alu_4_test
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity SingleMemoryCell_test is

end SingleMemoryCell_test;

architecture test of SingleMemoryCell_test is

component SingleMemoryCell
	port(
		WriteData : in std_logic;
		WriteEnable : in std_logic;
		ReadEnable : in std_logic;
		ReadEnableBar : in std_logic;
		ReadData : out std_logic);
end component;

for SingleMemoryCell_1 : SingleMemoryCell use entity work.SingleMemoryCell(structural);
   signal ip1, ip2, ip3, ip4, op : std_logic;
   signal clock : std_logic;

begin

SingleMemoryCell_1 : SingleMemoryCell port map (ip1, ip2, ip3, ip4, op);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "SMC_in.txt";
  file outfile : text is out "SMC_out.txt";
  variable i1, i2, i3, i4, op1 : std_logic;
  variable buf : line;

begin

  while not (endfile(infile)) loop   -- taking inputs from alu_4_in.txt in the sequence A,B,Cin,S0,S1, each input stored in different line of input file


    readline(infile,buf);
    read (buf,i1);
    ip1<=i1;

    readline(infile,buf);
    read (buf,i2);
    ip2<=i2;

    readline(infile,buf);
    read (buf,i3);
    ip3<=i3;
	
	readline(infile,buf);
    read (buf, i4);
    ip4<=i4;

    wait until falling_edge(clock);

    op1:=op;

    write(buf,op1);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt

  end loop;

end process io_process;

end test;
