library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity comp16bits_tb is
end entity;

architecture testbench of comp16bits_tb is
    component comp16bits is
        port(
            saisie : in STD_LOGIC_VECTOR(15 downto 0);
            code : in STD_LOGIC_VECTOR (15 downto 0);
            ouverture : out std_logic
        );
    end component;

    signal saisie : std_logic_vector(15 downto 0);
    signal code : std_logic_vector(15 downto 0);
    signal ouverture : std_logic;

begin
    uut: comp16bits
        port map (
            saisie => saisie,
            code => code,
            ouverture => ouverture
        );

    test_process : process
    begin
        -- Test 1 : Codes identiques (1234)
        report "Test 1 : Codes identiques 1234 = 1234";
        saisie <= x"1234";
        code <= x"1234";
        wait for 1 ns;
        assert ouverture = '1' report "Erreur : ouverture devrait être '1'" severity error;

        -- Test 2 : Codes identiques (ABCD)
        report "Test 2 : Codes identiques ABCD = ABCD";
        saisie <= x"ABCD";
        code <= x"ABCD";
        wait for 1 ns;
        assert ouverture = '1' report "Erreur : ouverture devrait être '1'" severity error;

        -- Test 3 : Codes identiques (0000)
        report "Test 3 : Codes identiques 0000 = 0000";
        saisie <= x"0000";
        code <= x"0000";
        wait for 1 ns;
        assert ouverture = '1' report "Erreur : ouverture devrait être '1'" severity error;

        -- Test 4 : Codes identiques (FFFF)
        report "Test 4 : Codes identiques FFFF = FFFF";
        saisie <= x"FFFF";
        code <= x"FFFF";
        wait for 1 ns;
        assert ouverture = '1' report "Erreur : ouverture devrait être '1'" severity error;

        -- Test 5 : Codes différents (1234 différent 5678)
        report "Test 5 : Codes différents 1234 différent 5678";
        saisie <= x"1234";
        code <= x"5678";
        wait for 1 ns;
        assert ouverture = '0' report "Erreur : ouverture devrait être '0'" severity error;

        -- Test 6 : Codes différents sur un nibble (1234 différent 1235)
        report "Test 6 : Codes différents sur 1 nibble 1234 différent 1235";
        saisie <= x"1234";
        code <= x"1235";
        wait for 1 ns;
        assert ouverture = '0' report "Erreur : ouverture devrait être '0'" severity error;

        -- Test 7 : Codes différents (ABCD différent 0000)
        report "Test 7 : Codes différents ABCD différent 0000";
        saisie <= x"ABCD";
        code <= x"0000";
        wait for 1 ns;
        assert ouverture = '0' report "Erreur : ouverture devrait être '0'" severity error;

        -- Test 8 : Inversion de saisie et code
        report "Test 8 : Codes identiques (inversion) 5678 = 5678";
        saisie <= x"5678";
        code <= x"5678";
        wait for 1 ns;
        assert ouverture = '1' report "Erreur : ouverture devrait être '1'" severity error;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture;
