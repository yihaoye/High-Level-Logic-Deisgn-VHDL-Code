----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:16 03/12/2014 
-- Design Name: 
-- Module Name:    TriStateBuffer - Behavioral 
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

entity TriStateBuffer is
	port(OE: IN STD_LOGIC;--oe signal
		  q: IN STD_LOGIC_VECTOR(7 downto 0);--data output 
		  DataOutput: OUT STD_LOGIC_VECTOR(7 downto 0));--data send out
	
end TriStateBuffer;

architecture Behavioral of TriStateBuffer is

begin
	PROCESS
	BEGIN
		IF OE = '1' THEN
			DataOutput <= q;
		END IF;
		--when oe = 1, send out data
	END PROCESS;

end Behavioral;

