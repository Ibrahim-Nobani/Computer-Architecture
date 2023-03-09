library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity status_register_8bit is
  port (
    din : in  std_logic := '0';
    wflag : in  std_logic := '0';
    dout : out std_logic
  );
end entity;

architecture behavioral of status_register_8bit is
  signal reg : std_logic_vector(7 downto 0) := (others => '0');
begin
  process (wflag,din)
  begin
    if(wflag = '1') then
      reg <= reg(7 downto 1) & din;
    end if;
  end process;
   dout <= reg(0);
end architecture;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity status_register_8bit_tb is
end entity;

architecture behavioral of status_register_8bit_tb is
  signal din : std_logic := '0';
  signal wflag : std_logic := '0';
  signal dout : std_logic;
begin
  -- instantiate the design under test
  uut : entity work.status_register_8bit
    port map (
      din => din,
      wflag => wflag,
      dout => dout
    );

  -- write test cases
  process
  begin
    -- wait for 100 ns
    wait for 5 ns;

    -- write 1 to input and set wflag high
    din <= '0';
    wflag <= '0';
    wait for 10 ns;

    -- write 0 to input and set wflag high
    din <= '1';
    wflag <= '1';
    wait for 10 ns;

    -- write 0 to input and set wflag low
    din <= '1';
    wflag <= '0';
    wait for 10 ns;

    -- write 1 to input and set wflag high
    din <= '1';
    wflag <= '1';
    wait for 10 ns;	 
	din <= '0';
    wflag <= '1';
    wait for 10 ns;

    -- wait for 10 ns
    wait for 10 ns;

    wait;
  end process;
end architecture;