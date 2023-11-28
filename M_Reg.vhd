----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 06:45:15 PM
-- Design Name: 
-- Module Name: M_Reg - Behavioral
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
library UNISIM;
--use UNISIM.VComponents.all;

entity M_Reg is
  generic (N : integer := 4);                       -- how many bits do we want to shift
  Port (Din: in std_logic_vector(N-1 downto 0); --N-bit input
        Dout: out std_logic_vector(N-1 downto 0); --N-bit output
        Clk: in std_logic;--Clock (rising edge)
        Load: in std_logic;--Load enable
        Shift: in std_logic;--Shift enable
        Clear: in std_logic;--Clear enable
        SerIn: in std_logic);--Serial input
end M_Reg;

architecture Behavioral of M_Reg is
-------------- SIGNAL DECLARATION ---------------
signal Dinternal: std_logic_vector(N-1 downto 0); -- internal data signal


begin
process (Clk)
begin
    if (rising_edge(Clk)) then
        if (Clear = '1') then
            Dinternal<= (others => '0'); --Clear
        elsif(Load = '1') then
            Dinternal<= Din;--Load
        elsif(Shift = '1') then
            Dinternal<= SerIn& Dinternal(N-1 downto 1); --Shift
        end if;
    end if;
end process;
Dout<= Dinternal;--Drive outputs**
end Behavioral;
