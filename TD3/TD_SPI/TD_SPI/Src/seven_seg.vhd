-- SevenSeg.vhd
-- ------------------------------
--   Seven Seg Encoder template
-- ------------------------------
-- (c) ALSE - http://www.alse-fr.com
--
-- Notes :
--  * We don't ask for an hexadecimal decoder, only 0..9
--  * outputs are active high if Pol='1'
--    else active low (Pol='0')
--  * Order is : Segout(1)=Seg_A, ... Segout(7)=Seg_G
--
--  * Display Layout :
--
--       A=Seg(1)
--      -----
--    F|     |B=Seg(2)
--     |  G  |
--      -----
--     |     |C=Seg(3)
--    E|     |
--      -----
--        D=Seg(4)


library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

-- ------------------------------
    Entity SEVEN_SEG is
-- ------------------------------
  port ( Data   : in  std_logic_vector(3 downto 0); -- Expected within 0 .. 9
         Pol    : in  std_logic;                    -- '0' if active LOW
         Segout : out std_logic_vector(1 to 7) );   -- Segments A, B, C, D, E, F, G
end entity SEVEN_SEG;

-- -----------------------------------------------
    Architecture COMB of SEVEN_SEG is
-- ------------------------------------------------

  signal Seg : std_logic_vector(SegOut'range);

begin

  Xrg: for i in SegOut'range generate
    SegOut(i) <= Seg(i) xor not Pol;
  end generate;


  process(Data)
  begin
    case Data is           --abcdefg 
      when  x"0"  => Seg <= "1111110";
      when  x"1"  => Seg <= "0110000";
      when  x"2"  => Seg <= "1101101";
      when  x"3"  => Seg <= "1111001";
      when  x"4"  => Seg <= "0110011";
      when  x"5"  => Seg <= "1011011";
      when  x"6"  => Seg <= "1011111";
      when  x"7"  => Seg <= "1110000";
      when  x"8"  => Seg <= "1111111";
      when  x"9"  => Seg <= "1111011";
      when  x"A"  => Seg <= "1100011";   -- °
      when  x"B"  => Seg <= "0000000";   -- blanc
      when  x"C"  => Seg <= "1001110";   -- C
      when others => Seg <= (others => '-');
    end case;
  end process;

end architecture COMB;

