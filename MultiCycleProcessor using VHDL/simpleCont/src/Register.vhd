library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_24bit is
  port (
    din : in std_logic_vector(23 downto 0);
    clk : in std_logic;
    dout : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavioral of register_24bit is
  signal reg : std_logic_vector(23 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      reg <= din;
    end if;
  end process;

  dout <= reg;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_4bit is
  port (
    din : in std_logic_vector(3 downto 0) := "0000";
    clk : in std_logic;
    dout : out std_logic_vector(3 downto 0) :="0000"
  );
end entity;

architecture behavioral of register_4bit is
  signal reg : std_logic_vector(3 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      reg <= din;
    end if;
  end process;
  dout <= reg;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_24bit_tb is
end entity;

architecture behavioral of register_24bit_tb is
  signal din : std_logic_vector(23 downto 0) := (others => '0');
  signal clk : std_logic := '0';
  signal dout : std_logic_vector(23 downto 0);

begin
  dut : entity work.register_24bit
    port map (
      din => din,
      clk => clk,
      dout => dout
    );

  clk_gen : process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  stimulus : process
  begin
    din <= "000000100100100100100100";
    wait for 10 ns;
    din <= "111111111111111111111111";
    wait for 10 ns;
    din <= "101010101010101010101010";
    wait for 10 ns;
    wait;
  end process;
end architecture;