----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:40 03/12/2014 
-- Design Name: 
-- Module Name:    Datapath2 - Behavioral 
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

entity Datapath2 is
	port(PCload: IN STD_LOGIC; --PC enable
		  Reset: IN STD_LOGIC;	--reset signal					
		  Clock: IN STD_LOGIC;	--clock signal
		  
		  IRload: IN STD_LOGIC; --IR enable
		  IRoutput: OUT STD_LOGIC_VECTOR(7 downto 0);
		  
		  Jmux: IN STD_LOGIC);
		  
end Datapath2;

architecture Behavioral of Datapath2 is
	SIGNAL PCoutput: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL PCinput: STD_LOGIC_VECTOR(3 downto 0);
	--SIGNAL JumpUnitOutput: STD_LOGIC_VECTOR(3 downto 0);
	
	SIGNAL UnJumpAddress: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL JumpAddress: STD_LOGIC_VECTOR(3 downto 0);
	
	SIGNAL ROMoutput: STD_LOGIC_VECTOR(7 downto 0);

begin

	PC : entity PC (Behavioral)
			port map (PCload => PCload, Reset => Reset, Clock => Clock, 
						 PCoutput => PCoutput, PCinput => PCinput);
	--PC entity, which implement the PC address send out
	
	PCincrement : entity PCincrement (Behavioral)
			port map (PCoutput => PCoutput, UnJumpAddress => UnJumpAddress);
	--PCincrement entity, which implement the increament of previous PC address
	
	ROMfile : entity ROMfile (Behavioral)
			port map (Clock => Clock, PCoutput => PCoutput, ROMoutput => ROMoutput);
	--ROMfile entity, which store the instructions
	
	IR : entity IR (Behavioral)
			port map (Clock => Clock, IRload => IRload, ROMoutput => ROMoutput, 
						 IRoutput => IRoutput, JumpAddress => JumpAddress);
	--IR entity, which implement the next instruction send out
	
	JumpUnit : entity JumpUnit (Behavioral)
			port map (JumpAddress => JumpAddress, UnJumpAddress => UnJumpAddress, 
						 Jmux => Jmux, PCinput => PCinput);
	--JumpUnit entity, which implement the choose of jump address or point to next address
	
	

end Behavioral;

