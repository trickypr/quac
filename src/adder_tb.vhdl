entity adder_tb is
end adder_tb;

architecture behav of adder_tb is
  component adder
    port (i0, i1 : in bit; ci : in bit; s : out bit; co : out bit);
  end component;

  -- Specify entites bound to components
  for adder_0: adder use entity work.adder;
  signal i0, i1, ci, s, co : bit;
begin
  adder_0: adder port map (i0 => i0, i1 => i1, ci => ci, s => s, co => co);
  
  process
    type pattern_type is record
      -- inputs
      i0, i1, ci : bit;
      -- outputs
      s, co : bit;
    end record;

    type pattern_array is array (natural range <>) of pattern_type;
    constant patterns: pattern_array := 
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '1', '0'));
  begin 
    for i in patterns'range loop
      -- set inputs
      i0 <= patterns(i).i0;
      i1 <= patterns(i).i1;
      ci <= patterns(i).ci;
      -- wait propigation
      wait for 1 ns;
      assert s = patterns(i).s
        report ">:( bad sum value";
      assert co = patterns(i).co
        report ">:( bad carry out";
    end loop;
    assert false report "done with adder tests :3" severity note;
    wait;
  end process;
  
end architecture behav;

