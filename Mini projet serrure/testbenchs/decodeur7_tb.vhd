library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity decodeur7_tb is
end entity;

architecture testbench of decodeur7_tb is
    component decodeur7 is
        port (
            data: in std_logic_vector(3 downto 0);
            segout: out std_logic_vector(6 downto 0)
        );
    end component;

    signal data : std_logic_vector(3 downto 0);
    signal segout : std_logic_vector(6 downto 0);

begin
    uut: decodeur7
        port map (
            data => data,
            segout => segout
        );

    test_process : process
    begin
        -- Test 0 : Affichage de 0
        report "Test 0 : Décodage du chiffre 0";
        data <= x"0";
        wait for 1 ns;
        assert segout = "1111110" report "Erreur : Code 7-seg pour 0 incorrect" severity error;

        -- Test 1 : Affichage de 1
        report "Test 1 : Décodage du chiffre 1";
        data <= x"1";
        wait for 1 ns;
        assert segout = "0110000" report "Erreur : Code 7-seg pour 1 incorrect" severity error;

        -- Test 2 : Affichage de 2
        report "Test 2 : Décodage du chiffre 2";
        data <= x"2";
        wait for 1 ns;
        assert segout = "1101101" report "Erreur : Code 7-seg pour 2 incorrect" severity error;

        -- Test 3 : Affichage de 3
        report "Test 3 : Décodage du chiffre 3";
        data <= x"3";
        wait for 1 ns;
        assert segout = "1111001" report "Erreur : Code 7-seg pour 3 incorrect" severity error;

        -- Test 4 : Affichage de 4
        report "Test 4 : Décodage du chiffre 4";
        data <= x"4";
        wait for 1 ns;
        assert segout = "0110011" report "Erreur : Code 7-seg pour 4 incorrect" severity error;

        -- Test 5 : Affichage de 5
        report "Test 5 : Décodage du chiffre 5";
        data <= x"5";
        wait for 1 ns;
        assert segout = "1011011" report "Erreur : Code 7-seg pour 5 incorrect" severity error;

        -- Test 6 : Affichage de 6
        report "Test 6 : Décodage du chiffre 6";
        data <= x"6";
        wait for 1 ns;
        assert segout = "1011111" report "Erreur : Code 7-seg pour 6 incorrect" severity error;

        -- Test 7 : Affichage de 7
        report "Test 7 : Décodage du chiffre 7";
        data <= x"7";
        wait for 1 ns;
        assert segout = "1110000" report "Erreur : Code 7-seg pour 7 incorrect" severity error;

        -- Test 8 : Affichage de 8
        report "Test 8 : Décodage du chiffre 8";
        data <= x"8";
        wait for 1 ns;
        assert segout = "1111111" report "Erreur : Code 7-seg pour 8 incorrect" severity error;

        -- Test 9 : Affichage de 9
        report "Test 9 : Décodage du chiffre 9";
        data <= x"9";
        wait for 1 ns;
        assert segout = "1111011" report "Erreur : Code 7-seg pour 9 incorrect" severity error;

        -- Test valeur invalide
        report "Test invalide : Décodage de A (invalide)";
        data <= x"A";
        wait for 1 ns;
        assert segout = "0000000" report "Erreur : Code 7-seg pour valeur invalide doit être 0" severity error;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture;
