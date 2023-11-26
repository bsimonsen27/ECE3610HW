----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 06:43:45 PM
-- Design Name: 
-- Module Name: M_top - Behavioral
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

entity M_top is
    Port (clk : in std_logic;
          m_p : in std_logic_vector(3 downto 0);
          m_cand : in std_logic_vector(3 downto 0);
          st : in std_logic; 
          d_flag : out std_logic;
          p_out : out std_logic_vector(7 downto 0));
end M_top;

architecture Behavioral of M_top is
--use work.mult_components.all;

----------- SIGNAL DECLARATION ---------------
signal m_out, q_out : std_logic_vector(3 downto 0);
signal d_out, a_out : std_logic_vector(4 downto 0);
signal ld_s, shift_s, adda_s : std_logic;

begin


end Behavioral;
