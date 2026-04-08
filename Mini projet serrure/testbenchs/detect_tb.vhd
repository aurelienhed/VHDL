library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detect_tb is
end entity detect_tb;

architecture test of detect_tb is

    component detect is
        port(
            clk : in STD_LOGIC;
            rst : in std_logic;
            KEY0 : in std_logic;
            enable : out std_logic
        );
    end component;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal KEY0 : std_logic := '0';
    signal enable : std_logic;

    constant CLK_PERIOD : time := 20 ns;

begin

    DUT : detect
        port map(
            clk => clk,
            rst => rst,
            KEY0 => KEY0,
            enable => enable
        );

    -- Clock generation
    process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Test stimulus
    process
    begin
        -- Reset
        rst <= '1';
        KEY0 <= '0';
        wait for CLK_PERIOD;
        
        -- Release reset
        rst <= '0';
        wait for CLK_PERIOD;
        
        -- Test rising edge on KEY0
        KEY0 <= '1';
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        
        -- KEY0 stays high
        wait for CLK_PERIOD;
        
        -- Falling edge
        KEY0 <= '0';
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        
        -- Another rising edge
        KEY0 <= '1';
        wait for CLK_PERIOD;
        wait for CLK_PERIOD;
        
        wait;
    end process;

end architecture test;
