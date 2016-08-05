----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:55 03/06/2014 
-- Design Name: 
-- Module Name:    FF - Behavioral 
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

entity FF is
	port(Clock: IN STD_LOGIC;--clock signal
		  ZE: IN STD_LOGIC;--ze signal, which enable the FF unit
		  FFinput: IN STD_LOGIC;--norgate output
		  Z: OUT STD_LOGIC);--Z
end FF;

architecture Behavioral of FF is

begin
	PROCESS
	BEGIN
		WAIT UNTIL RISING_EDGE(Clock);
		IF ZE = '1' THEN
			Z <= FFinput;
		END IF;
		--when ZE equals 1, Z receive the data from norgate
	END PROCESS;

end Behavioral;

