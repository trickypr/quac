library ieee;
use ieee.std_logic_1164.all;

entity register_16 is
  port (
    -- inputs
    d   : in std_logic_vector(15 downto 0);
    en  : in std_logic;
    clk : in std_logic;
    -- outputs
    q   : out std_logic_vector(15 downto 0)
  );
end entity register_16;

architecture rtl of register_16 is
begin
  process (d, en, clk)
  begin
    if (rising_edge(clk) and en = '1') then
      q <= d;
    end if;
  end process;
end architecture rtl;

library ieee;
use ieee.std_logic_1164.all;

entity register_file is
  port (
    rs1 : in std_logic_vector(2 downto 0);
    rs2 : in std_logic_vector(2 downto 0);
    ws  : in std_logic_vector(2 downto 0);
    we  : in bit;
    inp : in std_logic_vector(15 downto 0);
    clk : in bit;
    -- outputs
    out1 : out std_logic_vector(15 downto 0);
    out2 : out std_logic_vector(15 downto 0)
  );
end entity register_file;

architecture rtl of register_file is
  
begin
  
  
  
end architecture rtl;


