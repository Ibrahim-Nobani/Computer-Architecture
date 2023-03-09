library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
  port (
    clk : in std_logic;
    address : in std_logic_vector(23 downto 0);
    wflag : in std_logic;
    dataIn : in std_logic_vector(23 downto 0);
    rflag : in std_logic;
    dataOut : out std_logic_vector(23 downto 0)
  );
end entity memory;

architecture behavioral of memory is
	type memory_block is array (0 to 4095) of std_logic_vector(7 downto 0);
  signal mem : memory_block := (
  0 => x"12",
  1 => x"40",
  2 => x"2a",
  3 => x"12",
  4 => x"20",
  5 => x"2d",
  6 => x"06",
  7 => x"68",
  8 => x"80",
  44 => x"01",
  47 => x"02",
  others => x"00");
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if (wflag = '1') then
        mem(to_integer(unsigned(address(11 downto 0))))  <= dataIn(23 downto 16);
		mem(to_integer(unsigned(address(11 downto 0))+1)) <= dataIn(15 downto 8);
		mem(to_integer(unsigned(address(11 downto 0))+2)) <= dataIn(7 downto 0);	
      end if;
    end if;
  end process;
  
  dataOut <= mem(to_integer(unsigned(address(11 downto 0)))) &  mem(to_integer(unsigned(address(11 downto 0))+1)) &  mem(to_integer(unsigned(address(11 downto 0))+2)) when rflag = '1';
end architecture behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_tb is
end entity memory_tb;

architecture behavioral of memory_tb is
  component memory is
    port (
      clk : in std_logic;
      address : in std_logic_vector(23 downto 0);
      wflag : in std_logic;
      dataIn : in std_logic_vector(23 downto 0);
      rflag : in std_logic;
      dataOut : out std_logic_vector(23 downto 0)
    );
  end component;

  signal clk : std_logic := '0';
  signal address : std_logic_vector(23 downto 0) := (others => '0');
  signal wflag : std_logic := '0';
  signal dataIn : std_logic_vector(23 downto 0) := (others => '0');
  signal rflag : std_logic := '0';
  signal dataOut : std_logic_vector(23 downto 0);

begin
  mem_inst : memory
    port map (
      clk => clk,
      address => address,
      wflag => wflag,
      dataIn => dataIn,
      rflag => rflag,
      dataOut => dataOut
    );

  clk_process : process
  begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
  end process;

  test_process : process
  begin
    -- initialize memory with some test data
    address <= "000000000000000000000000";
    dataIn <= "101010101010101010101010";
    wflag <= '1';
    wait for 10 ns;
    
    -- read the data back from memory
    address <= "000000000000000000000000";
    rflag <= '1';
    wait for 10 ns;
    
    -- change the data in memory
    address <= "000000000000000000000000";
    dataIn <= "010101010101010101010101";
    wflag <= '1';
    wait for 10 ns;
    
    -- read the data back from memory
    address <= "000000000000000000000000";
    rflag <= '1';
    wait for 10 ns;
    
    -- end the simulation
    wait;
  end process;
end architecture behavioral;
