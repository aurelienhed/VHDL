library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity decodeur7 is
    port (
        data: in std_logic_vector(3 downto 0);
        segout: out std_logic_vector(6 downto 0)
    );
end entity decodeur7;

architecture COMB of decodeur7 is
begin
process(data)
begin
    case data is
        when x"0" => segout <="1111110";
        when x"1" => segout <= "0110000"; 
        when x"2" => segout <= "1101101"; 
        when x"3" => segout <= "1111001"; 
        when x"4" => segout <= "0110011"; 
        when x"5" => segout <= "1011011"; 
        when x"6" => segout <= "1011111"; 
        when x"7" => segout <= "1110000"; 
        when x"8" => segout <= "1111111"; 
        when x"9" => segout <= "1111011"; 
        when others => segout <= "0000000"; 
    end case; 
    end process; 
end architecture;


