----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:13:19 03/12/2014 
-- Design Name: 
-- Module Name:    Datapath1 - Behavioral 
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

entity Datapath1 is
	port(DataInput: in STD_LOGIC_VECTOR(7 downto 0);
		  IE: IN STD_LOGIC;

		  WE: IN STD_LOGIC;							-- write enable
		  WA: IN STD_LOGIC_VECTOR(1 downto 0);	-- write address
		  RAE: IN STD_LOGIC;							-- read port A enable
		  RAA: IN STD_LOGIC_VECTOR(1 downto 0);-- read port A address
		  RBE: IN STD_LOGIC;							-- read port B enable
		  RBA: IN STD_LOGIC_VECTOR(1 downto 0);-- read port B address
			
		  OP: in  STD_LOGIC_VECTOR (2 downto 0);	--operation code
		  
		  ZE: IN STD_LOGIC;
		  Clock: in  STD_LOGIC;	--clock signal
		  Z: OUT STD_LOGIC;
		  
		  OE: IN STD_LOGIC;
		  DataOutput: OUT STD_LOGIC_VECTOR(7 downto 0));

end Datapath1;


architecture Behavioral of Datapath1 is
	signal RFinput: STD_LOGIC_VECTOR(7 downto 0);
	signal A, B : STD_LOGIC_VECTOR(7 downto 0);	--input A and B, controlled by switch
	signal FFinput: STD_LOGIC;
	signal q : STD_LOGIC_VECTOR(7 downto 0);	--result of the operation logic with signal A and B
	
	signal tep:STD_LOGIC_VECTOR(7 downto 0); 

begin
	
	DataInputUnit : entity DataInputUnit (Behavioral)
			port map (DataInput => DataInput, IE => IE, q => q, RFinput => RFinput);
	--DataInputUnit entity, which implement the input of data
	
	RegFile : entity RegFile (Behavioral)
			port map (RFinput => RFinput, A => A, B => B,
						Clock => Clock, WE => WE, WA => WA, 
						RAE => RAE, RAA => RAA, RBE => RBE, RBA => RBA);
	--RF entity, which store the operated value

	ALU_unit : entity ALU (Behavioral)
			port map (A => A, B => B, OP => OP, q => q);
	--ALU entity, which implement the logic operation with signal A and B
						
	NorGate : entity NorGate (Behavioral)
			port map (q => q, FFinput => FFinput);
	--NorGate entity, which implement the norgate function
	
	FF : entity FF (Behavioral)
			port map (Clock => Clock, FFinput => FFinput, ZE => ZE, Z => Z);
	--FF entity, which implement the Z out put

	TriStateBuffer : entity TriStateBuffer (Behavioral)
			port map (OE => OE, q => q, DataOutput => tep);
	--TriStateBuffer entity, which implement the output enable
	
DataOutput<=tep;

end Behavioral;

