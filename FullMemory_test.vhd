-------------------------------------------------------
--Entity : FullMemory_test
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity FullMemory_test is

end FullMemory_test;

architecture test of FullMemory_test is

component FullMemory
	port(
		ValidData_FullMemory : in std_logic_vector(7 downto 0);
		TagData_FullMemory : in std_logic_vector(23 downto 0);
		WriteDataBlock_FullMemory : in std_logic_vector(7 downto 0);
		WriteEnableRow_FullMemory : in std_logic_vector(39 downto 0);
		ReadEnableRow_FullMemory : in std_logic_vector(39 downto 0);
		ReadEnableRowBar_FullMemory : in std_logic_vector(39 downto 0);
		ValidReadData_FullMemory : out std_logic;
		TagReadData_FullMemory : out std_logic_vector(2 downto 0);
		ReadDataBlock_FullMemory : out std_logic_vector(7 downto 0));
end component;

for FullMemory_1 : FullMemory use entity work.FullMemory(structural);
   
   signal ip1 : std_logic_vector(7 downto 0);
   signal ip2 : std_logic_vector(23 downto 0);
   signal ip3 : std_logic_vector(7 downto 0);
   signal ip4 : std_logic_vector(39 downto 0);
   signal ip5 : std_logic_vector(39 downto 0);
   signal ip6 : std_logic_vector(39 downto 0);
   signal op1 : std_logic;
   signal op2 : std_logic_vector(2 downto 0);
   signal op3 : std_logic_vector(7 downto 0);
   signal clock : std_logic;

begin

FullMemory_1 : FullMemory port map (ip1, ip2, ip3, ip4, ip5, ip6, op1, op2, op3);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "FM_in.txt";
  file outfile : text is out "FM_out.txt";
  variable i1 : std_logic_vector(7 downto 0);
  variable i2 : std_logic_vector(23 downto 0);
  variable i3 : std_logic_vector(7 downto 0);
  variable i4 : std_logic_vector(39 downto 0);
  variable i5 : std_logic_vector(39 downto 0);
  variable i6 : std_logic_vector(39 downto 0);
  variable o1 : std_logic;
  variable o2 : std_logic_vector(2 downto 0);
  variable o3 : std_logic_vector(7 downto 0);
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
	
	readline(infile,buf);
    read (buf, i6);
    ip6<=i6;

    wait until falling_edge(clock);

    o1 := op1;
	o2 := op2;
	o3 := op3;

    write(buf,o1);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt
	write(buf,o2);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt
	write(buf,o3);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt

  end loop;

end process io_process;

end test;
