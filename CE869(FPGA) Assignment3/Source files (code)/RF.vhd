----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:37 03/06/2014 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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

entity RegFile is 
	port(Clock: IN STD_LOGIC;
		  WE: IN STD_LOGIC;							-- write enable
		  WA: IN STD_LOGIC_VECTOR(1 downto 0);	-- write address
		  RAE: IN STD_LOGIC;							-- read port A enable
		  RAA: IN STD_LOGIC_VECTOR(1 downto 0);-- read port A address
		  RBE: IN STD_LOGIC;							-- read port B enable
		  RBA: IN STD_LOGIC_VECTOR(1 downto 0);-- read port B address
		  RFinput: IN STD_LOGIC_VECTOR(7 downto 0);
		  A, B: OUT STD_LOGIC_VECTOR(7 downto 0));
end RegFile;

architecture Behavioral of RegFile is 
	SUBTYPE reg IS STD_LOGIC_VECTOR(7 downto 0);
	TYPE regArray IS ARRAY(0 to 3) OF reg;
	SIGNAL RF: regArray;
begin

	WritePort: PROCESS
	BEGIN
		WAIT UNTIL RISING_EDGE(Clock);
		IF WE = '1' THEN
			RF(TO_INTEGER(UNSIGNED(WA))) <= RFinput;
		END IF;
		--when write enable, write input data to register file location
	END PROCESS;

	--Read Port A
	A <= RF(TO_INTEGER(UNSIGNED(RAA))) WHEN RAE = '1'
		ELSE (OTHERS => '0');
		
	--Read Port B
	B <= RF(TO_INTEGER(UNSIGNED(RBA))) WHEN RBE = '1'
		ELSE (OTHERS => '0');

end Behavioral;

