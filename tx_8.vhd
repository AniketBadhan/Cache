-- Entity: tx
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/11/2003

  
library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity tx_8 is                      
  port ( 
		sel8   : in std_logic;
        selnot8: in std_logic;
        input8 : in std_logic_vector(7 downto 0);  
        output8 :out std_logic_vector(7 downto 0));
end tx_8;                  

architecture structural of tx_8 is

component tx
  port ( 
		sel   : in std_logic;
        selnot: in std_logic;
        input : in std_logic;  
        output:out std_logic);
end component;

for tx_1 : std_logic;
for tx_2 : std_logic;
for tx_3 : std_logic;
for tx_4 : std_logic;
for tx_5 : std_logic;
for tx_6 : std_logic;
for tx_7 : std_logic;
for tx_8 : std_logic;
			
begin

	tx_1 : tx port map(sel8, selnot8, input8(7), output8(7));
	tx_2 : tx port map(sel8, selnot8, input8(6), output8(6));
	tx_3 : tx port map(sel8, selnot8, input8(5), output8(5));
	tx_4 : tx port map(sel8, selnot8, input8(4), output8(4));
	tx_5 : tx port map(sel8, selnot8, input8(3), output8(3));
	tx_6 : tx port map(sel8, selnot8, input8(2), output8(2));
	tx_7 : tx port map(sel8, selnot8, input8(1), output8(1));
	tx_8 : tx port map(sel8, selnot8, input8(0), output8(0));

end structural;