library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.all; 



entity comp4bits is 

    port(
        Datautil, Dataamd : in STD_LOGIC_VECTOR (3 downto 0);
        CompOK : out std_logic
    ); 

end entity comp4bits; 



architecture STRUCT of comp4bits is
begin
    CompOK <= '1' when Datautil = Dataamd else '0';
end architecture;  
    
