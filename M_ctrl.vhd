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
  Port (Clk: in std_logic;      --Clock (use rising edge)
        Q0: in std_logic;       --LSB of multiplier
        Start: in std_logic;    --Algorithm start pulse
        Load: out std_logic;    --Load M,Q and Clear A
        Shift: out std_logic;   --Shift A:Q
        AddA: out std_logic;    --Load Adder output to A
        Done: out std_logic);   --Indicate end of algorithm
end M_ctrl;

architecture Behavioral of M_ctrl is
-------------- SIGNAL DECLARATION ------------------
type states is (HaltS,InitS,QtempS,AddS,ShiftS);
signal state: states := HaltS;
signal CNT: unsigned(N-1 downto 0);
begin

-- combinational logic
Done <= '1' when state = HaltS else '0'; --End of algorithm
Load <= '1' when state = InitS else '0'; --Load M/Q, Clear A
AddA<= '1' when state = AddS else '0'; --Load adder to A
Shift <= '1' when state = ShiftS else '0'; --Shift A:Q

process(clk)
begin
    if rising_edge(Clk) then
        case state is
-----------------------------------------
        when HaltS=> 
            if Start = '1' then --Start pulse applied?
                state <= InitS;--Start the algorithm
            end if;
-----------------------------------------
        when InitS=> 
            state <= QtempS; --Test Q0 at next clock**
-----------------------------------------
        when QtempS=> 
            if (Q0 = '1') then
                state <= AddS; --Add if multiplier bit = 1
            else
                state <= ShiftS; --Skip add if multiplier bit = 0
            end if;
-----------------------------------------
        when AddS=> 
            state <= ShiftS; --Shift after add
-----------------------------------------
        when ShiftS=> 
            if (CNT = 2**N -1) then
                state <= HaltS; --Halt after 2^N iterations
            else
                state <= QtempS;--Next iteration of algorithm: test Q0 **
            end if;
        end case;
    end if;
end process;

process(Clk)
begin
    if rising_edge(Clk) then
        if state = InitS then
            CNT <= to_unsigned(0,N);--Reset CNT in InitSstate
        elsif state = ShiftS then
            CNT <= CNT + 1;--Count in ShiftSstate
        end if;
    end if;
end process;

end Behavioral;
