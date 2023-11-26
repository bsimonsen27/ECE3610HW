----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 07:48:22 PM
-- Design Name: 
-- Module Name: M_ctrl - Behavioral
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

entity M_ctrl is
  generic ( N : integer := 2);
  Port (clk : in std_logic;             -- clk
        lsb : in std_logic;             -- least sig bit of multiplier
        st : in std_logic;              -- start
        ld : out std_logic;             -- load enable
        shft_en : out std_logic;           -- shift enable
        add_a : out std_logic;          -- load adder output 
        d_flag : out std_logic );       -- done flag
end M_ctrl;

architecture Behavioral of M_ctrl is
-------------- SIGNAL DECLARATION ------------------
type state is (idle,        -- idle state
               init, 
               add,         -- add state
               shift,       -- shift state
               t_check);    -- correct timing
signal cs : state := idle;
signal cnt : unsigned (N-1 downto 0);
signal wait_cnt : integer := 0;      -- used for timing issues 

begin
-------------- COMBINATIONAL LOGIC --------------
d_flag <= '1' when cs = idle else '0';
ld <= '1' when cs = init else '0';
add_a <= '1' when cs = add else '0';
shft_en <= '1' when cs = shift else '0';

process(clk)
begin
    if rising_edge(clk) then
        case cs is
---------------------------------------------------------------
            when idle =>
                if st = '1' then        -- start condition
                    wait_cnt <= 1;
                    cs <= add;
                end if;
---------------------------------------------------------------
-- may not need this state
            when init =>
---------------------------------------------------------------
            when add =>
             cs <= shift;
---------------------------------------------------------------
            when shift =>
                 if cnt = 2**N-1 then
                    cs <= idle;
                 else
                    cs <= t_check;
                 end if;
---------------------------------------------------------------
            when t_check =>
                if wait_cnt < 1 then 
                    if lsb = '1' then
                        cs <= add;
                    else 
                        cs <= shift;
                    end if;
                else
                    wait_cnt <= wait_cnt - 1;
                end if;
---------------------------------------------------------------
            when others =>
        end case;
    end if;

end process;

process(clk)
begin
    if rising_edge(clk) then
        if cs = init then
            cnt <= to_unsigned(0,N);
        elsif cs = shift then
            cnt <= cnt + 1;
        end if;
    end if;

end process;

end Behavioral;
