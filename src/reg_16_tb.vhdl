library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity reg_16_tb is
end entity reg_16_tb;

architecture behav of reg_16_tb is
  component reg_16
    port (
      d : in std_logic_vector(15 downto 0); 
      en, clk: in std_logic;
      q : out std_logic_vector(15 downto 0)
    );
  end component;

  for reg_0: reg_16 use entity work.reg_16;
  signal d, q : std_logic_vector(15 downto 0); 
  signal en, clk: std_logic;
begin
  reg_0 : reg_16
  port map (d => d, q => q, en => en, clk => clk);
  
  process 
    type pattern_type is record
      -- inputs
d : std_logic_vector(15 downto 0);
      en, clk : std_logic;
      -- outputs
      q : std_logic_vector(15 downto 0);
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns: pattern_array :=
    (
      -- Set the initial value
      (
        std_logic_vector(to_unsigned(28, 16)),
        '1', '1',
        std_logic_vector(to_unsigned(28, 16))
      ),
      (
        std_logic_vector(to_unsigned(28, 16)),
        '0', '1',
        std_logic_vector(to_unsigned(28, 16))
      ),

      -- Try enabling mid clock-cycle to see if it preserves state
      (
        std_logic_vector(to_unsigned(32, 16)),
        '0', '0',
        std_logic_vector(to_unsigned(28, 16))
      ),
      (
        std_logic_vector(to_unsigned(32, 16)),
        '0', '1',
        std_logic_vector(to_unsigned(28, 16))
      ),
      (
        std_logic_vector(to_unsigned(32, 16)),
        '1', '1',
        std_logic_vector(to_unsigned(28, 16))
      ),
      (
        std_logic_vector(to_unsigned(32, 16)),
        '1', '0',
        std_logic_vector(to_unsigned(28, 16))
      ),
      (
        std_logic_vector(to_unsigned(32, 16)),
        '0', '0',
        std_logic_vector(to_unsigned(28, 16))
      )
    );
  begin
    -- Manually initialise everything
    d <= std_logic_vector(to_unsigned(28, 16));
    en <= '1';
    clk <= '0';
    wait for 1 ns;

    for i in patterns'range loop
      -- set inputs
      d <= patterns(i).d;
      en <= patterns(i).en;
      clk <= patterns(i).clk;
      -- wait for propogation
      wait for 1 ns;
      assert q = patterns(i).q
        report ">:( reg_16 behaved incorrectly";
    end loop; 

    assert false report "donw with reg_16 tests :3" severity note;
    wait;
  end process;
  
end architecture behav;
