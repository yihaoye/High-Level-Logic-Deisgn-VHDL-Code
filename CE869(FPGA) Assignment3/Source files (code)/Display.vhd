----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:53:08 02/27/2014 
-- Design Name: 
-- Module Name:    Display - Behavioral 
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

entity Display is
	    Port ( CATHODES : out STD_LOGIC_VECTOR (6 downto 0);--signal control seven segments
				ANODES : out STD_LOGIC_VECTOR (3 downto 0);--signal control four seven segments display
				DP : out STD_LOGIC;--display the decimal point
				D0, D1, D2, D3 : IN UNSIGNED (3 downto 0);--signal control all the seven segments display
				--CK : in STD_LOGIC;
				MCLK : in  STD_LOGIC);--MCLK clock
end Display;

architecture Behavioral of Display is
	SIGNAL disp_ck : STD_LOGIC;
	SIGNAL fr_cnt : UNSIGNED (10 DOWNTO 0);
begin
	four_digits_unit : ENTITY four_digits(Behavioral)
		PORT MAP (d3 => d3, d2 => d2, d1 => d1, d0 => d0, DP => DP,
		ck => disp_ck, cathodes => cathodes, anodes => anodes);
	--four digits display used for display the output of the program
		
	fr_1kHz : PROCESS
	BEGIN
	WAIT UNTIL RISING_EDGE(mclk);
	disp_ck <= fr_cnt(fr_cnt'HIGH);
	fr_cnt <= fr_cnt + 1;
	END PROCESS;
	--divide the mclk clock, which used for scan and update the four digits display

end Behavioral;

