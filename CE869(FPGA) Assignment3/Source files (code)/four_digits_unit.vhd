----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:03:39 01/28/2014 
-- Design Name: 
-- Module Name:    four_digits_unit - Behavioral 
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

entity four_digits is
    Port (D0, D1, D2, D3 : in  UNSIGNED (3 downto 0);--signal control all the seven segments display
			CK : in  STD_LOGIC;--divided MCLK clock
			DP : out  STD_LOGIC;--decimal point
			CATHODES : out STD_LOGIC_VECTOR (6 downto 0);--signal control seven segments
			ANODES   : out STD_LOGIC_VECTOR (3 downto 0));--signal control four seven segments display
end four_digits;

architecture Behavioral of four_digits is
	signal DIGIT : UNSIGNED (3 downto 0);--digit signal which present the output value in binary type
	signal cnt : UNSIGNED (1 downto 0);-- cnt which indicate the clock runing

begin

	one_digit_unit : entity one_digit(Behavioral)
		port map (DIGIT => DIGIT,
			CATHODES => CATHODES);
-- one_digit_unit calling.

	PROCESS
	BEGIN
	
		WAIT UNTIL RISING_EDGE(CK);
		cnt <= cnt + 1;
		
	END PROCESS;
-- cnt which indicate the clock runing

	PROCESS
	BEGIN
		CASE cnt IS
		WHEN "00" =>
			DIGIT <= D0; ANODES <= "1110"; DP <= '1';
		WHEN "01" =>
			DIGIT <= D1; ANODES <= "1101"; DP <= '1';
		WHEN "10" =>
			DIGIT <= D2; ANODES <= "1011"; DP <= '1';
		WHEN OTHERS =>
			DIGIT <= D3; ANODES <= "0111"; DP <= '1';
		END CASE;
		
	END PROCESS;
-- Display different seven segments display when cnt change

end Behavioral;

