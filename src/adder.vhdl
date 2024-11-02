entity adder is
  port (i0, i1 : in bit; ci : in bit; s : out bit; co : out bit);
end adder;

architecture rtl of adder is
begin
  -- Compute the sum
  s <= i0 xor i1 xor ci;
  -- Compute the carry
  co <= (i0 and i1) or (ci and (i0 xor i1));
end rtl;

