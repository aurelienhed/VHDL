library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity affichage is
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
end entity affichage;

architecture assign of affichage is 
begin
    N1 : entity work.decodeur7 port map(data => num1, segout => output1);
    N2 : entity work.decodeur7 port map(data => num2, segout => output2);
    N3 : entity work.decodeur7 port map(data => num3, segout => output3);
    N4 : entity work.decodeur7 port map(data => num4, segout => output4);

end architecture;


