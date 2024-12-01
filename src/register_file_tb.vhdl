library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity register_file_tb is
end entity register_file_tb;

architecture behav of register_file_tb is
  component register_file
    port (
      -- inputs
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
  end component;

  for reg_file : register_file use entity work.register_file;
    
  signal inp, out1, out2, rep : std_logic_vector(15 downto 0); 
  signal rs1, rs2, ws : std_logic_vector(2 downto 0);
  signal we: bit;
  signal clk: std_logic;
begin
  reg_file : register_file
  port map (inp => inp, out1 => out1, out2 => out2, rs1 => rs1, rs2 => rs2,
            ws => ws, we => we, clk => clk);
  
  process 
    type pattern_type is record
      -- inputs
      rs1 : std_logic_vector(2 downto 0);
      rs2 : std_logic_vector(2 downto 0);
      ws  : std_logic_vector(2 downto 0);
      we  : bit;
      inp : std_logic_vector(15 downto 0);
      -- outputs
      out1 : std_logic_vector(15 downto 0);
      out2 : std_logic_vector(15 downto 0);
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns: pattern_array :=
    (
    -- 0
    (
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#1234#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    ),
    -- 1
    (
      std_logic_vector(to_unsigned(1, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(1, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#beef#, 16)), 
      std_logic_vector(to_unsigned(16#beef#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    ),
    -- 2
    (
      std_logic_vector(to_unsigned(2, 3)), 
      std_logic_vector(to_unsigned(1, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#dead#, 16)), 
      std_logic_vector(to_unsigned(16#dead#, 16)), 
      std_logic_vector(to_unsigned(16#beef#, 16))
    ),
    -- 3
    (
      std_logic_vector(to_unsigned(3, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      std_logic_vector(to_unsigned(3, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#ffff#, 16)), 
      std_logic_vector(to_unsigned(16#ffff#, 16)), 
      std_logic_vector(to_unsigned(16#dead#, 16))
    ),
    -- 4
    (
      std_logic_vector(to_unsigned(3, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      std_logic_vector(to_unsigned(3, 3)), 
      '0', 
      std_logic_vector(to_unsigned(16#abcd#, 16)), 
      std_logic_vector(to_unsigned(16#ffff#, 16)), 
      std_logic_vector(to_unsigned(16#dead#, 16))
    ),
    -- 5
    (
      std_logic_vector(to_unsigned(3, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      '0', 
      std_logic_vector(to_unsigned(16#abcd#, 16)), 
      std_logic_vector(to_unsigned(16#ffff#, 16)), 
      std_logic_vector(to_unsigned(16#dead#, 16))
    ),
    (
      std_logic_vector(to_unsigned(1, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(1, 3)), 
      '0', 
      std_logic_vector(to_unsigned(16#abcd#, 16)), 
      std_logic_vector(to_unsigned(16#beef#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    ),
    (
      std_logic_vector(to_unsigned(1, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      '0', 
      std_logic_vector(to_unsigned(16#abcd#, 16)), 
      std_logic_vector(to_unsigned(16#beef#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    ),
    (
      std_logic_vector(to_unsigned(1, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#bade#, 16)), 
      std_logic_vector(to_unsigned(16#beef#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    ),
    (
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#bade#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16)), 
      std_logic_vector(to_unsigned(16#bade#, 16))
    ),
    (
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      '0', 
      std_logic_vector(to_unsigned(16#1234#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    ),
    (
      std_logic_vector(to_unsigned(2, 3)), 
      std_logic_vector(to_unsigned(3, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      '1', 
      std_logic_vector(to_unsigned(16#0#, 16)), 
      std_logic_vector(to_unsigned(16#bade#, 16)), 
      std_logic_vector(to_unsigned(16#ffff#, 16))
    ),
    (
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(0, 3)), 
      std_logic_vector(to_unsigned(2, 3)), 
      '0', 
      std_logic_vector(to_unsigned(16#1234#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16)), 
      std_logic_vector(to_unsigned(16#0#, 16))
    )
  );
  begin
    -- Manually initialise everything
    rs1 <= "000";
    rs2 <= "000";
    ws <= "001";
    we <= '1';
    inp <= std_logic_vector(to_unsigned(0, 16));
    clk <= '0';

    wait for 10 ps;
    clk <= '1';
    wait for 10 ps;
    clk <= '0';
    ws <= "010";
    wait for 10 ps;
    clk <= '1';
    wait for 10 ps;
    clk <= '0';
    ws <= "011";
    wait for 10 ps;
    clk <= '1';
    wait for 10 ps;
    clk <= '0';
    ws <= "100";
    wait for 10 ps;
    clk <= '1';
    wait for 10 ps;

    for i in patterns'range loop
      wait for 200 ps;
      -- set inputs
      rs1 <= patterns(i).rs1;
      rs2 <= patterns(i).rs2;
      ws  <= patterns(i).ws;
      we  <= patterns(i).we;
      inp <= patterns(i).inp;
      wait for 200 ps;
      clk <= '1';
      -- wait for propogation
      wait for 1 ns;
      clk <= '0';
      wait for 1 ns;

      assert out1 = patterns(i).out1
        report ">:( out1 behaved incorrectly";
      assert out2 = patterns(i).out2
        report ">:( out2 behaved incorrectly";

      if (out1 /= patterns(i).out1 or out2 /= patterns(i).out2) then
        rep <= std_logic_vector(to_unsigned(i, 16));
      end if;
    end loop; 

    assert false report "donw with reg_16 tests :3" severity note;
    wait;
  end process;
  
end architecture behav;
