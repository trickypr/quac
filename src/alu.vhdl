library ieee;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED."+";
use ieee.STD_LOGIC_UNSIGNED."-";

entity alu is
  port ( 
    -- Inputs
    i0  : in  std_logic_vector(15 downto 0); 
    i1  : in  std_logic_vector(15 downto 0);
    sel : in  std_logic_vector(1 downto 0); -- Selector
-- Output
    o   : out std_logic_vector(15 downto 0); -- Output
    f   : out std_logic_vector(3 downto 0) -- Flags
  );
end alu;

architecture rtl of alu is
begin
  -- The signals are defined as
  -- 00 : ADD
  -- 01 : SUB
  -- 10 : AND
  -- 11 : XOR

  process (i0, i1, sel)
  begin
    case (sel) is
      when "00" => o <= i0 + i1;
      when "01" => o <= i0 - i1;
      when others => o <= i0 + i1;
    end case;
  end process;
end architecture rtl;

