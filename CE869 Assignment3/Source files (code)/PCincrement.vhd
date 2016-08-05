----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:05:41 03/12/2014 
-- Design Name: 
-- Module Name:    PCincrement - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCincrement is
	port(PCoutput: IN STD_LOGIC_VECTOR(3 downto 0); --PC address
		  UnJumpAddress: OUT STD_LOGIC_VECTOR(3 downto 0)); --Output of increment units
end PCincrement;

architecture Behavioral of PCincrement is

begin
	UnJumpAddress <= (STD_LOGIC_VECTOR(UNSIGNED(PCoutput) + 1));
	--when no jump is required, increase PC address and extract the next instruction

end Behavioral;

