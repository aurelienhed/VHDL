library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registre16 is
    Port ( 
        enable : in STD_LOGIC;
        reset_n : in STD_LOGIC;
        clock : in STD_LOGIC;
        input: in STD_LOGIC_VECTOR(3 downto 0);
        output : out std_logic_vector(15 downto 0));
end entity registre16;

architecture arch of registre16 is
    signal internal_0 : std_logic_vector(3 downto 0) := "0000";
    signal internal_1 : std_logic_vector(3 downto 0) := "0000";
    signal internal_2 : std_logic_vector(3 downto 0) := "0000";
    signal internal_3 : std_logic_vector(3 downto 0) := "0000"; 
begin
    registre_4bits_0 : entity work.registre4bits(REG) port map
    (
        clk => clock,
        rst_n => reset_n,
        enable => enable,
        D => input,
        Q => internal_0);

    registre_4bits_1: entity work.registre4bits(REG) port map
    (
        clk => clock,
        rst_n => reset_n,
        enable => enable,
        D => internal_0,
        Q => internal_1);

    registre_4bits_2 : entity work.registre4bits(REG) port map
    (
        clk => clock,
        rst_n => reset_n,
        enable => enable,
        D => internal_1,
        Q => internal_2);

    registre_4bits_3 : entity work.registre4bits(REG) port map
    (
        clk => clock,
        rst_n => reset_n,
        enable => enable,
        D => internal_2,
        Q => internal_3);

    -- CORRECTION ICI : Inversion de l'ordre pour respecter MSB = Premier entré
    output <= internal_3 & internal_2 & internal_1 & internal_0;

end architecture;