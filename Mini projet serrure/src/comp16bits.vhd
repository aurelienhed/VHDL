library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.all; 


entity comp16bits is 

    port(
        saisie : in STD_LOGIC_VECTOR(15 downto 0);
        code : in STD_LOGIC_VECTOR (15 downto 0);
        ouverture : out std_logic
    ); 

end entity comp16bits; 


architecture ARCH of comp16bits is
    signal output : STD_LOGIC_VECTOR(3 downto 0);
begin 
    
    comparateur1 : entity work.comp4bits port map(Datautil => saisie(3 downto 0), Dataamd => code(3 downto 0), CompOK => output(0));
    comparateur2 : entity work.comp4bits port map(Datautil => saisie(7 downto 4), Dataamd => code(7 downto 4), CompOK => output(1));
    comparateur3 : entity work.comp4bits port map(Datautil => saisie(11 downto 8), Dataamd => code(11 downto 8), CompOK => output(2));
    comparateur4 : entity work.comp4bits port map(Datautil => saisie(15 downto 12), Dataamd => code(15 downto 12), CompOK => output(3));

    ouverture <= '1' when output = "1111" else '0'; 
end architecture;  
    
