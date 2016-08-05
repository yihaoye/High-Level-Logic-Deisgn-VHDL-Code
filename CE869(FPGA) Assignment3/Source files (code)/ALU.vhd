----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:33:37 02/20/2014 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
	    Port ( 
				OP : in  STD_LOGIC_VECTOR (2 downto 0);
				A : in  STD_LOGIC_VECTOR (7 downto 0);--input A
				B : in  STD_LOGIC_VECTOR (7 downto 0);--input B
				q : out  STD_LOGIC_VECTOR (7 downto 0));--result of the operation logic with signal A and B

end ALU;

architecture Behavioral of ALU is

begin
	
	PROCESS
	BEGIN
	
	IF OP = "000" THEN q <= A and B;
	ELSIF OP = "001" THEN q <= A or B;
	ELSIF OP = "010" THEN q <= not A;
	ELSIF OP = "011" and A > B THEN q <= "11111111";
	ELSIF OP = "100" THEN q <= STD_LOGIC_VECTOR(UNSIGNED(A) + UNSIGNED(B));
	ELSIF OP = "101" THEN q <= STD_LOGIC_VECTOR(UNSIGNED(A) - UNSIGNED(B));
	ELSIF OP = "110" THEN q <= STD_LOGIC_VECTOR(UNSIGNED(A) + 1);
	ELSIF OP = "111" THEN q <= STD_LOGIC_VECTOR(UNSIGNED(A) - 1);
	END IF;
	
	END PROCESS;
	--process which implement all the logic operation for signal A and B

	
end Behavioral;

