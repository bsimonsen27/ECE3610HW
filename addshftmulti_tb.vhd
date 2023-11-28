----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 11:42:11 AM
-- Design Name: 
-- Module Name: addshftmulti_tb - Behavioral
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

entity addshftmulti_tb is
--  Port ( );
end addshftmulti_tb;

architecture Behavioral of addshftmulti_tb is

signal clk_tb : std_logic := '0';
signal multiplier_tb, multiplicand_tb : std_logic_vector(3 downto 0) := "0000";
signal start_tb : std_logic;
signal done_tb : std_logic;
signal product_tb : std_logic_vector(7 downto 0) := "00000000";

component M_top is
    Port (Multiplier: in std_logic_vector(3 downto 0);
        Multiplicand: in std_logic_vector(3 downto 0);
        Product: out std_logic_vector(7 downto 0);
        Start: in std_logic;
        Clk: in std_logic;
        Done: out std_logic);
end component;

begin

UUT: M_top port map(Multiplier => multiplier_tb,
                    Multiplicand => multiplicand_tb,
                    Product => product_tb,
                    Start => start_tb,
                    Clk => clk_tb,
                    Done => done_tb);

clk_tb <= not clk_tb after 10 ns;

process
begin
    for i in 15 downto 0 loop
        multiplier_tb <= std_logic_vector(TO_UNSIGNED(i,4));
        for j in 15 downto 0 loop
            multiplicand_tb <= std_logic_vector(to_unsigned(j,4));
            start_tb <= '0', '1' after 5 ns, '0' after 40 ns;
            wait for 50 ns;
            wait until done_tb = '1';
            assert(to_integer(UNSIGNED(product_tb)) = (i*j))
                report"Incorrect product" severity NOTE;
            wait for 50 ns;
        end loop;
    end loop;

end process;


end Behavioral;
