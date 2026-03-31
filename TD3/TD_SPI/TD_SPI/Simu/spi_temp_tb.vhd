-- SPI_TEMP.vhd
-- ----------------------------------------------
--   SPI Interface for LM70 Temperature Sensor
-- ----------------------------------------------
-- (c) ALSE
-- http://www.alse-fr.com
-- Author : E. Laurendeau
--
--

  use STD.textio.all;
library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;
  use IEEE.std_logic_textio.all;

-- --------------------
    Entity SPI_TEMP_tb is
-- --------------------
end entity SPI_TEMP_tb;



-- ---------------------------------
    Architecture Bench of SPI_TEMP_tb is
-- ---------------------------------

  constant Period : time := 20 ns;  

  -------------------------
  -- Signals declaration --
  -------------------------
  signal CLK      : std_logic := '0';
  signal RST      : std_logic;
  signal Tick10us : std_logic := '0';
  signal Tick10ms : std_logic := '0';
  signal SPI_DATA : std_logic;
  signal SPI_CLK  : std_logic;
  signal SPI_nCS  : std_logic;
  signal DATA_OUT : std_logic_vector(5 downto 0); 
  signal DAV      : std_logic; 
  signal Done     : boolean; 



---------
begin
---------

  -- System Inputs
  CLK <= '0' when Done else not CLK after Period / 2;
  RST <= '1', '0' after Period;
  Tick10us <= '0' when Done else not Tick10us after 10 us - Period, Tick10us after 10 us;
  Tick10ms <= '0' when Done else not Tick10ms after 1 ms - Period, Tick10ms after 1 ms;

  -- -------
  --   UUT
  -- -------
  UUT : entity work.spi_temp 
    port map ( CLK      => CLK,     
               RST      => RST,     
               Tick10us => Tick10us,
               Tick10ms => Tick10ms,
               SPI_DATA => SPI_DATA,
               SPI_CLK  => SPI_CLK,
               SPI_nCS  => SPI_nCS,
               DATA_OUT => DATA_OUT,
               DAV      => DAV      );
    

  -- -----------------------
  --   uWire
  -- -----------------------
  process
    variable Temp : unsigned (0 to 15) := "0000011110000000"; -- 15°C
    variable i : integer range 0 to 16;
    variable L : line;
  begin
    while now < 50 ms loop
    SPI_DATA <= '0';
    wait until SPI_nCS='0';
    i := 0;
    SPI_DATA <= Temp(i);
    while SPI_nCS='0' loop
      wait until SPI_CLK='0' or SPI_nCS='1';
      if SPI_nCS='1' then exit; end if;
      i := i + 1;
      SPI_DATA <= Temp(i);
    end loop;
    wait until rising_edge(CLK) and DAV = '1';
    if unsigned(DATA_OUT) /= Temp(3 to 8) then
      write(L, lf & "Expected Output is ");
      write(L, to_integer(Temp(3 to 8)));
      write(L, "°C" & lf);
      write(L, string'("Actual Output is "));
      write(L, to_integer(unsigned(DATA_OUT)));
      write(L, "°C" & lf);
      writeline (output, L);
      report "Output wrong !!!" severity failure;
    end if;
    Temp := Temp + 384; -- (+ 3)
    end loop;
    DONE <= true;
    report "OK Finished checking Temperature Sensor. No Error Detected" severity note;
    wait;
  end process;


end architecture Bench;
