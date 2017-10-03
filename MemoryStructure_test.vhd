-------------------------------------------------------
--Entity : MemoryStructure_test
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity MemoryStructure_test is

end MemoryStructure_test;

architecture test of MemoryStructure_test is

component MemoryStructure
	port(
		Reset : in std_logic;
		StartReset : in std_logic;
		CPU_Address : in std_logic_vector(7 downto 0);
		CPU_Data : inout std_logic_vector(7 downto 0);
		ClkMemoryStructure : in std_logic;
		ReadWrite : in std_logic;
		MemoryEnable : out std_logic;
		Busy : out std_logic);
end component;

for MemoryStructure_1 : MemoryStructure use entity work.MemoryStructure(structural);
   
   signal ip1 : std_logic;
   signal ip2 : std_logic;
   signal ip3 : std_logic_vector(7 downto 0);
   signal ip4 : std_logic_vector(7 downto 0);
   signal ip5 : std_logic;
   signal ip6 : std_logic;
   signal op1 : std_logic;
   signal op2 : std_logic;
   signal clock : std_logic;

begin

Counter_1 : MemoryStructure port map (ip1, ip2, ip3, ip4, clock, ip5, op1, op2);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "MS_in.txt";
  file outfile : text is out "MS_out.txt";
  variable i1 : std_logic;
  variable i2 : std_logic;
  variable i3 : std_logic;
  variable i4 : std_logic;
  variable i5 : std_logic;
  variable i6 : std_logic;
  variable o1 : std_logic;
  variable o2 : std_logic;
  variable buf : line;

begin

  while not (endfile(infile)) loop   

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
	
    readline(infile,buf);
    read (buf, i5);
    ip5<=i5;
	
    wait until falling_edge(clock);

    o1 := op1;
    o2 := op2;

    write(buf,o1);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt
    write(buf,o2);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt

  end loop;

end process io_process;

end test;
