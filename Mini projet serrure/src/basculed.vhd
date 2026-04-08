library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.all; 


entity bascule is
    port ( clk     : in  std_logic;
           rst     : in  std_logic;
           D       : in  std_logic;
           Q       : out std_logic);
end entity bascule;

architecture yo of bascule is 
begin
    process(clk, rst)
    begin
        if rst = '1' then
            Q <= '0';
        elsif rising_edge(clk) then
            Q <= D;
        end if;
    end process; 
end architecture;