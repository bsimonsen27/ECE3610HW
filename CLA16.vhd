----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2023 09:31:26 PM
-- Design Name: 
-- Module Name: CLA16 - Behavioral
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

entity CLA16 is
    Port (A, B : in bit_vector(15 downto 0);
          Ci : in bit;
          S : out bit_vector(15 downto 0);
          Co : out bit);
end CLA16;

architecture Behavioral of CLA16 is
    signal intermediateCarry : bit_vector(2 downto 0);  -- To hold the carry out of each 4-bit block
    signal PG, GG : bit_vector(3 downto 0);  -- Propagate and Generate signals for each block
begin
    -- First 4-bit CLA (LSBs)
    CLA0: entity work.CLA4
        port map (A => A(3 downto 0), B => B(3 downto 0), Ci => Ci, S => S(3 downto 0), Co => intermediateCarry(0), PG => PG(0), GG => GG(0));

    -- Second 4-bit CLA
    CLA1: entity work.CLA4
        port map (A => A(7 downto 4), B => B(7 downto 4), Ci => intermediateCarry(0), S => S(7 downto 4), Co => intermediateCarry(1), PG => PG(1), GG => GG(1));

    -- Third 4-bit CLA
    CLA2: entity work.CLA4
        port map (A => A(11 downto 8), B => B(11 downto 8), Ci => intermediateCarry(1), S => S(11 downto 8), Co => intermediateCarry(2), PG => PG(2), GG => GG(2));

    -- Fourth 4-bit CLA (MSBs)
    CLA3: entity work.CLA4
        port map (A => A(15 downto 12), B => B(15 downto 12), Ci => intermediateCarry(2), S => S(15 downto 12), Co => Co, PG => PG(3), GG => GG(3));
end Behavioral;

