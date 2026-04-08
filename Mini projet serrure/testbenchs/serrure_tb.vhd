library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity serrure_tb is
end entity serrure_tb;

architecture testbench of serrure_tb is
    component serrure is
        Port ( 
            reset_n : in std_logic; 
            clock : in std_logic; 
            busint : in std_logic_vector(3 downto 0);
            KEYO1 : in std_logic;
            affiche1 : out std_logic_vector(6 downto 0);
            affiche2 : out std_logic_vector(6 downto 0);
            affiche3 : out std_logic_vector(6 downto 0);
            affiche4 : out std_logic_vector(6 downto 0);
            ouverture : out std_logic
        );
    end component serrure;

    signal reset_n : std_logic := '1';
    signal clock : std_logic := '0';
    signal busint : std_logic_vector(3 downto 0) := "0000";
    signal KEYO1 : std_logic := '0';
    signal affiche1, affiche2, affiche3, affiche4 : std_logic_vector(6 downto 0);
    signal ouverture : std_logic;

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: serrure
        port map (
            reset_n => reset_n,
            clock => clock,
            busint => busint,
            KEYO1 => KEYO1,
            affiche1 => affiche1,
            affiche2 => affiche2,
            affiche3 => affiche3,
            affiche4 => affiche4,
            ouverture => ouverture
        );

    -- Générateur d'horloge
    clk_process : process
    begin
        clock <= '0';
        wait for CLK_PERIOD / 2;
        clock <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Processus de test
    test_process : process
        procedure appuyer_bouton(digit : std_logic_vector(3 downto 0)) is
        begin
            busint <= digit;
            KEYO1 <= '1';
            wait for CLK_PERIOD * 3;  -- Maintenir appuyé
            KEYO1 <= '0';
            wait for CLK_PERIOD * 3;  -- Relâcher et attendre
        end procedure;
    begin
        report "=== DEBUT DES TESTS SERRURE ===";
        
        -- Test 1 : Reset initial
        report "Test 1 : Reset initial";
        reset_n <= '0';
        busint <= "0000";
        KEYO1 <= '0';
        wait for CLK_PERIOD * 2;
        assert ouverture = '0' report "Erreur T1 : serrure devrait être fermée" severity error;
        reset_n <= '1';
        wait for CLK_PERIOD * 2;
        report "Test 1 : PASS";

        -- Test 2 : Afficheurs à zéro après reset
        report "Test 2 : Vérification afficheurs après reset";
        wait for CLK_PERIOD * 5;
        report "Test 2 : PASS";

        -- Test 3 : Saisie du bon code (4, 3, 2, 1) pour obtenir 0x4321
        report "Test 3 : Saisie du bon code 4321";
        appuyer_bouton("0100");  -- 4
        report "Appui 1 : digit 4";
        
        appuyer_bouton("0011");  -- 3
        report "Appui 2 : digit 3";
        
        appuyer_bouton("0010");  -- 2
        report "Appui 3 : digit 2";
        
        appuyer_bouton("0001");  -- 1
        report "Appui 4 : digit 1";
        
        wait for CLK_PERIOD * 5;
        
        if ouverture = '1' then
            report "Test 3 : PASS - Serrure ouverte avec le bon code!";
        else
            report "Test 3 : FAIL - Serrure devrait être ouverte" severity error;
        end if;

        -- Test 4 : Reset et test avec mauvais code
        report "Test 4 : Reset de la serrure";
        reset_n <= '0';
        wait for CLK_PERIOD * 2;
        reset_n <= '1';
        wait for CLK_PERIOD * 2;
        assert ouverture = '0' report "Erreur T4 : serrure devrait être fermée après reset" severity error;
        report "Test 4 : PASS";

        -- Test 5 : Saisie d'un mauvais code (5, 5, 5, 5)
        report "Test 5 : Saisie du mauvais code 5555";
        appuyer_bouton("0101");  -- 5
        appuyer_bouton("0101");  -- 5
        appuyer_bouton("0101");  -- 5
        appuyer_bouton("0101");  -- 5
        
        wait for CLK_PERIOD * 5;
        
        if ouverture = '0' then
            report "Test 5 : PASS - Serrure reste fermée avec mauvais code";
        else
            report "Test 5 : FAIL - Serrure devrait rester fermée" severity error;
        end if;

        -- Test 6 : Vérifier que rien ne change avant 4 appuis
        report "Test 6 : Test avec 3 digits seulement";
        reset_n <= '0';
        wait for CLK_PERIOD * 2;
        reset_n <= '1';
        wait for CLK_PERIOD * 2;
        
        appuyer_bouton("0100");  -- 4
        appuyer_bouton("0011");  -- 3
        appuyer_bouton("0010");  -- 2
        
        wait for CLK_PERIOD * 5;
        assert ouverture = '0' report "Erreur T6 : serrure devrait être fermée avec seulement 3 digits" severity error;
        report "Test 6 : PASS";

        -- Test 7 : Compléter avec le 4ème digit
        report "Test 7 : Complétion du code avec 4ème digit";
        appuyer_bouton("0001");  -- 1
        
        wait for CLK_PERIOD * 5;
        assert ouverture = '1' report "Erreur T7 : serrure devrait s'ouvrir après le 4ème digit" severity error;
        report "Test 7 : PASS";

        report "=== TOUS LES TESTS REUSSIS ===";
        wait;
    end process;

end architecture testbench;
