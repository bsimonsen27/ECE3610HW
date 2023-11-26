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
  Port (d_in : in std_logic_vector(N-1 downto 0);   -- input data
        clk : in std_logic;                         -- clock
        s_in : in std_logic;                        -- serial input
        ld : in std_logic;                          -- load enable (active high)
        shft : in std_logic;                        -- shift enable (active high)
        c_en : in std_logic;                         -- clear enable (active high)
        d_out : out std_logic_vector(N-1 downto 0));-- output data
end M_Reg;

architecture Behavioral of M_Reg is
-------------- SIGNAL DECLARATION ---------------
signal d_buf : std_logic_vector(N-1 downto 0);     -- internal signal for data

begin

process(clk)
begin
    if rising_edge (clk) then
        if c_en = '1' then      -- clear data
            d_buf <= (others => '0');
        elsif ld = '1' then     -- load data in
            d_buf <= d_in;
        elsif shft = '1' then
            d_buf <= s_in & d_buf(N-1 downto 1);
        end if;
    end if;

end process;

d_out <= d_buf;        -- buffer


end Behavioral;
