----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:09 03/06/2014 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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

entity PC is
	port(PCload: IN STD_LOGIC; --enable the PC to get address from input
		  Reset: IN STD_LOGIC;	--reset signal						
		  Clock: IN STD_LOGIC;	--clock signal
		  PCoutput: OUT STD_LOGIC_VECTOR(3 downto 0); --next instruction address
		  PCinput: IN STD_LOGIC_VECTOR(3 downto 0)); --PC input
end PC;

architecture Behavioral of PC is
--	SIGNAL counter: STD_LOGIC_VECTOR(3 downto 0);	
begin
	PROCESS
	BEGIN
		WAIT UNTIL RISING_EDGE(Clock); --detect a clock

		IF Reset = '1' THEN
			PCoutput <= "0000"; -- when reset detected, set the PC address to 0
		ELSIF PCload = '1' THEN
			PCoutput <= PCinput; --when no reset and PC enabled, load the value of PC input
		END IF;
		
		
	END PROCESS;

end Behavioral;

