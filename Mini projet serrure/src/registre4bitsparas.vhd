library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity registre4bits is
    port (
        clk : in std_logic;
        rst_n : in std_logic;
        enable : in std_logic;
        D : in std_logic_vector(3 downto 0);
        Q : out std_logic_vector(3 downto 0)
    );
end entity registre4bits;

architecture REG of registre4bits is 
begin
    process(clk, rst_n)
    begin
    if rst_n = '0' then
        Q <= "0000";
    elsif rising_edge(clk) then
        if enable = '1' then
            Q <= D;
        end if;
    end if;
    end process;
end architecture REG;



-- ECRIRE LE CODE AVEC BASCULE D SI LE TEMPS


