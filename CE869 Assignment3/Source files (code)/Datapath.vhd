----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:43:36 03/17/2014 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity Datapath is
	port(DataInput: in STD_LOGIC_VECTOR(7 downto 0);
		  IE: IN STD_LOGIC;
		  WE: IN STD_LOGIC;							-- write enable
		  WA: IN STD_LOGIC_VECTOR(1 downto 0);	-- write address
		  RAE: IN STD_LOGIC;							-- read port A enable
		  RAA: IN STD_LOGIC_VECTOR(1 downto 0);-- read port A address
		  RBE: IN STD_LOGIC;							-- read port B enable
		  RBA: IN STD_LOGIC_VECTOR(1 downto 0);-- read port B address
		  OP: in  STD_LOGIC_VECTOR (2 downto 0);-- operation code
		  ZE: IN STD_LOGIC;		--FF enable
		  Clock: in  STD_LOGIC;	--clock signal
		  Z: OUT STD_LOGIC;
		  OE: IN STD_LOGIC;		--OE signal
		  DataOutput: OUT STD_LOGIC_VECTOR(7 downto 0);
		  
		  
		  PCload: IN STD_LOGIC; --PC enable
		  Reset: IN STD_LOGIC;	--reset signal
		  IRload: IN STD_LOGIC;	--IR unit enable
		  IRoutput: OUT STD_LOGIC_VECTOR(7 downto 0);	--instruction send out
		  Jmux: IN STD_LOGIC); --PC address jump or not
		  
end Datapath;

architecture Behavioral of Datapath is

begin

	Datapath1 : entity Datapath1 (Behavioral)
			port map (DataInput => DataInput, IE => IE, WE => WE, WA => WA, RAE => RAE,
						 RAA => RAA, RBE => RBE, RBA => RBA, OP => OP, ZE => ZE, Clock => Clock, Z => Z, OE => OE, DataOutput => DataOutput);
	--Datapath1 entity, which implement the arithmetic instruction

	Datapath2 : entity Datapath2 (Behavioral)
			port map (PCload => PCload, Reset => Reset, Clock => Clock, IRload => IRload, Jmux => Jmux, IRoutput => IRoutput);
	--Datapath2 entity, which implement the program sequencing flow instruction


end Behavioral;

