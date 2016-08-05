----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:17:43 02/20/2014 
-- Design Name: 
-- Module Name:    main - Behavioral 
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

entity main is
   Port ( SW       : in  UNSIGNED (7 downto 0);--switch
	RCCK     : in  STD_LOGIC;
	MCLK     : in  STD_LOGIC;--MCLK clock
	BTN      : in  STD_LOGIC_VECTOR (3 downto 0);--four buttons ?????
   DP       : out STD_LOGIC;
	LED		: out UNSIGNED (7 downto 0);--eight bits LED
   CATHODES : out STD_LOGIC_VECTOR (6 downto 0);--signal control seven segments
   ANODES   : out STD_LOGIC_VECTOR (3 downto 0));--signal control four seven segments display

   attribute LOC : string;
   attribute CLOCK_DEDICATED_ROUTE : boolean;
	attribute LOC of SW   : signal is "N3 E2 F3 G3 B4 K3 L3 P11";
	attribute LOC of RCCK : signal is "C8";
	attribute LOC of MCLK : signal is "B8";
	attribute LOC of BTN : signal is "A7 M4 C11 G12";
	attribute CLOCK_DEDICATED_ROUTE of BTN : signal is FALSE;
   attribute LOC of DP  : signal is "N13";
   attribute LOC of CATHODES : signal is "M12 L13 P12 N11 N14 H12 L14";
	attribute LOC of LED : signal is "G1 P4 N4 N5 P6 P7 M11 M5";
   attribute LOC of ANODES   : signal is "K14 M13 J12 F12";

end main;

architecture Behavioral of main is
	signal D0, D1, D2, D3 : UNSIGNED (3 downto 0); --signal control all the seven segments display
	signal q : STD_LOGIC_VECTOR (7 downto 0);	--result of the operation logic with signal A and B

	signal DataInput: STD_LOGIC_VECTOR(7 downto 0);
	signal IE: STD_LOGIC;
	signal WE: STD_LOGIC;							-- write enable
	signal WA: STD_LOGIC_VECTOR(1 downto 0);	-- write address
	signal RAE: STD_LOGIC;							-- read port A enable
	signal RAA: STD_LOGIC_VECTOR(1 downto 0);-- read port A address
	signal RBE: STD_LOGIC;							-- read port B enable
	signal RBA: STD_LOGIC_VECTOR(1 downto 0);-- read port B address
	signal OP: STD_LOGIC_VECTOR (2 downto 0);
	signal ZE: STD_LOGIC;
	signal Z: STD_LOGIC;
	signal OE: STD_LOGIC;
	--DataOutput: OUT STD_LOGIC_VECTOR(7 downto 0);

	signal PCload: STD_LOGIC;
	signal Reset: STD_LOGIC;	
	signal IRload: STD_LOGIC;
	signal IRoutput: STD_LOGIC_VECTOR(7 downto 0);
	signal Jmux: STD_LOGIC;
	
	signal Clock: STD_LOGIC;
	
begin
	
	DataInput <= STD_LOGIC_VECTOR(SW);	--put the input of switchs to DataInput 
	Reset <= BTN(3);--use left most button as reset input
	Clock <= MCLK;--use MCLK as the clock input


	ControlUnit : entity ControlUnit (Behavioral)
			port map (IE => IE, WE => WE, WA => WA, RAE => RAE, RAA => RAA, RBE => RBE, 
						 RBA => RBA, OP => OP, ZE => ZE, Z => Z, OE => OE, PCload => PCload, 
						 IRload => IRload, IRoutput => IRoutput, Jmux => Jmux, 
						 Clock => Clock, Reset => Reset);
	--ControlUnit entity, which send control signal to datapath


	Datapath : entity Datapath (Behavioral)
			port map (IE => IE, WE => WE, WA => WA, RAE => RAE, RAA => RAA, RBE => RBE, 
						 RBA => RBA, OP => OP, ZE => ZE, Z => Z, OE => OE, PCload => PCload, 
						 IRload => IRload, IRoutput => IRoutput, Jmux => Jmux, 
						 Clock => Clock, Reset => Reset, DataInput => DataInput, DataOutput => q);
	--Datapath entity, which implement the function of datapath

						
	Display_unit : entity Display (Behavioral)
			port map (CATHODES => CATHODES, ANODES => ANODES, DP => DP, MCLK => MCLK, 
						D0 => D0, D1 => D1, D2 => D2, D3 => D3);
	--Display entity, which display the output of the program
						
						
	D1 <= UNSIGNED(q (7 downto 4));	--second right seven segments display show the higher four bits of q
	D0 <= UNSIGNED(q (3 downto 0));	--most right seven segments display show the lower four bits of q
	LED <= UNSIGNED(IRoutput);	--LED indicate the value of IRoutput

end Behavioral;
