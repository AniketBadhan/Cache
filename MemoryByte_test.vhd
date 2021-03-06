-------------------------------------------------------
--Entity : MemoryByte
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity MemoryByte_test is

end MemoryByte_test;

architecture test of MemoryByte_test is

component MemoryByte
	port(
		WriteDataByte : in std_logic_vector(7 downto 0);
		WriteDataEnable : in std_logic;
		ReadEnableByte : in std_logic;
		ReadEnableByteBar : in std_logic;
		ReadDataByte : out std_logic_vector(7 downto 0));
end component;

for MemoryByte_1 : MemoryByte use entity work.MemoryByte(structural);
   signal ip1, op : std_logic_vector(7 downto 0);
   signal ip2, ip3, ip4 : std_logic;
   signal clock : std_logic;

begin

MemoryByte_1 : MemoryByte port map (ip1, ip2, ip3, ip4, op);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "SMC_in.txt";
  file outfile : text is out "SMC_out.txt";
  variable i1, op1 : std_logic_vector(7 downto 0);
  variable  i2, i3, i4 : std_logic;
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
