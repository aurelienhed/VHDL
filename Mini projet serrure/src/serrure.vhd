library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity serrure is
    Port ( 
        reset_n : in std_logic; 
        clock : in std_logic; 
        busint : in std_logic_vector(3 downto 0); --saisie du code par l'utilisateur
        KEYO1 : in std_logic; --le bouton pour rentrer le code obtenu
        affiche1 : out std_logic_vector(6 downto 0); --afficheur 1
        affiche2 : out std_logic_vector(6 downto 0); --afficheur 2    
        affiche3 : out std_logic_vector(6 downto 0); --afficheur 3
        affiche4 : out std_logic_vector(6 downto 0); --afficheur 4
        ouverture : out std_logic := '0'
    );
end entity serrure;

architecture arch of serrure is

    signal buscode : std_logic_vector(15 downto 0);
    signal codeRef : std_logic_vector(15 downto 0) := x"4321";
    signal detectcar : std_logic;

begin

    DETECTEUR : entity work.detect(behave) port map (clk => clock, rst => reset_n, KEY0 => KEYO1, enable => detectcar); 
    
    REGISTRE16BITS : entity work.registre16(arch) port map (reset_n => reset_n, enable => detectcar, input => busint, clock => clock, output => buscode);

    AFFICHEUR7SEG : entity work.affichage(assign) port map (
        num1 => buscode(3 downto 0),
        num2 => buscode(7 downto 4),
        num3 => buscode(11 downto 8),
        num4 => buscode(15 downto 12),
        output1 => affiche1,
        output2 => affiche2,
        output3 => affiche3,
        output4 => affiche4
    );

    COMPARATEUR : entity work.comp16bits(ARCH) port map(
        saisie => buscode,
        code => codeRef,
        ouverture => ouverture
    );

end architecture;