-- --------------------
--  Tornado Top Level -
-- --------------------
--
-- (c) ALSE - http://www.alse-fr.com
-- Contact : info@alse-fr.com
--
-- note : must compile in VHDL '93 or '2001 (direct instanciation)
--
-- YOU DO NOT HAVE TO MODIFY THIS FILE

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

-- -------------------------------------------------------------------------
    Entity tornado is    -- note : lower case important (for Quartus II 4.2)
-- -------------------------------------------------------------------------
  port (   Clk           : in    std_logic;
           Reset_n       : in    std_logic;  -- SW4

           ADC_D         : in    std_logic_vector (7 downto 0);
           ADC_CLK       : out   std_logic;

           SW1           : in    std_logic; -- BP(0)
           SW2           : in    std_logic; -- BP(1)
           SW3           : in    std_logic; -- BP(2)

           DIGIN         : in    std_logic_vector (3 downto 0);
           DIPSW         : in    std_logic_vector (3 downto 0);
           OC_out        : out   std_logic_vector (7 downto 0);
           RCserv        : out   std_logic_vector (3 downto 0);

           Keypad        : in    std_logic_vector (2 downto 0);
           SevSeg        : out   std_logic_vector (0 to 7);     -- a .. g, dp
           Cdisp         : out   std_logic_vector (3 downto 0);

           Sp_Bus        : inout std_logic_vector (7 downto 0); -- Spare bus 8 bits

           LED4          : out   std_logic;

           RS232_RX0     : in    std_logic;
           RS232_RX1     : in    std_logic;
           RS232_TX0     : out   std_logic;
           RS232_TX1     : out   std_logic;

           USB_nRxF      : in    std_logic;
           USB_nTxE      : in    std_logic;
           USB_nRD       : out   std_logic;
           USB_WR        : out   std_logic;
           USB_D         : inout std_logic_vector (7 downto 0);

           FPGA_KClk     : inout std_logic;
           FPGA_KData    : inout std_logic;
           FPGA_MClk     : inout std_logic;
           FPGA_MData    : inout std_logic;

           FPGA_SPI_Dout : inout std_logic;
           FPGA_uW_SIO   : inout std_logic;
           FPGA_SPI_Clk  : out   std_logic;
           FPGA_uW_nCS   : out   std_logic;

           AnRC          : out   std_logic_vector (1 downto 0);
           Spkr          : out   std_logic;

           LCD_E         : out   std_logic;
           LCD_RS        : out   std_logic;

           SCard_IO      : inout std_logic;
           SCard_nPwr    : out   std_logic;
           SCard_Clk     : out   std_logic;
           SCard_Rst     : out   std_logic
           );
end entity tornado;

-- -----------------------------------------------------------------
    Architecture RTL of tornado is
-- -----------------------------------------------------------------

  -------------------------
  -- Signals declaration --
  -------------------------

  -- Internal signals
  signal R1n      : std_logic;
  signal RST      : std_logic;
  signal Tick10us : std_logic;
  signal Tick1ms  : std_logic;
  signal Tick10ms : std_logic;
  signal SPI_OUT  : std_logic_vector(5 downto 0);
  signal SPI_DAV  : std_logic;
  signal BCD_TEN  : std_logic_vector(3 downto 0);
  signal BCD_UNIT : std_logic_vector(3 downto 0);
  signal Columns  : std_logic_vector(3 downto 0);
  signal Data     : std_logic_vector(3 downto 0);
  signal DispIdx  : unsigned        (1 downto 0);

  -- USER signals come here :


---------
begin  -- architecture
---------

-- --------------------------------
--  USER logic comes here :
-- --------------------------------

SevSeg(7) <= '1';  -- DP off on all segments



-- ==============================
-- Tornado Services, ready to use ---
-- ==============================
-- you do not need to modify anything below


-- --------------------------------
-- External Reset resynchronization
-- --------------------------------
process (CLK)
begin
  if rising_edge (CLK) then
    R1n <= Reset_n;
    RST <= not R1n;
  end if;
end process;

-- ---------------------------------
-- Frequency Divider instanciation
-- ---------------------------------
i_fdiv : entity work.fdiv
  generic map ( FCLOCK  => 60E6 )   -- 60 MHz
  port map ( CLK      => CLK,
             RST      => RST,
             Tick10us => Tick10us,
             Tick1ms  => Tick1ms,
             Tick10ms => Tick10ms );

-- ------------------------ 
-- SPI temperature sensor
-- ------------------------ 
i_SPI_TEMP : entity work.SPI_TEMP
  port map ( CLK       => CLK,      
             RST       => RST,      
             TICK10US  => TICK10US, 
             TICK10MS  => TICK10MS, 
             SPI_DATA  => FPGA_uW_SIO, 
             SPI_CLK   => FPGA_SPI_Clk,  
             SPI_nCS   => FPGA_uW_nCS,  
             DATA_OUT  => SPI_OUT, 
             DAV       => SPI_DAV  );      
                                     
-- ---------------------------------
-- Binary to BCD instanciation
-- ---------------------------------
i_BCD_Combin : entity work.bcd_combin(COMB1)
  port map ( DATA_IN  => SPI_OUT, 
             BCD_UNIT => BCD_UNIT,
             BCD_TEN  => BCD_TEN  );
             
-- --------------------------
-- Multiplexed 7-seg DISPLAY
-- --------------------------
-- Special 7-seg decoder instanciation
i_seven_seg : entity work.seven_seg
  port map ( Data   => Data,   
             Pol    => '0',   
             Segout => SevSeg(0 to 6)  );
  

Cdisp <= Columns;

-- Time multiplexing (columns scanning)
process (CLK, RST)
  variable div2 : std_logic;
begin
  if RST = '1' then
    Columns <= "1110"; -- active low
    DispIdx <= "00";
    div2    := '0';
  elsif rising_edge (Clk) then
    if Tick1ms='1' then
      if div2='0' then
        Columns <= Columns(2 downto 0) & Columns(3); -- shift left
        DispIdx <= DispIdx + 1;
      end if;
      div2 := not div2;
    end if;
  end if;
end process;

process(DispIdx, BCD_TEN, BCD_UNIT)
begin
  case to_integer(DispIdx) is
    when 0 => Data <= x"A";   -- ° displayed
    when 1 => Data <= x"C";   -- C displayed
    when 2 => Data <= BCD_UNIT;
    when 3 => Data <= BCD_TEN;
    when others => Data <= (others=>'-');
  end case;
end process;

end architecture RTL;