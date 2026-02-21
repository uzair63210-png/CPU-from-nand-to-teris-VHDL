-- created by uzair shaikh 
-- for any question contact on tech_emerged on intagram..

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_BUS_1 is
  generic ( Bits : integer ); 
  port (
    p_out: out std_logic_vector ((Bits-1) downto 0);
    sel: in std_logic;
    
    in_0: in std_logic_vector ((Bits-1) downto 0);
    in_1: in std_logic_vector ((Bits-1) downto 0) );
end MUX_GATE_BUS_1;

architecture Behavioral of MUX_GATE_BUS_1 is
begin
  with sel select
    p_out <=
      in_0 when '0',
      in_1 when '1',
      (others => '0') when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity DIG_Add is
  generic ( Bits: integer ); 
  port (
    s: out std_logic_vector((Bits-1) downto 0);
    c_o: out std_logic;
    a: in std_logic_vector((Bits-1) downto 0);
    b: in std_logic_vector((Bits-1) downto 0);
    c_i: in std_logic );
end DIG_Add;

architecture Behavioral of DIG_Add is
   signal temp : std_logic_vector(Bits downto 0);
begin
   temp <= ('0' & a) + b + c_i;

   s    <= temp((Bits-1) downto 0);
   c_o  <= temp(Bits);
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
entity COMP_GATE_SIGNED is
  generic ( Bits : integer );
  port (
    gr: out std_logic;
    eq: out std_logic;
    le: out std_logic;
    a: in std_logic_vector ((Bits-1) downto 0);
    b: in std_logic_vector ((Bits-1) downto 0) );
end COMP_GATE_SIGNED;

architecture Behavioral of COMP_GATE_SIGNED is
begin
  process(a, b)
  begin
    if (signed(a) > signed(b)) then
      le <= '0';
      eq <= '0';
      gr <= '1';
    elsif (signed(a) < signed(b)) then
      le <= '1';
      eq <= '0';
      gr <= '0';
    else
      le <= '0';
      eq <= '1';
      gr <= '0';
    end if;
  end process;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity nand_and_teris_alu is
  port (
    x: in std_logic_vector(15 downto 0);
    y: in std_logic_vector(15 downto 0);
    zx: in std_logic;
    zy: in std_logic;
    nx: in std_logic;
    ny: in std_logic;
    f: in std_logic;
    n0: in std_logic;
    zr: out std_logic;
    ng: out std_logic;
    onotp: out std_logic_vector(15 downto 0);
    greater: out std_logic);
end nand_and_teris_alu;

architecture Behavioral of nand_and_teris_alu is
  signal s0: std_logic_vector(15 downto 0);
  signal s1: std_logic_vector(15 downto 0);
  signal s2: std_logic_vector(15 downto 0);
  signal s3: std_logic_vector(15 downto 0);
  signal s4: std_logic_vector(15 downto 0);
  signal s5: std_logic_vector(15 downto 0);
  signal s6: std_logic_vector(15 downto 0);
  signal s7: std_logic_vector(15 downto 0);
  signal s8: std_logic_vector(15 downto 0);
  signal s9: std_logic_vector(15 downto 0);
begin
  gate0: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => zx,
      in_0 => x,
      in_1 => "0000000000000000",
      p_out => s0);
  gate1: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => zy,
      in_0 => y,
      in_1 => "0000000000000000",
      p_out => s1);
  s2 <= NOT s0;
  s4 <= NOT s1;
  gate2: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => nx,
      in_0 => s0,
      in_1 => s2,
      p_out => s3);
  gate3: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => ny,
      in_0 => s1,
      in_1 => s4,
      p_out => s5);
  s6 <= (s3 AND s5);
  gate4: entity work.DIG_Add
    generic map (
      Bits => 16)
    port map (
      a => s3,
      b => s5,
      c_i => '0',
      s => s7);
  gate5: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => f,
      in_0 => s6,
      in_1 => s7,
      p_out => s8);
  gate6: entity work.COMP_GATE_SIGNED
    generic map (
      Bits => 16)
    port map (
      a => s8,
      b => "0000000000000000",
      gr => greater,
      eq => zr,
      le => ng);
  s9 <= NOT s8;
  gate7: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => n0,
      in_0 => s8,
      in_1 => s9,
      p_out => onotp);
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_1 is
  port (
    p_out: out std_logic;
    sel: in std_logic;
    
    in_0: in std_logic;
    in_1: in std_logic );
end MUX_GATE_1;

architecture Behavioral of MUX_GATE_1 is
begin
  with sel select
    p_out <=
      in_0 when '0',
      in_1 when '1',
      '0' when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity DIG_D_FF is
  generic (
    Default: std_logic ); 
  port ( D  : in std_logic;
         C  : in std_logic;
         Q  : out std_logic;
         notQ : out std_logic );
end DIG_D_FF;

architecture Behavioral of DIG_D_FF is
   signal state : std_logic := Default;
begin
   Q    <= state;
   notQ <= NOT( state );

   process(C)
   begin
      if rising_edge(C) then
        state  <= D;
      end if;
   end process;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity n1_bit_regitor is
  port (
    p_in: in std_logic;
    CLK: in std_logic;
    L: in std_logic;
    onotp: out std_logic);
end n1_bit_regitor;

architecture Behavioral of n1_bit_regitor is
  signal s0: std_logic;
  signal onotp_temp: std_logic;
begin
  gate0: entity work.MUX_GATE_1
    port map (
      sel => L,
      in_0 => onotp_temp,
      in_1 => p_in,
      p_out => s0);
  gate1: entity work.DIG_D_FF
    generic map (
      Default => '0')
    port map (
      D => s0,
      C => CLK,
      Q => onotp_temp);
  onotp <= onotp_temp;
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity n16_bit_registor is
  port (
    clk: in std_logic;
    L: in std_logic;
    p_IN: in std_logic_vector(15 downto 0);
    onotp: out std_logic_vector(15 downto 0));
end n16_bit_registor;

architecture Behavioral of n16_bit_registor is
  signal s0: std_logic;
  signal s1: std_logic;
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
  signal s8: std_logic;
  signal s9: std_logic;
  signal s10: std_logic;
  signal s11: std_logic;
  signal s12: std_logic;
  signal s13: std_logic;
  signal s14: std_logic;
  signal s15: std_logic;
  signal s16: std_logic;
  signal s17: std_logic;
  signal s18: std_logic;
  signal s19: std_logic;
  signal s20: std_logic;
  signal s21: std_logic;
  signal s22: std_logic;
  signal s23: std_logic;
  signal s24: std_logic;
  signal s25: std_logic;
  signal s26: std_logic;
  signal s27: std_logic;
  signal s28: std_logic;
  signal s29: std_logic;
  signal s30: std_logic;
  signal s31: std_logic;
  signal s32: std_logic_vector(3 downto 0);
  signal s33: std_logic_vector(3 downto 0);
  signal s34: std_logic_vector(3 downto 0);
begin
  s28 <= p_IN(0);
  s24 <= p_IN(1);
  s26 <= p_IN(2);
  s30 <= p_IN(3);
  s20 <= p_IN(4);
  s16 <= p_IN(5);
  s18 <= p_IN(6);
  s22 <= p_IN(7);
  s12 <= p_IN(8);
  s8 <= p_IN(9);
  s10 <= p_IN(10);
  s14 <= p_IN(11);
  s4 <= p_IN(12);
  s0 <= p_IN(13);
  s2 <= p_IN(14);
  s6 <= p_IN(15);
  gate0: entity work.n1_bit_regitor
    port map (
      p_in => s0,
      CLK => clk,
      L => L,
      onotp => s1);
  gate1: entity work.n1_bit_regitor
    port map (
      p_in => s2,
      CLK => clk,
      L => L,
      onotp => s3);
  gate2: entity work.n1_bit_regitor
    port map (
      p_in => s4,
      CLK => clk,
      L => L,
      onotp => s5);
  gate3: entity work.n1_bit_regitor
    port map (
      p_in => s6,
      CLK => clk,
      L => L,
      onotp => s7);
  gate4: entity work.n1_bit_regitor
    port map (
      p_in => s8,
      CLK => clk,
      L => L,
      onotp => s9);
  gate5: entity work.n1_bit_regitor
    port map (
      p_in => s10,
      CLK => clk,
      L => L,
      onotp => s11);
  gate6: entity work.n1_bit_regitor
    port map (
      p_in => s12,
      CLK => clk,
      L => L,
      onotp => s13);
  gate7: entity work.n1_bit_regitor
    port map (
      p_in => s14,
      CLK => clk,
      L => L,
      onotp => s15);
  gate8: entity work.n1_bit_regitor
    port map (
      p_in => s16,
      CLK => clk,
      L => L,
      onotp => s17);
  gate9: entity work.n1_bit_regitor
    port map (
      p_in => s18,
      CLK => clk,
      L => L,
      onotp => s19);
  gate10: entity work.n1_bit_regitor
    port map (
      p_in => s20,
      CLK => clk,
      L => L,
      onotp => s21);
  gate11: entity work.n1_bit_regitor
    port map (
      p_in => s22,
      CLK => clk,
      L => L,
      onotp => s23);
  gate12: entity work.n1_bit_regitor
    port map (
      p_in => s24,
      CLK => clk,
      L => L,
      onotp => s25);
  gate13: entity work.n1_bit_regitor
    port map (
      p_in => s26,
      CLK => clk,
      L => L,
      onotp => s27);
  gate14: entity work.n1_bit_regitor
    port map (
      p_in => s28,
      CLK => clk,
      L => L,
      onotp => s29);
  gate15: entity work.n1_bit_regitor
    port map (
      p_in => s30,
      CLK => clk,
      L => L,
      onotp => s31);
  s32(0) <= s5;
  s32(1) <= s1;
  s32(2) <= s3;
  s32(3) <= s7;
  s33(0) <= s13;
  s33(1) <= s9;
  s33(2) <= s11;
  s33(3) <= s15;
  s34(0) <= s21;
  s34(1) <= s17;
  s34(2) <= s19;
  s34(3) <= s23;
  onotp(0) <= s29;
  onotp(1) <= s25;
  onotp(2) <= s27;
  onotp(3) <= s31;
  onotp(7 downto 4) <= s34;
  onotp(11 downto 8) <= s33;
  onotp(15 downto 12) <= s32;
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity pc is
  port (
    inc: in std_logic;
    p_in: in std_logic_vector(15 downto 0);
    load: in std_logic;
    rst: in std_logic;
    clk: in std_logic;
    onotp: out std_logic_vector(15 downto 0));
end pc;

architecture Behavioral of pc is
  signal onotp_temp: std_logic_vector(15 downto 0);
  signal s0: std_logic_vector(15 downto 0);
  signal s1: std_logic_vector(15 downto 0);
  signal s2: std_logic_vector(15 downto 0);
  signal s3: std_logic_vector(15 downto 0);
  signal s4: std_logic_vector(15 downto 0);
begin
  gate0: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => inc,
      in_0 => s0,
      in_1 => s1,
      p_out => s2);
  gate1: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => load,
      in_0 => s2,
      in_1 => p_in,
      p_out => s3);
  gate2: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => rst,
      in_0 => s3,
      in_1 => s4,
      p_out => onotp_temp);
  gate3: entity work.n16_bit_registor
    port map (
      clk => clk,
      L => '1',
      p_IN => onotp_temp,
      onotp => s0);
  gate4: entity work.DIG_Add -- increament
    generic map (
      Bits => 16)
    port map (
      a => s0,
      b => "0000000000000001",
      c_i => '0',
      s => s1);
  s4 <= (s0 AND NOT s0);
  onotp <= onotp_temp;
end Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity MUX_GATE_3 is
  port (
    p_out: out std_logic;
    sel: in std_logic_vector (2 downto 0);
    
    in_0: in std_logic;
    in_1: in std_logic;
    in_2: in std_logic;
    in_3: in std_logic;
    in_4: in std_logic;
    in_5: in std_logic;
    in_6: in std_logic;
    in_7: in std_logic );
end MUX_GATE_3;

architecture Behavioral of MUX_GATE_3 is
begin
  with sel select
    p_out <=
      in_0 when "000",
      in_1 when "001",
      in_2 when "010",
      in_3 when "011",
      in_4 when "100",
      in_5 when "101",
      in_6 when "110",
      in_7 when "111",
      '0' when others;
end Behavioral;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity main is
  port (
    inM: in std_logic_vector(15 downto 0);
    instruction: in std_logic_vector(15 downto 0);
    reset: in std_logic;
    clk: in std_logic;
    writeM: out std_logic;
    pc: out std_logic_vector(15 downto 0));
end main;

architecture Behavioral of main is
  signal s0: std_logic_vector(15 downto 0);
  signal s1: std_logic_vector(15 downto 0);
  signal s2: std_logic;
  signal s3: std_logic;
  signal s4: std_logic;
  signal s5: std_logic;
  signal s6: std_logic;
  signal s7: std_logic;
  signal s8: std_logic;
  signal s9: std_logic;
  signal s10: std_logic_vector(15 downto 0);
  signal s11: std_logic;
  signal s12: std_logic;
  signal s13: std_logic_vector(15 downto 0);
  signal s14: std_logic_vector(15 downto 0);
  signal s15: std_logic;
  signal s16: std_logic;
  signal s17: std_logic;
  signal s18: std_logic_vector(2 downto 0);
  signal s19: std_logic_vector(2 downto 0);
  signal s20: std_logic_vector(5 downto 0);
  signal s21: std_logic_vector(2 downto 0);
  signal s22: std_logic;
  signal s23: std_logic;
  signal s24: std_logic;
  signal s25: std_logic;
  signal s26: std_logic;
  signal s27: std_logic;
  signal s28: std_logic;
  signal s29: std_logic;
  signal s30: std_logic;
  signal s31: std_logic;
  signal s32: std_logic;
  signal s33: std_logic;
  signal s34: std_logic_vector(7 downto 0);
begin
  s18 <= instruction(2 downto 0);
  s19 <= instruction(5 downto 3);
  s20 <= instruction(11 downto 6);
  s16 <= instruction(12);
  s21 <= instruction(15 downto 13);
  s24 <= (NOT s18(0) AND NOT s18(1) AND NOT s18(2));
  s17 <= NOT s21(2);
  s7 <= s20(0);
  s6 <= s20(1);
  s5 <= s20(2);
  s3 <= s20(3);
  s4 <= s20(4);
  s2 <= s20(5);
  writeM <= s19(0);
  s15 <= s19(1);
  s12 <= (s19(2) OR s17);
  gate0: entity work.nand_and_teris_alu
    port map (
      x => s0,
      y => s1,
      zx => s2,
      zy => s3,
      nx => s4,
      ny => s5,
      f => s6,
      n0 => s7,
      zr => s8,
      ng => s9,
      onotp => s10,
      greater => s11);
  gate1: entity work.n16_bit_registor -- A
    port map (
      clk => clk,
      L => s12,
      p_IN => s13,
      onotp => s14);
  gate2: entity work.n16_bit_registor -- D
    port map (
      clk => clk,
      L => s15,
      p_IN => s10,
      onotp => s0);
  gate3: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => s16,
      in_0 => s14,
      in_1 => inM,
      p_out => s1);
  gate4: entity work.MUX_GATE_BUS_1
    generic map (
      Bits => 16)
    port map (
      sel => s17,
      in_0 => s10,
      in_1 => instruction,
      p_out => s13);
  gate5: entity work.pc
    port map (
      inc => s22,
      p_in => s14,
      load => s23,
      rst => reset,
      clk => clk,
      onotp => pc);
  gate6: entity work.MUX_GATE_1
    port map (
      sel => s25,
      in_0 => s24,
      in_1 => s25,
      p_out => s22);
  gate7: entity work.MUX_GATE_3
    port map (
      sel => s18,
      in_0 => s26,
      in_1 => s27,
      in_2 => s28,
      in_3 => s29,
      in_4 => s30,
      in_5 => s31,
      in_6 => s32,
      in_7 => s33,
      p_out => s23);
  s25 <= NOT s23;
  s34(0) <= '0';
  s34(1) <= s11;
  s34(2) <= s8;
  s34(3) <= (s11 AND s8);
  s34(4) <= s9;
  s34(5) <= NOT s8;
  s34(6) <= (s8 AND s9);
  s34(7) <= '1';
  s26 <= s34(0);
  s27 <= s34(1);
  s28 <= s34(2);
  s29 <= s34(3);
  s30 <= s34(4);
  s31 <= s34(5);
  s32 <= s34(6);
  s33 <= s34(7);
end Behavioral;
