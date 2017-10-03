-- Entity: tx
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/11/2003
--
  
library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity tx2Bit is                      
  port ( 
		readenable     : in std_logic;
        readenablebar  : in std_logic;
        input2  : in std_logic_vector(1 downto 0);  
        output2 :out std_logic_vector(1 downto 0));
end tx2Bit;          

architecture structural of tx2Bit is

component tx
  port ( 
		sel   : in std_logic;
        selnot: in std_logic;
        input : in std_logic;  
        output:out std_logic);
end component;

for tx_1, tx_2 : tx use entity work.tx(structural);

begin

	tx_1 : tx port map(readenable, readenablebar, input2(0), output2(0));
	tx_2 : tx port map(readenable, readenablebar, input2(1), output2(1));

end structural;