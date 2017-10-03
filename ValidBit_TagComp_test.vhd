-------------------------------------------------------
--Entity : ValidBit_TagComp
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity ValidBit_TagComp_test is

end ValidBit_TagComp_test;

architecture test of ValidBit_TagComp_test is

component ValidBit_TagComp
	port(
		Or_Start : in std_logic;
		CPU_Add : in std_logic_vector(7 downto 0);
		ValidBit : in std_logic;
		Tag : in std_logic_vector(2 downto 0);
		ValidBit_TagCompResult : out std_logic);
end component;

for ValidBit_TagComp_1 : ValidBit_TagComp use entity work.ValidBit_TagComp(structural);
   signal ip1, ip3 : std_logic;
   signal ip2 : std_logic_vector(7 downto 0);
   signal ip4 : std_logic_vector(2 downto 0);
   signal op1 : std_logic;
   signal clock : std_logic;

begin

ValidBit_TagComp_1 : ValidBit_TagComp port map (ip1, ip2, ip3, ip4, op1);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "ValidTag_in.txt";
  file outfile : text is out "ValidTag_out.txt";
  variable i1, i3 : std_logic;
  variable  i2 : std_logic_vector(7 downto 0);
  variable i4 : std_logic_vector(2 downto 0);
  variable o1 : std_logic;
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

    wait until falling_edge(clock);

    o1:=op1;

    write(buf,o1); 
    writeline(outfile,buf);  

  end loop;

end process io_process;

end test;
