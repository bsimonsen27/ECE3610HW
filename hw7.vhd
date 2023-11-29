----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2023 11:53:47 AM
-- Design Name: 
-- Module Name: hw7 - Behavioral
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

entity hw7 is
  Port (clk, reset : in std_logic;
        x : in std_logic_vector(2 downto 0);
        z : out std_logic_vector(2 downto 0));
end hw7;

architecture Behavioral of hw7 is

type states is (s0, s1, s2);

signal cs: states := s0;

begin
process(clk, reset)
begin
    if reset = '1' then
        z <= "000";
        
    elsif falling_edge(clk) then
        case cs is
        when s0 =>
            if x(0) = '1' then 
                 cs <= s1;
                 z <= "001";
            elsif x = "000" then
                z <= "010";
                cs <= s1;
            elsif x = "010" then
                cs <= s1;
                z <= "111";
            elsif x = "001" then
                z <= "010";
                cs <= s2;
            elsif x = "011" then
                cs <= s2;
                z <= "011";
            end if;
        
        when s1 =>
            cs <= s0;
        
        when s2 =>
            if x(1) = '1' then
                cs <= s2;
                z <= "000";
            else
                if x(0) = '1' then
                    cs <= s0;
                    z <= "000";
                else
                    cs <= s1;
                    z <= "101";
                end if;
            end if;
        when others =>
            cs <= s0;
            z <= "000";
        end case;
    end if;

end process;


end Behavioral;
