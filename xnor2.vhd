-------------------------------------------------------
--Entity : xnor2
--Architecture : structural
--Auhtor : Aniket Badhan
-------------------------------------------------------

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity xnor2 is
	port(
		input1 : in std_logic;
		input2 : in std_logic;
		output : out std_logic);
end entity;
	
architecture structural of xnor2 is

begin

	output <= input1 xnor input2;

end structural;