library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity registre4bitsparas_tb is
end entity;

architecture testbench of registre4bitsparas_tb is
    component registre4bits is
        port (
            clk : in std_logic;
            rst_n : in std_logic;
            enable : in std_logic;
            D : in std_logic_vector(3 downto 0);
            Q : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal rst_n : std_logic := '1';
    signal enable : std_logic := '0';
    signal D : std_logic_vector(3 downto 0) := "0000";
    signal Q : std_logic_vector(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: registre4bits
        port map (
            clk => clk,
            rst_n => rst_n,
            enable => enable,
            D => D,
            Q => Q
        );

    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    test_process : process
    begin
        -- Test 1 : Reset
        report "Test 1 : Reset du registre";
        rst_n <= '0';
        enable <= '0';
        D <= "0000";
        wait for CLK_PERIOD;
        assert Q = "0000" report "Erreur : Q devrait être 0000 après reset" severity error;
        rst_n <= '1';
        wait for CLK_PERIOD;

        -- Test 2 : Registre désactivé, Q ne change pas
        report "Test 2 : Registre désactivé (enable = 0)";
        D <= "1111";
        enable <= '0';
        wait for CLK_PERIOD;
        assert Q = "0000" report "Erreur : Q devrait rester 0000 quand enable=0" severity error;

        -- Test 3 : Charge la valeur 1111
        report "Test 3 : Charge 1111";
        D <= "1111";
        enable <= '1';
        wait for CLK_PERIOD;
        assert Q = "1111" report "Erreur : Q devrait être 1111" severity error;

        -- Test 4 : Charge la valeur 1010
        report "Test 4 : Charge 1010";
        D <= "1010";
        enable <= '1';
        wait for CLK_PERIOD;
        assert Q = "1010" report "Erreur : Q devrait être 1010" severity error;

        -- Test 5 : Désactive puis charge
        report "Test 5 : Désactive (enable = 0) puis tente de charger";
        D <= "0101";
        enable <= '0';
        wait for CLK_PERIOD;
        assert Q = "1010" report "Erreur : Q devrait rester 1010 quand enable=0" severity error;

        -- Test 6 : Réactive et charge
        report "Test 6 : Réactive et charge 0101";
        enable <= '1';
        wait for CLK_PERIOD;
        assert Q = "0101" report "Erreur : Q devrait être 0101" severity error;


        -- Test 8 : Reset avec enable = 1
        report "Test 8 : Reset avec enable = 1";
        D <= "1111";
        enable <= '1';
        rst_n <= '0';
        wait for CLK_PERIOD * 2;
        assert Q = "0000" report "Erreur : Q devrait être 0000 avec reset" severity error;
        rst_n <= '1';
        wait for CLK_PERIOD;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture;
