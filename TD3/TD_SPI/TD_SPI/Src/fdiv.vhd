-- FDIV.vhd
-- ---------------------------------------
--    Freq Divider for Ex3
-- ---------------------------------------
-- (c) ALSE
-- http://www.alse-fr.com
--


LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

-- ---------------------------------------
    Entity FDIV is
-- ---------------------------------------
   Generic (  Fclock  : positive := 60E6); -- System Clock Freq in Hertz
      Port (     CLK  : In    std_logic;
                 RST  : In    std_logic;
             Tick10us : Out   std_logic;
             Tick1ms  : Out   std_logic;
             Tick10ms : Out   std_logic  );
end FDIV;

-- ---------------------------------------
    Architecture RTL of FDIV is
-- ---------------------------------------

constant Divisor : positive := Fclock  / 1E5; -- we want 100 kHz ticks
signal Count     : integer range 0 to Divisor-1;
signal Count2    : integer range 0 to 99;
signal Count3    : integer range 0 to 9;
signal Tick10us_i : std_logic;
signal Tick1ms_i  : std_logic;
signal Tick10ms_i : std_logic;

--------
begin
--------


Tick10us <= Tick10us_i;
Tick1ms  <= Tick1ms_i;
Tick10ms <= Tick10ms_i;

process (RST,CLK)
begin
  if RST='1' then
    Count  <= 0;
    Count2 <= 0;
    Count3 <= 0;
    Tick10us_i <= '0';
    Tick1ms_i  <= '0';
    Tick10ms_i <= '0';

  elsif rising_edge (CLK) then

    Tick10us_i <= '0';
    Tick1ms_i  <= '0';
    Tick10ms_i <= '0';

    if Count < Divisor-1 then
      Count <= Count + 1;
    else
      Count <= 0;
      Tick10us_i <= '1';
    end if;

    if Tick10us_i = '1' then
      if Count2 < 99 then
        Count2 <= Count2 + 1;
      else
        Count2 <= 0;
        Tick1ms_i <= '1';
      end if;
    end if;
    
    if Tick1ms_i = '1' then
      if Count3 < 9 then
        Count3 <= Count3 + 1;
      else
        Count3 <= 0;
        Tick10ms_i <= '1';
      end if;
    end if;
    
  end if;
end process;

end RTL;

