-- BCD_COMBIN.vhd
-- ----------------------------
--  conversion Binaire -> BCD  --
-- ----------------------------
--

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;


--------------------
entity BCD_COMBIN is
--------------------
  port (   DATA_IN  : in  std_logic_vector(5 downto 0);  -- L'entrée binaire
           BCD_UNIT : out std_logic_vector(3 downto 0);  -- unité BCD 
           BCD_TEN  : out std_logic_vector(3 downto 0)   -- dizaine BCD 
           );
end entity BCD_COMBIN;


------------------------------------
-- convertisseur binaire --> BCD avec table de transcodage
------------------------------------
architecture COMB1 of BCD_COMBIN is
------------------------------------

---------
begin
---------

  process
  begin
    case

    end case;
  end process;

end architecture COMB1;


------------------------------------
-- convertisseur binaire --> BCD avec algorithme de conversion
------------------------------------
architecture COMB2 of BCD_COMBIN is
------------------------------------

---------
begin
---------
end architecture COMB2;