--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4 ALU
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testALU_vhd IS
END testALU_vhd;

ARCHITECTURE behavior OF testALU_vhd IS 
	COMPONENT ALU
		Port(	DataIn1: in std_logic_vector(31 downto 0);
			DataIn2: in std_logic_vector(31 downto 0);
			ALUCtrl: in std_logic_vector(4 downto 0);
			Zero: out std_logic;
			ALUResult: out std_logic_vector(31 downto 0) );
	end COMPONENT ALU;

-- Inputs
	SIGNAL datain_a : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL datain_b : std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control	: std_logic_vector(4 downto 0)	:= (others=>'0');

-- Outputs
	SIGNAL result   :  std_logic_vector(31 downto 0);
	SIGNAL zeroOut  :  std_logic;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => datain_a,
		DataIn2 => datain_b,
		ALUCtrl => control,
		Zero => zeroOut,
		ALUResult => result
	);
	tb : PROCESS
	BEGIN
		wait for 100 ns; -- wait 100 ns for global reset 

		-- add/addi test. Control in binary
		datain_a <= X"01234567";	-- DataIn input hex
		datain_b <= X"11223344";
		control  <= "00000";		
		-- result = 0x124578AB  and zeroOut = 0 
		wait for 20 ns;				
		control <= "00001";             
		-- Test subtract -> result = 0xF0011223
		wait for 20 ns;			
		control <= "01010";		
		-- Test AND -> result = 0X048D159C
		wait for 20 ns;				
		control <= "01011";		
		-- Test OR -> result = 0x091A2B38
		wait for 20 ns;				
		datain_a <= X"00004004";  
		-- Test the shift register
		control <= "01001"; -- shifts 1 bit -> 0x00008008
		wait for 20 ns; 
		control <= "01010";  -- shifts  2 bits  ->  0x00010010
		wait for 20 ns; 
		control <= "01011"; -- shifts 3 bits  ->  0x00020020
		wait for 20 ns; 
		control <= "01101"; -- shifts 1 bits  ->  0x00002002
		wait for 20 ns; 
		control <= "10000"; --  result = 0x11223344
		wait;
	END PROCESS;

END;