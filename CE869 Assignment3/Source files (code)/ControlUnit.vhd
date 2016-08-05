----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:05:25 03/13/2014 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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

entity ControlUnit is
	port(IE: OUT STD_LOGIC;
		  WE: OUT STD_LOGIC;							-- write enable
		  WA: OUT STD_LOGIC_VECTOR(1 downto 0);	-- write address
		  RAE: OUT STD_LOGIC;							-- read port A enable
		  RAA: OUT STD_LOGIC_VECTOR(1 downto 0);-- read port A address
		  RBE: OUT STD_LOGIC;							-- read port B enable
		  RBA: OUT STD_LOGIC_VECTOR(1 downto 0);-- read port B address
		  OP: OUT  STD_LOGIC_VECTOR (2 downto 0);	--operation code
		  ZE: OUT STD_LOGIC;
		  Z: IN STD_LOGIC;
		  OE: OUT STD_LOGIC;
		  
		  PCload: OUT STD_LOGIC;	--PC enable
		  IRload: OUT STD_LOGIC;		--IR enable
		  IRoutput: IN STD_LOGIC_VECTOR(7 downto 0);
		  Jmux: OUT STD_LOGIC;
	
		  Clock: IN STD_LOGIC;	--clock signal
		  Reset: IN STD_LOGIC);	--reset signal

end ControlUnit;

architecture Behavioral of ControlUnit is
	TYPE STATE_TYPE is (STATE_START, STATE_FETCH, 
							STATE_DECODE, STATE_AND, STATE_OR, STATE_NOT, 
							STATE_GT, STATE_ADD, STATE_SUB, STATE_INC, 
							STATE_DEC, STATE_IN, STATE_OUT, STATE_MOV, 
							STATE_JMP, STATE_JZ, STATE_JNZ, STATE_NOP, STATE_HALT);
				--state type set
	SIGNAL CUR_STATE, NX_STATE: STATE_TYPE; --state declare
	
	SIGNAL aa,bb: STD_LOGIC_VECTOR(1 downto 0);
begin
	
	aa <= IRoutput(3 downto 2);
	bb <= IRoutput(1 downto 0);
	
	
	
	state_registers : process (RESET, Clock)
	begin
		if RESET = '1' then
			CUR_STATE <= STATE_START;
			
		elsif rising_edge(Clock) then
			CUR_STATE <= NX_STATE;
			
		end if;
	end process;
	--when reset detect, set the state to initial state start
		


		
	state_transition : process (IRoutput, CUR_STATE)
	begin
		case CUR_STATE is
		
			when STATE_START =>
			
				Jmux <= '1'; 
				IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; ZE <= '0'; 
			
				IRload <= '0'; PCload <= '0'; 
 
				OE <= '0';
				
				NX_STATE <= STATE_FETCH;
				--state start operation

				
			when STATE_FETCH =>
			
				IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '1'; RAA <= aa; RBE <= '0'; RBA <= "00"; OP <= "001"; ZE <= '0'; --OE <= '0';
			
				IRload <= '1'; PCload <= '1'; Jmux <= '1';
				
				NX_STATE <= STATE_DECODE;
				--state FETCH operation
				
			when STATE_DECODE =>
			
				Jmux <= '1'; 
				WA <= "00"; RAA <= "00"; RBA <= "00"; OP <= "000"; 
			
				IRload <= '0'; PCload <= '0'; 
				IE <= '0'; WE <= '0'; RAE <= '0'; RBE <= '0'; ZE <= '0'; OE <= '0';
			
				if (IRoutput(7 downto 4) = "0000") then NX_STATE <= STATE_AND;
				elsif (IRoutput(7 downto 4) = "0001") then NX_STATE <= STATE_OR;
				elsif (IRoutput(7 downto 4) = "0010") then NX_STATE <= STATE_NOT;
				elsif (IRoutput(7 downto 4) = "0011") then NX_STATE <= STATE_GT;
				elsif (IRoutput(7 downto 4) = "0100") then NX_STATE <= STATE_ADD;
				elsif (IRoutput(7 downto 4) = "0101") then NX_STATE <= STATE_SUB;
				elsif (IRoutput(7 downto 4) = "0110") then NX_STATE <= STATE_INC;
				elsif (IRoutput(7 downto 4) = "0111") then NX_STATE <= STATE_DEC;
				elsif (IRoutput(7 downto 4) = "1000") then NX_STATE <= STATE_IN;
				elsif (IRoutput(7 downto 4) = "1001") then NX_STATE <= STATE_OUT;
				elsif (IRoutput(7 downto 4) = "1010") then NX_STATE <= STATE_MOV;
				elsif (IRoutput(7 downto 4) = "1011") then NX_STATE <= STATE_JMP;
				elsif (IRoutput(7 downto 4) = "1100") then NX_STATE <= STATE_JZ;
				elsif (IRoutput(7 downto 4) = "1101") then NX_STATE <= STATE_JNZ;
				elsif (IRoutput(7 downto 4) = "1110") then NX_STATE <= STATE_NOP;
				elsif (IRoutput(7 downto 4) = "1111") then NX_STATE <= STATE_HALT;
				end if;
				--state decode operation, execute the instruction of ROM by process the corresponding state

				
			when STATE_AND => -- STATE_AND
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; ZE <= '0'; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; RBE <= '1'; RBA <= bb; OP <= "000"; 
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_OR =>	--state or
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; ZE <= '0'; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; RBE <= '1'; RBA <= bb; OP <= "001"; 
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_NOT =>	--state not
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; RBE <= '0'; RBA <= "00"; ZE <= '0'; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; OP <= "010"; 
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_GT => --state GT
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; WE <= '0'; WA <= "00"; OE <= '0';
			
				RAE <= '1'; RAA <= aa; RBE <= '1'; RBA <= bb; OP <= "011"; ZE <= '1'; 
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_ADD => --state ADD
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; ZE <= '0'; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; RBE <= '1'; RBA <= bb; OP <= "100"; 
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_SUB => --state SUB
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; RBE <= '1'; RBA <= bb; OP <= "101"; 	ZE <= '1';--??
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_INC => --state INC
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; RBE <= '0'; RBA <= "00"; ZE <= '0'; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; OP <= "110"; 
				
				NX_STATE <= STATE_FETCH;--
			
			when STATE_DEC => --state DEC
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; RBE <= '0'; RBA <= "00"; OE <= '0';
			
				WE <= '1'; WA <= aa; RAE <= '1'; RAA <= aa; OP <= "111"; 	ZE <= '1'; --??
				
				NX_STATE <= STATE_FETCH;--
			----------------------------------------------------------------------------------------------------------------------
			when STATE_IN => --state IN, input data
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; ZE <= '0'; OE <= '0';
			
				IE <= '1'; WE <= '1'; WA <= aa; 
				
				NX_STATE <= STATE_FETCH;
			
			when STATE_OUT => --state OUT, output data
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; WE <= '0'; WA <= "00"; ZE <= '0'; 
			
				RAE <= '1'; RAA <= aa; RBE <= '0'; RBA <= "00"; OP <= "001"; OE <= '1';
				
				NX_STATE <= STATE_FETCH;
			
			when STATE_MOV => --state MOV
			
				IRload <= '0'; Jmux <= '1'; PCload <= '0'; 
				IE <= '0'; RAA <= "00"; ZE <= '0'; OE <= '0';

				WE <= '1'; WA <= aa; RAE <= '0'; RBE <= '1'; RBA <= bb; OP <= "001"; 
				
				NX_STATE <= STATE_FETCH;
			
			when STATE_JMP => --state JMP, jump

				IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; ZE <= '0'; OE <= '0';
			
				IRload <= '1'; 
				Jmux <= '0'; PCload <= '1'; 
				
				NX_STATE <= STATE_START;
			
			when STATE_JZ => --state JZ, jump if Z = 1
			
				IRload <= '0'; 
				IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; OE <= '0';
			
					ZE <= '1'; 
				IF Z = '0' THEN
					Jmux <= '1';
				ELSE
					Jmux <= '0';
					PCload <= '1'; 
				END IF;
				
				NX_STATE <= STATE_START;
			
			when STATE_JNZ => --state JNZ, jump if Z = 0
			
				IRload <= '0'; 
				IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; OE <= '0';
			
					ZE <= '1'; 
				IF Z = '1' THEN
					Jmux <= '1';
				ELSE
					Jmux <= '0';
					PCload <= '1'; 
				END IF;
				
				NX_STATE <= STATE_START;
			
			when STATE_NOP => --state NOP, do not thing
			
				--IRload <= '0'; Jmux <= '0'; PCload <= '0'; 
				--IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; ZE <= '0'; OE <= '0';
				
				NX_STATE <= STATE_FETCH;
			
			when STATE_HALT => --state HALT, stop
			
				--IRload <= '0'; Jmux <= '0'; PCload <= '0'; 
				--IE <= '0'; WE <= '0'; WA <= "00"; RAE <= '0'; RAA <= "00"; RBE <= '0'; RBA <= "00"; OP <= "000"; ZE <= '0'; OE <= '0';
				
				NX_STATE <= STATE_HALT;

				
		end case;
		
	end process;
	

end Behavioral;

