--
-- Entity: dff
-- Architecture : structural
-- Author: cpatel2
-- Created On: 11/11/2003
--

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity DFlipFlop is                      
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end DFlipFlop;                          

architecture structural of DFlipFlop is 
  
begin
  
  output: process                 

  begin                           
    wait until ( clk'EVENT and clk = '0' ); 
    q <= d;
    qbar <= not d ;
  end process output;        
                             
end structural;  
