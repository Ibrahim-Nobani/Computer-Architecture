library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity register_file is
  port (
    wflag : in std_logic := '0';
    read_reg1 : in std_logic_vector(2 downto 0);
    read_reg2 : in std_logic_vector(2 downto 0);
    write_reg : in std_logic_vector(2 downto 0);
    write_data : in std_logic_vector(23 downto 0);
    read_data1 : out std_logic_vector(23 downto 0);
    read_data2 : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavioral of register_file is
  type reg_file is array (0 to 7) of std_logic_vector(23 downto 0);
  signal regs : reg_file := (others => (others => '0'));
begin
  process(wflag)
  begin
    if (wflag'event and wflag = '1' and to_integer(unsigned(write_reg)) > 0) then
      regs(to_integer(unsigned(write_reg))) <= write_data;
    end if;
  end process;
  read_data1 <= regs(to_integer(unsigned(write_reg)));
  read_data2 <= regs(to_integer(unsigned(write_reg)));
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file_tb is
end entity;

architecture behavioral of register_file_tb is
  signal wflag : std_logic := '0';
  signal read_reg1, read_reg2, write_reg : std_logic_vector(2 downto 0) := (others => '0');
  signal write_data : std_logic_vector(23 downto 0) := (others => '0');
  signal read_data1, read_data2 : std_logic_vector(23 downto 0);
begin
  dut : entity work.register_file
    port map (
      wflag => wflag,
      read_reg1 => read_reg1,
      read_reg2 => read_reg2,
      write_reg => write_reg,
      write_data => write_data,
      read_data1 => read_data1,
      read_data2 => read_data2
    );
  wflag_gen : process
  begin
    wait for 5 ns;
    wflag <= not wflag;
    if (now > 100 ns) then
      wait;
    end if;
  end process;
  test : process
  begin
    wait for 6 ns;
    write_reg <= "101";
    write_data <= "000000000000000000000111";
    wait for 10 ns;
    write_reg <= "010";
    write_data <= "111111111111111111111111";
    wait for 15 ns;
    read_reg1 <= "101";
    read_reg2 <= "010";
    wait for 20 ns;
    assert (read_data1 = "111111111111111111111111") report "Error: read_data1 incorrect";
    assert (read_data2 = "000000000000000000000000") report "Error: read_data2 incorrect";
    wait;
  end process;
end architecture;
