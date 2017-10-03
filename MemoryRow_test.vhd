-------------------------------------------------------
--Entity : MemoryRow
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity MemoryRow_test is

end MemoryRow_test;

architecture test of MemoryRow_test is

component MemoryRow
	port(
		ValidData : in std_logic;
		TagData : in std_logic_vector(2 downto 0);
		WriteDataBlock : in std_logic_vector(7 downto 0);
		WriteEnableRow : in std_logic_vector(4 downto 0);
		ReadEnableRow : in std_logic_vector(4 downto 0);
		ReadEnableRowBar : in std_logic_vector(4 downto 0);
		ValidReadData : out std_logic;
		TagReadData : out std_logic_vector(2 downto 0);
		ReadDataBlock : out std_logic_vector(7 downto 0));
end component;

for MemoryRow_1 : MemoryRow use entity work.MemoryRow(structural);
   signal ip3, op3 : std_logic_vector(7 downto 0);
   signal ip2, op2 : std_logic_vector(2 downto 0);
   signal ip1, op1 : std_logic;
   signal ip4, ip5, ip6 : std_logic_vector(4 downto 0);
   signal clock : std_logic;

begin

MemoryRow_1 : MemoryRow port map (ip1, ip2, ip3, ip4, ip5, ip6, op1, op2, op3);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "MBlock_in.txt";
  file outfile : text is out "MBlock_out.txt";
   variable i3, o3 : std_logic_vector(7 downto 0);
   variable i2, o2 : std_logic_vector(2 downto 0);
   variable i1, o1 : std_logic;
   variable i4, i5, i6 : std_logic_vector(4 downto 0);
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

    op1:=o1;
	op2:=o2;
	op3:=o3;

    write(buf,op1);  
    writeline(outfile,buf); 

  end loop;

end process io_process;

end test;
