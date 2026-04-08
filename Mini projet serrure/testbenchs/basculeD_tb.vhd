library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity bascule_tb is
end entity;

architecture testbench of bascule_tb is
    -- Composant à tester
    component bascule is
        port ( clk : in  std_logic;
               rst : in  std_logic;
               D   : in  std_logic;
               Q   : out std_logic);
    end component;

    -- Signaux de test
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal D   : std_logic := '0';
    signal Q   : std_logic;

    -- Constante pour la période d'horloge (10 ns)
    constant CLK_PERIOD : time := 10 ns;

begin
    -- Instanciation du composant
    uut: bascule
        port map (
            clk => clk,
            rst => rst,
            D   => D,
            Q   => Q
        );

    -- Générateur d'horloge
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Processus de test
    test_process : process
    begin
        -- Test 1 : Reset initial
        report "Test 1 : Reset initial";
        rst <= '1';
        D   <= '0';
        wait for CLK_PERIOD;
        assert Q = '0' report "Erreur : Q devrait être '0' après reset" severity error;
        rst <= '0';
        wait for CLK_PERIOD;

        -- Test 2 : Charge D='0'
        report "Test 2 : Charge D='0'";
        D <= '0';
        wait for CLK_PERIOD;
        assert Q = '0' report "Erreur : Q devrait être '0'" severity error;

        -- Test 3 : Charge D='1'
        report "Test 3 : Charge D='1'";
        D <= '1';
        wait for CLK_PERIOD;
        assert Q = '1' report "Erreur : Q devrait être '1'" severity error;

        -- Test 4 : Garde D='1'
        report "Test 4 : Garde D='1'";
        wait for CLK_PERIOD;
        assert Q = '1' report "Erreur : Q devrait rester '1'" severity error;

        -- Test 5 : Retour à D='0'
        report "Test 5 : Retour à D='0'";
        D <= '0';
        wait for CLK_PERIOD;
        assert Q = '0' report "Erreur : Q devrait être '0'" severity error;

        -- Test 6 : Alternance
        report "Test 6 : Alternance";
        for i in 0 to 3 loop
            D <= std_logic(to_unsigned(i mod 2, 1)(0));
            wait for CLK_PERIOD;
            assert Q = std_logic(to_unsigned(i mod 2, 1)(0)) 
                report "Erreur : Q ne suit pas D" severity error;
        end loop;

        -- Test 7 : Reset avec D='1'
        report "Test 7 : Reset avec D='1'";
        D <= '1';
        wait for CLK_PERIOD;
        rst <= '1';
        wait for CLK_PERIOD / 2;  -- Pas d'horloge lors du reset
        assert Q = '0' report "Erreur : Q devrait être '0' avec reset" severity error;
        rst <= '0';
        wait for CLK_PERIOD;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture;
