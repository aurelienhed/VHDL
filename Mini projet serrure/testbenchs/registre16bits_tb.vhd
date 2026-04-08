library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity registre16bits_tb is
end entity;

architecture testbench of registre16bits_tb is
    component registre16 is
        Port ( 
            enable : in STD_LOGIC;
            reset_n : in STD_LOGIC;
            clock : in STD_LOGIC;
            input: in STD_LOGIC_VECTOR(3 downto 0);
            output : out std_logic_vector(15 downto 0));
    end component;

    signal enable : std_logic := '0';
    signal reset_n : std_logic := '1';
    signal clock : std_logic := '0';
    signal input : std_logic_vector(3 downto 0) := "0000";
    signal output : std_logic_vector(15 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: registre16
        port map (
            enable => enable,
            reset_n => reset_n,
            clock => clock,
            input => input,
            output => output
        );

    clk_process : process
    begin
        clock <= '0';
        wait for CLK_PERIOD / 2;
        clock <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    test_process : process
    begin
        -- Test 1 : Reset
        report "Test 1 : Reset du registre 16 bits";
        reset_n <= '0';
        enable <= '0';
        input <= "0000";
        wait for CLK_PERIOD;
        assert output = x"0000" report "Erreur : output devrait être 0000 après reset" severity error;
        reset_n <= '1';
        wait for CLK_PERIOD;

        -- Test 2 : Chargement de 4 valeurs avec décalage
        report "Test 2 : Chargement de 4 valeurs (1, 2, 3, 4)";
        enable <= '1';
        
        -- Charge 1
        input <= "0001";
        wait for CLK_PERIOD;
        assert output(3 downto 0) = "0001" report "Erreur : Premiers 4 bits = 0001" severity error;
        
        -- Charge 2
        input <= "0010";
        wait for CLK_PERIOD;
        assert output(7 downto 0) = "00100001" report "Erreur : Premiers 8 bits = 00100001" severity error;
        
        -- Charge 3
        input <= "0011";
        wait for CLK_PERIOD;
        assert output(11 downto 0) = "001100100001" report "Erreur : Premiers 12 bits = 001100100001" severity error;
        
        -- Charge 4
        input <= "0100";
        wait for CLK_PERIOD;
        assert output = x"4321" report "Erreur : output devrait être 4321" severity error;

        -- Test 3 : Désactivation du registre
        report "Test 3 : Désactivation (enable = 0)";
        enable <= '0';
        input <= "1111";
        wait for CLK_PERIOD;
        assert output = x"4321" report "Erreur : output devrait rester 4321 quand enable=0" severity error;

        -- Test 4 : Réactivation
        report "Test 4 : Réactivation et chargement";
        enable <= '1';
        input <= "1111";
        wait for CLK_PERIOD;
        assert output(3 downto 0) = "1111" report "Erreur : Premiers 4 bits devraient être 1111" severity error;

        -- Test 5 : Reset avec enable = 1
        report "Test 5 : Reset avec enable = 1";
        enable <= '1';
        input <= "1010";
        reset_n <= '0';
        wait for CLK_PERIOD / 2;
        assert output = x"0000" report "Erreur : output devrait être 0000 avec reset" severity error;
        reset_n <= '1';
        wait for CLK_PERIOD;

        report "Tests terminés avec succès!";
        wait;
    end process;

end architecture;
