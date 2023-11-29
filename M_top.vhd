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
    Port (Multiplier: in std_logic_vector(3 downto 0);
        Multiplicand: in std_logic_vector(3 downto 0);
        Product: out std_logic_vector(7 downto 0);
        Start: in std_logic;
        Clk: in std_logic;
        Done: out std_logic);
end M_top;

architecture Behavioral of M_top is
--use work.mult_components.all;

----------- SIGNAL DECLARATION ---------------
signal Mout,Qout: std_logic_vector(3 downto 0);
signal Dout,Aout: std_logic_vector(4 downto 0);
signal Load,Shift,AddA: std_logic;


component M_ctrl --Multiplier controller
generic (N: integer := 2);
port ( Clk:in std_logic;--rising edge clock
        Q0:in std_logic;--LSB of multiplier
        Start: in std_logic;--start algorithm
        Load:out std_logic; --Load M,Q; Clear A
        Shift: out std_logic; --Shift A:Q
        AddA: out std_logic; --Adder -> A
        Done: out std_logic);--Algorithm completed
end component;
component adderN--N-bit adder, N+1 bit output
generic (N: integer := 4);
port( A,B: in std_logic_vector(N-1 downto 0);
        S: out std_logic_vector(N downto 0));
end component;
component M_Reg--N-bit register with load/shift/clear
generic (N: integer := 4);
port ( Din: in std_logic_vector(N-1 downto 0); --N-bit input
        Dout: out std_logic_vector(N-1 downto 0); --N-bit output
        Clk: in std_logic;--rising edge clock
        Load: in std_logic;--Load enable
        Shift: in std_logic; --Shift enable
        Clear: in std_logic;--Clear enable
        SerIn: in std_logic);--Serial input
end component;

begin

C: M_ctrl generic map (2)--Controller with 2-bit counter
port map (Clk => Clk,
          Q0 => Qout(0),
          Start => Start,
          Load => Load,
          Shift => Shift,
          AddA => AddA,
          Done => Done);
A: adderN generic map (4)--4-bit adder; 5-bit output includes carry
port map (A => Aout(3 downto 0),
          B => Mout,
          S => Dout);
M: M_Reg generic map (4)--4-bit Multiplicand register
port map (Din => Multiplicand,
          Dout => Mout,
          Clk => Clk,
          Load => Load,
          Shift => '0',
          Clear => '0',
          SerIn => '0');
Q: M_Reg generic map (4)--4-bit Multiplier register
port map (Din => Multiplier,
          Dout => Qout,
          Clk => Clk,
          Load => Load,
          Shift => Shift,
          Clear => '0',
          SerIn => Aout(0));
ACC: M_Reg generic map (5)--5-bit Accumulator register
port map (Din => Dout,
          Dout => Aout,
          Clk => Clk,
          Load => AddA,
          Shift => Shift,
          Clear => Load,
          SerIn => '0');
Product <= Aout(3 downto 0) & Qout; --8-bit product

end Behavioral;
