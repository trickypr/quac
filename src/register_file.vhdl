library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.TO_UNSIGNED;

entity register_file is
  port (
    rs1 : in std_logic_vector(2 downto 0);
    rs2 : in std_logic_vector(2 downto 0);
    ws  : in std_logic_vector(2 downto 0);
    we  : in bit;
    inp : in std_logic_vector(15 downto 0);
    clk : in std_logic;
    -- outputs
    out1 : out std_logic_vector(15 downto 0);
    out2 : out std_logic_vector(15 downto 0)
  );
end entity register_file;

architecture rtl of register_file is
  component reg_16c
    port (
      -- inputs
      d   : in std_logic_vector(15 downto 0);
      en  : in bit;
      clk : in std_logic;
      -- outputs
      q   : out std_logic_vector(15 downto 0)
    );
  end component;

  constant zero : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(0, 16));

  for reg_1 : reg_16c use entity work.reg_16;
  for reg_2 : reg_16c use entity work.reg_16;
  for reg_3 : reg_16c use entity work.reg_16;
  for reg_4 : reg_16c use entity work.reg_16;

  signal q1, q2, q3, q4: std_logic_vector(15 downto 0); 
  signal en1, en2, en3, en4: bit;
begin
  reg_1 : reg_16c
  port map (d => inp, q => q1, en => en1, clk => clk);
  reg_2 : reg_16c
  port map (d => inp, q => q2, en => en2, clk => clk);
  reg_3 : reg_16c
  port map (d => inp, q => q3, en => en3, clk => clk);
  reg_4 : reg_16c
  port map (d => inp, q => q4, en => en4, clk => clk);
  
  process (rs1, q1, q2, q3, q4)
  begin
    case rs1 is
      when "001" => out1 <= q1;
      when "010" => out1 <= q2;
      when "011" => out1 <= q3;
      when "100" => out1 <= q4;
      when others => out1 <= zero;
    end case;
  end process;

  process (rs2, q1, q2, q3, q4)
  begin
    case rs2 is
      when "001" => out2 <= q1;
      when "010" => out2 <= q2;
      when "011" => out2 <= q3;
      when "100" => out2 <= q4;
      when others => out2 <= zero;
    end case;
  end process;

  process (we, ws, inp)
  begin
    en1 <= '0';
    en2 <= '0';
    en3 <= '0';
    en4 <= '0';

    case ws is
      when "001" => en1 <= we;
      when "010" => en2 <= we;
      when "011" => en3 <= we;
      when "100" => en4 <= we;
      when others => null;
    end case;
 end process;
end architecture rtl;


