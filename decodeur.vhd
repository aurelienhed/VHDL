-- Squelette pour l'exercice Decodeur

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.numeric_std.all;

entity decodeur is
  port (I : in  Std_logic_vector(5 downto 0);
        EN: in  Std_logic;
        Y : out Std_logic_vector(63 downto 0));
end entity;

architecture rtl of decodeur is
begin

process(I, EN)
variable V : unsigned(5 downto 0); 
begin
  if EN = '0' then 
   Y <= (others => '0');
  elsif EN = '1' then
    V := unsigned(I); 
    Y <= (others => '0');
    Y(TO_INTEGER(V)) <= '1';
  end if;
end process;
end architecture rtl;
