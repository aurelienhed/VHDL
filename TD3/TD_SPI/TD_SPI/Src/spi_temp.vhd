-- SPI_TEMP.vhd - Tornado Education Kit - Template file
-- --------------------------------------------
--  SPI INterface for LM70 Temperature Sensor
-- --------------------------------------------
--
--

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

-- ---------------------
    Entity SPI_TEMP is
-- ---------------------
  port (   CLK      : in    std_logic;    -- 60 MHz
           RST      : in    std_logic;    -- Reset
           Tick10us : in    std_logic;    -- Tick 10 us
           Tick10ms : in    std_logic;    -- Tick 10 ms
           SPI_DATA : inout std_logic;    -- SPI data
           SPI_CLK  : out   std_logic;    -- SPI clock
           SPI_nCS  : out   std_logic;    -- SPI chip Select (active low)
           DATA_OUT : out   std_logic_vector(5 downto 0); -- Data Out
           DAV      : out   std_logic     -- Data Valid
           );
end entity SPI_TEMP;


-- ---------------------------------
    Architecture RTL of SPI_TEMP is
-- ---------------------------------


begin


end architecture RTL;
