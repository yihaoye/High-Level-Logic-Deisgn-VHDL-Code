----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:41:53 03/06/2014 
-- Design Name: 
-- Module Name:    IR - Behavioral 
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

entity IR is
	port(Clock: IN STD_LOGIC; --clock signal
	     IRload: IN STD_LOGIC; --IR unit enable signal
		  ROMoutput: IN STD_LOGIC_VECTOR(7 downto 0); -- next instruction
		  JumpAddress: OUT STD_LOGIC_VECTOR(3 downto 0); --PC increament address, not jump address
		  IRoutput: OUT STD_LOGIC_VECTOR(7 downto 0)); --next instruction send to control unit
end IR;

architecture Behavioral of IR is

begin
	PROCESS
	BEGIN
		WAIT UNTIL RISING_EDGE(Clock); -- detect a clock
		IF IRload = '1' THEN
			JumpAddress <= ROMoutput(3 downto 0);
			IRoutput <= ROMoutput;
			--when IR enabled, send out next instruction and send the jump address to PC
		END IF;
	END PROCESS;

end Behavioral;

