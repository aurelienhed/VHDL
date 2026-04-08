library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity comp4bits_tb is
end entity comp4bits_tb;

architecture testbench of comp4bits_tb is
    component comp4bits is
        port(
            Datautil, Dataamd : in STD_LOGIC_VECTOR (3 downto 0);
            CompOK : out std_logic
        );
    end component comp4bits;

    signal Datautil : std_logic_vector(3 downto 0);
    signal Dataamd : std_logic_vector(3 downto 0);
    signal CompOK : std_logic;

begin
    uut: comp4bits
        port map (
            Datautil => Datautil,
            Dataamd => Dataamd,
            CompOK => CompOK
        );

    test_process : process
    begin
        -- Test 1 : Valeurs identiques (0000)
        report "Test 1 : Comparaison 0000 = 0000";
        Datautil <= "0000";
        Dataamd <= "0000";
        wait for 1 ns;
        assert CompOK = '1' report "Erreur : CompOK devrait être '1'" severity error;

        -- Test 2 : Valeurs identiques (1111)
        report "Test 2 : Comparaison 1111 = 1111";
        Datautil <= "1111";
        Dataamd <= "1111";
        wait for 1 ns;
        assert CompOK = '1' report "Erreur : CompOK devrait être '1'" severity error;

        -- Test 3 : Valeurs identiques (1010)
        report "Test 3 : Comparaison 1010 = 1010";
        Datautil <= "1010";
        Dataamd <= "1010";
        wait for 1 ns;
        assert CompOK = '1' report "Erreur : CompOK devrait être '1'" severity error;

        -- Test 4 : Valeurs différentes (0001 ≠ 0000)
        report "Test 4 : Comparaison 0001 différent 0000";
        Datautil <= "0001";
        Dataamd <= "0000";
        wait for 1 ns;
        assert CompOK = '0' report "Erreur : CompOK devrait être '0'" severity error;

        -- Test 5 : Valeurs différentes (1111 ≠ 0000)
        report "Test 5 : Comparaison 1111 différent 0000";
        Datautil <= "1111";
        Dataamd <= "0000";
        wait for 1 ns;
        assert CompOK = '0' report "Erreur : CompOK devrait être '0'" severity error;

        -- Test 6 : Valeurs différentes (1010 ≠ 0101)
        report "Test 6 : Comparaison 1010 différent 0101";
        Datautil <= "1010";
        Dataamd <= "0101";
        wait for 1 ns;
        assert CompOK = '0' report "Erreur : CompOK devrait être '0'" severity error;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture testbench;
