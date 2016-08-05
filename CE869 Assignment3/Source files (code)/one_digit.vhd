----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:38 01/16/2014 
-- Design Name: 
-- Module Name:    one_digit - Behavioral 
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

entity one_digit is
    Port ( DIGIT : in  UNSIGNED (3 downto 0);--digit signal which present the output value in binary type
           CATHODES : out  STD_LOGIC_VECTOR (6 downto 0));--signal control seven segments
end one_digit;

architecture Behavioral of one_digit is

begin
	WITH DIGIT SELECT
		CATHODES <= "1000000" WHEN "0000",--seven segments display shows 0
						"1111001" WHEN "0001",--seven segments display shows 1
						"0100100" WHEN "0010",--seven segments display shows 2
						"0110000" WHEN "0011",--seven segments display shows 3
						"0011001" WHEN "0100",--seven segments display shows 4
						"0010010" WHEN "0101",--seven segments display shows 5
						"0000010" WHEN "0110",--seven segments display shows 6
						"1111000" WHEN "0111",--seven segments display shows 7
						"0000000" WHEN "1000",--seven segments display shows 8
						"0010000" WHEN "1001",--seven segments display shows 9
						"0001000" WHEN "1010",--seven segments display shows A
						"0000000" WHEN "1011",--seven segments display shows B
						"1000110" WHEN "1100",--seven segments display shows C
						"1000000" WHEN "1101",--seven segments display shows D
						"0000110" WHEN "1110",--seven segments display shows E
						"0001110" WHEN OTHERS;--seven segments display shows F
					
end Behavioral;

