----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:24 03/06/2014 
-- Design Name: 
-- Module Name:    ROM - Behavioral 
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

entity ROMfile is
	port(Clock: IN STD_LOGIC;	--clock signal
		  PCoutput: IN STD_LOGIC_VECTOR(3 downto 0); --PC address
		  ROMoutput: OUT STD_LOGIC_VECTOR(7 downto 0)); --exstracted instruction
end ROMfile;

architecture Behavioral of ROMfile is
	SUBTYPE unitIR IS STD_LOGIC_VECTOR(7 downto 0); --8 bits for each location of ROM
	TYPE IRarray IS ARRAY(0 to 15) OF unitIR; --16 locations/address for one ROM
	
	--TASK1
--	CONSTANT ROM : IRarray := (
--        "10000000", -- 			IN B
--        "01000100", -- loop:	ADD A B
--        "01110000", -- 			DEC B
--        "11010001", -- 			JNZ loop
--        "10010100", -- 			OUT A
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", -- 			halt
--        "11111111", --			halt
--        "11111111", -- 			halt
--        "11111111"  -- 			halt
--	);
	
	--TASK2
--	CONSTANT ROM : IRarray := (
--			"10000000", -- 			IN A
--			"11101111", -- 			NOP
--			"01100100", -- 			INC B
--			"01100100", -- 			INC B
--			"01100100", -- 			INC B
--			"01100100", --     		INC B
--			"01100100", -- 			INC B
--			"00110100", -- loop:  	GT B,A
--			"11011110", -- 			JNZ end2
--			"01010001", --        	SUB A,B
--			"11001100", -- 			JZ  end1
--			"10110111", -- 			JMP loop
--			"10011000", -- end1:  	OUT C
--			"11111111", -- 			HALT  	
--			"10010000", -- end2:  	OUT A
--			"11111111"  -- 			HALT
--	);
	
	--TASK3 2.0
	CONSTANT ROM : IRarray := (
			"10001100", -- 			IN B3 (N)
			"00001111", -- 			AND B3 B3
			"11001011", -- 			JZ end
			"01111100", -- 			DEC B3
			"11001011", --     		JZ end
			"01101000",  -- 			INC B2
			"01001000", -- loop:		ADD B2 B0
			"10100001", -- 			MOV B0 B1
			"10100110", --        	MOV B1 B2
			"01111100", -- 			DEC B3
			"11010110", -- 		   JNZ loop
			"10011000", -- end:		OUT B2	
			"11111111", -- 		   HALT
			"11111111", -- 			HALT
			"11111111", -- 			HALT
			"11111111"  -- 			HALT
	);
	
	
--		--TASK3 1.0
--	CONSTANT ROM : IRarray := (
--			"10000000", -- 			IN A0 (N)
--			"01101000", -- 			INC A2
--			"01110000", -- 			DEC A0
--			"01110000", -- 			DEC A0
--			"11001110", --     		JZ end2
--			"01000110", -- loop:		ADD A1 A2
--			"01110000", -- 			DEC A0
--			"11001100", --        	JZ end1
--			"01001001", -- 			ADD A2 A1
--			"01110000", -- 		   DEC A0
--			"11001110", -- 			JZ end2 	
--			"10110101", -- 		   JMP loop
--			"10010100", -- end1:		OUT A1
--			"11111111",  -- 			HALT
--			"10011000", -- end2:		OUT A2
--			"11111111"  -- 			HALT
--	);
	
	
begin
	PROCESS
	BEGIN
		WAIT UNTIL RISING_EDGE(Clock);
			ROMoutput <= ROM(TO_INTEGER(UNSIGNED(PCoutput)));
			--as clock detect, extract the instruction with the PC address
			
	END PROCESS;


end Behavioral;

