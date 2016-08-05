----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:38:53 02/20/2014 
-- Design Name: 
-- Module Name:    OP - Behavioral 
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

entity OP is
    Port ( BTN : in  STD_LOGIC_VECTOR (3 downto 0);
           A : in  UNSIGNED (7 downto 0);
			  B : in  UNSIGNED (7 downto 0);
			  --LED : out  UNSIGNED (7 downto 0);
			  q : out UNSIGNED (7 downto 0));
end OP;

architecture Behavioral of OP is

begin


	PROCESS
	BEGIN
--	IF BTN = "0000" THEN LED <= A and B;
--	ELSIF BTN = "0001" THEN LED <= A or B;
--	ELSIF BTN = "0010" THEN LED <= not A;
--	ELSIF BTN = "0011" and A > B THEN LED <= "11111111";
--	ELSIF BTN = "0100" THEN LED <= A + B;
--	ELSIF BTN = "0101" THEN LED <= A - B;
--	ELSIF BTN = "0110" THEN LED <= A - 1;
--	ELSIF BTN = "0111" THEN LED <= A + 1;
--	END IF;
	
	IF BTN = "0000" THEN q <= A and B;
	ELSIF BTN = "0001" THEN q <= A or B;
	ELSIF BTN = "0010" THEN q <= not A;
	ELSIF BTN = "0011" and A > B THEN q <= "11111111";
	ELSIF BTN = "0100" THEN q <= A + B;
	ELSIF BTN = "0101" THEN q <= A - B;
	ELSIF BTN = "0110" THEN q <= A + 1;
	ELSIF BTN = "0111" THEN q <= A - 1;
	END IF;
	
	END PROCESS;

	
end Behavioral;

