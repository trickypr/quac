library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

entity alu_tb is
end alu_tb;


architecture behav of alu_tb is
  component alu is
    port ( 
      -- Inputs
      i0  : in  std_logic_vector(15 downto 0); 
      i1  : in  std_logic_vector(15 downto 0);
      sel : in  std_logic_vector(1 downto 0); -- Selector
      -- Output
      o   : out std_logic_vector(15 downto 0); -- Output
      f   : out std_logic_vector(3 downto 0) -- Flags
    );
  end component;

  -- Specify bounds
  for alu_0: alu use entity work.alu;
  signal i0, i1, o : std_logic_vector(15 downto 0);
  signal sel : std_logic_vector(1 downto 0);
  signal f : std_logic_vector(3 downto 0);
begin
  alu_0 : alu
  port map (i0 => i0, i1 => i1, o => o, sel => sel, f => f);


   
  process
    type pattern_type is record
      -- Inputs
      i0, i1 : std_logic_vector(15 downto 0);
      -- sel set by the tests
      -- Outputs
      o : std_logic_vector(15 downto 0);
    end record;
    
    type pattern_array is array (natural range <>) of pattern_type;
    constant addition_patterns: pattern_array :=
      (
        (
          std_logic_vector(to_unsigned(0, 16)), 
          std_logic_vector(to_unsigned(0, 16)), 
          std_logic_vector(to_unsigned(0, 16))
        ),
        (
          std_logic_vector(to_unsigned(1, 16)), 
          std_logic_vector(to_unsigned(1, 16)), 
          std_logic_vector(to_unsigned(2, 16))
        )
      );

    constant subtraction_patterns: pattern_array :=
      (
        (
          std_logic_vector(to_unsigned(0, 16)), 
          std_logic_vector(to_unsigned(0, 16)), 
          std_logic_vector(to_unsigned(0, 16))
        ),
        (
          std_logic_vector(to_unsigned(1, 16)), 
          std_logic_vector(to_unsigned(1, 16)), 
          std_logic_vector(to_unsigned(0, 16))
        ),
        (
          std_logic_vector(to_unsigned(1, 16)), 
          std_logic_vector(to_unsigned(3, 16)), 
          std_logic_vector(to_signed(-2, 16))
        )
      );

  begin 
    for i in addition_patterns'range loop
      -- set inputs
      i0 <= addition_patterns(i).i0;
      i1 <= addition_patterns(i).i1;
      sel <= "00";
      
      wait for 1 ns;
      assert o = addition_patterns(i).o report ">:( bad addition result";
    end loop;
    assert false report "done with addition tests" severity note;

    for i in subtraction_patterns'range loop
      -- set inputs
      i0 <= subtraction_patterns(i).i0;
      i1 <= subtraction_patterns(i).i1;
      sel <= "01";
      
      wait for 1 ns;
      assert o = subtraction_patterns(i).o report ">:( bad subtraction result";
    end loop;
    assert false report "done with subtraction tests" severity note;

    wait;
  end process;
end architecture behav;

