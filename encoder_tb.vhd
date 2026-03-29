library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity encoder_tb is
end encoder_tb;

architecture Behavioral of encoder_tb is

  signal Y  : std_logic_vector(63 downto 0);
  signal EN : std_logic;
  signal I  : std_logic_vector(5 downto 0);
  signal OK : std_logic;

  component encoder
    Port (
      Y  : in  std_logic_vector(63 downto 0);
      EN : in  std_logic;
      I  : out std_logic_vector(5 downto 0);
      OK : out std_logic
    );
  end component;

begin

  UUT: encoder
    port map (
      Y  => Y,
      EN => EN,
      I  => I,
      OK => OK
    );

  stimulus: process
  begin
    -- Cas 1 : bit 0 actif
    Y <= (others => '0'); Y(0) <= '1'; EN <= '1';
    wait for 10 ns;
    assert (I = "000000" and OK = '1')
      report "Erreur sur le cas 0" severity error;

    -- Cas 2 : bit 42 actif
    Y <= (others => '0'); Y(42) <= '1'; EN <= '1';
    wait for 10 ns;
    assert (I = std_logic_vector(to_unsigned(42, 6)) and OK = '1')
      report "Erreur sur le cas 42" severity error;

    -- Cas 3 : bit 63 actif
    Y <= (others => '0'); Y(63) <= '1'; EN <= '1';
    wait for 10 ns;
    assert (I = "111111" and OK = '1')
      report "Erreur sur le cas 63" severity error;

    -- Cas 4 : plusieurs bits actifs
    Y <= (others => '0'); Y(3) <= '1'; Y(10) <= '1'; EN <= '1';
    wait for 10 ns;
    assert (OK = '0')
      report "Erreur sur le cas multiple bits actifs" severity error;

    -- Cas 5 : aucun bit actif
    Y <= (others => '0'); EN <= '1';
    wait for 10 ns;
    assert (OK = '0')
      report "Erreur sur le cas aucun bit actif" severity error;

    -- Cas 6 : EN désactivé
    Y <= (others => '0'); Y(15) <= '1'; EN <= '0';
    wait for 10 ns;
    assert (OK = '0')
      report "Erreur sur le cas EN = 0" severity error;

    report "Tous les tests sont passés avec succès !" severity note;
    wait;
  end process;

end Behavioral;