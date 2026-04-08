library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity affichagex4_tb is
end entity;

architecture testbench of affichagex4_tb is
    component affichage is
        port (
            num1 : in std_logic_vector(3 downto 0);
            num2 : in std_logic_vector(3 downto 0);
            num3 : in std_logic_vector(3 downto 0);
            num4 : in std_logic_vector(3 downto 0);
            output1 : out std_logic_vector(6 downto 0);
            output2 : out std_logic_vector(6 downto 0);
            output3 : out std_logic_vector(6 downto 0);
            output4 : out std_logic_vector(6 downto 0)
        );
    end component;

    signal num1, num2, num3, num4 : std_logic_vector(3 downto 0);
    signal output1, output2, output3, output4 : std_logic_vector(6 downto 0);

begin
    uut: affichage
        port map (
            num1 => num1,
            num2 => num2,
            num3 => num3,
            num4 => num4,
            output1 => output1,
            output2 => output2,
            output3 => output3,
            output4 => output4
        );

    test_process : process
    begin
        -- Test 1 : Affichage de 0000
        report "Test 1 : Affichage de 0000";
        num1 <= x"0";
        num2 <= x"0";
        num3 <= x"0";
        num4 <= x"0";
        wait for 1 ns;
        assert output1 = "1111110" report "Erreur : output1 devrait afficher 0" severity error;
        assert output2 = "1111110" report "Erreur : output2 devrait afficher 0" severity error;
        assert output3 = "1111110" report "Erreur : output3 devrait afficher 0" severity error;
        assert output4 = "1111110" report "Erreur : output4 devrait afficher 0" severity error;

        -- Test 2 : Affichage de 1234
        report "Test 2 : Affichage de 1234";
        num1 <= x"1";
        num2 <= x"2";
        num3 <= x"3";
        num4 <= x"4";
        wait for 1 ns;
        assert output1 = "0110000" report "Erreur : output1 devrait afficher 1" severity error;
        assert output2 = "1101101" report "Erreur : output2 devrait afficher 2" severity error;
        assert output3 = "1111001" report "Erreur : output3 devrait afficher 3" severity error;
        assert output4 = "0110011" report "Erreur : output4 devrait afficher 4" severity error;

        -- Test 3 : Affichage de 5678
        report "Test 3 : Affichage de 5678";
        num1 <= x"5";
        num2 <= x"6";
        num3 <= x"7";
        num4 <= x"8";
        wait for 1 ns;
        assert output1 = "1011011" report "Erreur : output1 devrait afficher 5" severity error;
        assert output2 = "1011111" report "Erreur : output2 devrait afficher 6" severity error;
        assert output3 = "1110000" report "Erreur : output3 devrait afficher 7" severity error;
        assert output4 = "1111111" report "Erreur : output4 devrait afficher 8" severity error;

        -- Test 4 : Affichage de 9999
        report "Test 4 : Affichage de 9999";
        num1 <= x"9";
        num2 <= x"9";
        num3 <= x"9";
        num4 <= x"9";
        wait for 1 ns;
        assert output1 = "1111011" report "Erreur : output1 devrait afficher 9" severity error;
        assert output2 = "1111011" report "Erreur : output2 devrait afficher 9" severity error;
        assert output3 = "1111011" report "Erreur : output3 devrait afficher 9" severity error;
        assert output4 = "1111011" report "Erreur : output4 devrait afficher 9" severity error;

        -- Test 5 : Affichage mixte ABCD
        report "Test 5 : Affichage mixte ABCD (valeurs invalides)";
        num1 <= x"A";
        num2 <= x"B";
        num3 <= x"C";
        num4 <= x"D";
        wait for 1 ns;
        assert output1 = "0000000" report "Erreur : output1 devrait être 0000000 pour valeur invalide" severity error;
        assert output2 = "0000000" report "Erreur : output2 devrait être 0000000 pour valeur invalide" severity error;
        assert output3 = "0000000" report "Erreur : output3 devrait être 0000000 pour valeur invalide" severity error;
        assert output4 = "0000000" report "Erreur : output4 devrait être 0000000 pour valeur invalide" severity error;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture;
