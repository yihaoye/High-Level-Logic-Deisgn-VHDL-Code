----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:53:19 03/12/2014 
-- Design Name: 
-- Module Name:    DataInputUnit - Behavioral 
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

entity DataInputUnit is
	port(DataInput: IN STD_LOGIC_VECTOR(7 downto 0);
		  q: IN STD_LOGIC_VECTOR(7 downto 0);--data ouput
		  IE: IN STD_LOGIC; --datainput enable
		  RFinput: OUT STD_LOGIC_VECTOR(7 downto 0));-- transfer data to register file
end DataInputUnit;

architecture Behavioral of DataInputUnit is

begin

PROCESS
BEGIN
	IF IE = '1' THEN
		RFinput <= DataInput;
	ELSE
		RFinput <= q;
	END IF;
	--when IE equals 1, receive data from outside, or receive feedback data
END PROCESS;

end Behavioral;

