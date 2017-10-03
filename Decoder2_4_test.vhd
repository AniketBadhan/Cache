-------------------------------------------------------
--Entity : Decoder2_4_test
--Architecture : test
--Auhtor : Aniket Badhan
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

entity Decoder2_4_test is

end Decoder2_4_test;

architecture test of Decoder2_4_test is

component Decoder2_4
	port(
		S : in std_logic_vector(2 downto 0);
		D : out std_logic_vector(7 downto 0));
end component;

for Decoder2_4_1 : Decoder2_4 use entity work.Decoder2_4(structural);
   
   signal ip1 : std_logic_vector(2 downto 0);
   signal op1 : std_logic_vector(7 downto 0);
   signal clock : std_logic;

begin

Decoder2_4_1 : Decoder2_4 port map (ip1, op1);

clk : process
   begin  -- process clk

    clock<='0','1' after 5 ns;
    wait for 10 ns;

  end process clk;

io_process: process

  file infile  : text is in "Decoder2_4_in.txt";
  file outfile : text is out "Decoder2_4_out.txt";
  variable i1 : std_logic_vector(2 downto 0);
  variable o1 : std_logic_vector(7 downto 0);
  variable buf : line;

begin

  while not (endfile(infile)) loop   

    readline(infile,buf);
    read (buf,i1);
    ip1<=i1;
	
    wait until falling_edge(clock);

    o1 := op1;

    write(buf,o1);  -- Writing G (output) to alu_4_out.txt
    writeline(outfile,buf);  -- Writing Cout(Carry out) to alu_4_out.txt

  end loop;

end process io_process;

end test;
