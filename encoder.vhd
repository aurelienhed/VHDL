library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity encoder is
  Port (
    Y  : in  std_logic_vector(63 downto 0);
    EN : in  std_logic;
    I  : out std_logic_vector(5 downto 0);
    OK : out std_logic
  );
end encoder;

architecture Behavioral of encoder is


begin

process(Y, EN)

variable j : integer; 
variable count : integer;
variable V : unsigned(5 downto 0);
begin
  if EN = '0'then 
    OK <= '0';
    I <= (others => 'Z');
  elsif EN = '1' then
    count := 0;
    FOR j IN 0 TO 63 LOOP
    
      if Y(j) = '1' then        
          V := To_unsigned(j,6);
          count := count + 1;
      end if ;  
    
    END LOOP;
    if count = 1 then 
      OK <= '1';
      I <= Std_logic_vector(V);
    else
      OK <= '0';
      I <= (others => 'Z' );

    end if; 
  end if;

end process;

end Behavioral;