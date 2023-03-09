library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
  port (
    enable : in std_logic := '0';
    pc_in : in std_logic_vector(23 downto 0);
    pc_out : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of pc is
  signal pc_reg : std_logic_vector(23 downto 0) := (others => '0');
begin
  process (enable)
  begin
      if (enable = '1') then
         pc_reg <= pc_in;
      end if;
  end process;
  pc_out <= pc_reg;
end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity pc_tb is
end pc_tb;

architecture simple of pc_tb is
	
signal clk : std_logic := '0';
signal enable : std_logic := '0';
signal pc_in : std_logic_vector(23 downto 0) := (others => '0');
signal pc_out : std_logic_vector(23 downto 0);

begin
-- instantiate the PC entity
uut : entity work.pc
port map (
enable => enable,
pc_in => pc_in,
pc_out => pc_out
);

-- clock process to generate a clock signal
clk_process : process
begin
clk <= '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
end process;

-- test process to set inputs and observe outputs
test_process : process
begin
-- test 1: PC register should be equal to pc_in when enable is '1'
pc_in <= "000000011001000110110011";
enable <= '1';
wait for 10 ns;
assert pc_out = pc_in report "Test 1 Failed" severity error;

-- test 2: PC register should remain unchanged when enable is '0'
pc_in <= "000000000000010000001000";
enable <= '0';
wait for 10 ns;
assert pc_out = "000000011001000110110011" report "Test 2 Failed" severity error;

-- test 3: PC register should be equal to pc_in when enable is '1'
pc_in <= "000000001101011100010001";
enable <= '1';
wait for 10 ns;
assert pc_out = pc_in report "Test 3 Failed" severity error;

-- test 4: PC register should remain unchanged when enable is '0'
pc_in <= "000000001011011011011011";
enable <= '0';
wait for 10 ns;
assert pc_out = "000000001101011100010001" report "Test 4 Failed" severity error;
end process;
	
end simple;
