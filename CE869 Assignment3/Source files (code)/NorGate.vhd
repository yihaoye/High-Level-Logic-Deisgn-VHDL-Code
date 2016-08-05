----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:19:18 03/12/2014 
-- Design Name: 
-- Module Name:    NorGate - Behavioral 
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

entity NorGate is
	port(q: IN STD_LOGIC_VECTOR(7 downto 0);--data output
		  FFinput: OUT STD_LOGIC);--norgate output

end NorGate;

architecture Behavioral of NorGate is

begin
	PROCESS
	BEGIN
		IF q = "00000000" THEN
			FFinput <= '1';
		ELSE
			FFinput <= '0';
		END IF;
		--when q equals to 0, FF send out 1,or send out 0
	END PROCESS;

end Behavioral;

