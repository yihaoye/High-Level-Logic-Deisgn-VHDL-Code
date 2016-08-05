----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:44:02 03/12/2014 
-- Design Name: 
-- Module Name:    JumpUnit - Behavioral 
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

entity JumpUnit is
	port(JumpAddress: IN STD_LOGIC_VECTOR(3 downto 0);
		  UnJumpAddress: IN STD_LOGIC_VECTOR(3 downto 0);
		  Jmux: IN STD_LOGIC;
		  PCinput: OUT STD_LOGIC_VECTOR(3 downto 0));
end JumpUnit;

architecture Behavioral of JumpUnit is

begin

	
	WITH Jmux SELECT
		PCinput <= JumpAddress WHEN '0',
					  UnJumpAddress WHEN OTHERS;
	--when jmux signal equals 0, PC jump with jump address, otherwise increament itself

end Behavioral;

