library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.all; 



entity detect is 
port(
    clk : in STD_LOGIC; 
    rst : in std_logic; 
    KEY0 : in std_logic; 
    enable : out std_logic); 
end entity detect;

architecture behave of detect is 
signal KEY0_transition : std_logic := '0';
begin

    process(KEY0, clk, rst)
    begin

        if rst = '0' then
            enable <= '0'; 
            KEY0_transition <= '0';
        elsif RISING_EDGE(clk) then 
            KEY0_transition <= KEY0;
            enable <=  (not KEY0_transition) and KEY0; 
        end if; 
        
    end process;    
end architecture; 