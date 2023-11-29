----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2023 12:25:35 PM
-- Design Name: 
-- Module Name: hw05 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hw05 is
	Port (x : in std_logic_vector (3 downto 0);
          B : out std_logic_vector (2 downto 0));
end hw05;

architecture Behavioral of hw05 is

-- state machine
Type states is (s1, s2, s3, s4, s5);
-- lookup table
--constant lookup_table : std_logic_vector(15 downto 0) :=
--    "000",  -- 0000 -> 0b000
--    "001",  -- 0001 -> 0b001
--    "001",  -- 0010 -> 0b001
--    "010",  -- 0011 -> 0b010
--    "001",  -- 0100 -> 0b001
--    "010",  -- 0101 -> 0b010
--    "010",  -- 0110 -> 0b010
--    "011",  -- 0111 -> 0b011
--    "001",  -- 1000 -> 0b001
--    "010",  -- 1001 -> 0b010
--    "010",  -- 1010 -> 0b010
--    "011",  -- 1011 -> 0b011
--    "010",  -- 1100 -> 0b010
--    "011",  -- 1101 -> 0b011
--    "011",  -- 1110 -> 0b011
--    "100";  -- 1111 -> 0b100

Signal state: states := s1;
Signal cnt: integer := 0;

begin
	Process(x)
	variable count : unsigned(2 downto 0) := (others => '0');
	begin
	   
--		case state is 
----------------------------------------
--			When s1 =>
--				if x(cnt) = '1' then
--				    cnt <= cnt + 1;
--					State <= s2;
--				Else
--				    cnt <= cnt + 1;
--					State <= s1;
--				End if;
----------------------------------------				
--			When s2 =>
--				If x(cnt) = '1' then
--				    cnt <= cnt + 1;
--					State <= s3;
--				Else
--				    cnt <= cnt + 1;
--					State <= s2;
--				End if;
----------------------------------------				
--			When s3 =>
--				If x(cnt) = '1' then
--				    cnt <= cnt + 1;
--					State <= s4;
--				Else
--					State <= s3;
--					cnt <= cnt + 1;
--				End if;
----------------------------------------
--			When s4 =>
--				If x(cnt) = '1' then
--					State <= s5;
--					cnt <= cnt + 1;
--				Else
--					State <= s4;
--					cnt <= cnt + 1;
--				End if;
----------------------------------------
--			When s5 =>
--				If x(cnt) = '1' then 
--					State <= s2;
--				Else 
--					State <= s1;
--				End if;
--			When others =>
--				State <= s1;
--				B <= "111";     -- indicates error has occured
			
--		End case;
--		if cnt > 3 then
--	       Cnt <= 0;
--			If state = s1 then
--				B <= "000";
--			Elsif state = s2 then 
--				B <= "001";
--			Elsif state = s3 then
--				B <= "010";
--			Elsif state = s4 then
--				B <= "011";
--			Elsif state = s5 then
--				B <= "100";
--			Else
--				B <= "111";     -- indicates there has been an error
--			End if;
--	       state <= s1;
--	       cnt <= 0;
--	   end if;
------------------------------------------------
-- bit_counter
        -- Initialize the count to 0
        count := (others => '0');

        -- Use a for loop to count the '1' bits in x
        for i in x'range loop
            if x(i) = '1' then
                count := count + 1;
            end if;
        end loop;

        -- Convert the count to std_logic_vector and assign it to b
        b <= std_logic_vector(count);

	   
------------------------------------------------
-- Look up table code
--    if x = "0000" then
--        b <= "000";
--    elsif x = "0001" or x = "0010" or x = "0100" or x = "1000" then
--        b <= "001";
--    elsif x = "0011" or x = "0101" or x = "0110" or x = "1001"
--    or x = "1010" or x = "1100" then
--        b <= "010";
--    elsif x = "0111" or x = "1011" or x = "1101" or x = "1110" then
--        b <= "011";
--    elsif x = "1111" then
--        b <= "100";
--    else 
--        b <= "111";
--    end if;
    
	End process;


end Behavioral;
