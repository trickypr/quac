library ieee;
use ieee.std_logic_1164.all;

entity reg_16 is
  port (
    -- inputs
    d   : in std_logic_vector(15 downto 0);
    en  : in std_logic;
    clk : in std_logic;
    -- outputs
    q   : out std_logic_vector(15 downto 0)
  );
end entity reg_16;

architecture rtl of reg_16 is
begin
  process (d, en, clk)
  begin
    if (rising_edge(clk) and en = '1') then
      q <= d;
    end if;
  end process;
end architecture rtl;

