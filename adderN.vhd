library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AdderN is
generic (N: integer := 10);
port( A: in std_logic_vector(N-1 downto 0); -- N bit Addend
    B: in std_logic_vector(N-1 downto 0); -- N bit Augend
    S: out std_logic_vector(N downto 0) -- N+1 bit result, includes carry
    );
end AdderN;

architecture Behavioral of AdderN is

begin

S <= std_logic_vector(('0' & UNSIGNED(A)) + UNSIGNED(B));

end Behavioral;