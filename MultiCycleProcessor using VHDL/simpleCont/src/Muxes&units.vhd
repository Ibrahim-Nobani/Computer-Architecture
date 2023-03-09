library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender is
  port (
    in1 : in  std_logic_vector(16 downto 0);
    out1 : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of sign_extender is
begin
  out1(23 downto 17) <= in1(16) & in1(16) & in1(16) & in1(16) & in1(16) & in1(16) & in1(16);
  out1(16 downto 0) <= in1;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extender_tb is
end entity;

architecture behavior of sign_extender_tb is
  component sign_extender is
    port (
      in1 : in  std_logic_vector(16 downto 0);
      out1 : out std_logic_vector(23 downto 0)
    );
  end component;

  signal in1 : std_logic_vector(16 downto 0) := (others => '0');
  signal out1 : std_logic_vector(23 downto 0);

begin

  dut : sign_extender
    port map (
      in1 => in1,
      out1 => out1
    );

  -- Test case 1: Input is positive
  in1 <= "00000000000000001",
  "11111111111111111" after 10 ns,
  "10000000000000000" after 20 ns;
 

end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rotate is
  port (
    in1 : in  std_logic_vector(16 downto 0);
    out1 : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of rotate is
begin
  out1(23 downto 7) <= in1;
  out1(6 downto 0) <= (others => '0');
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_24 is
  port (
    sel : in std_logic;
    in0 : in std_logic_vector(23 downto 0);
    in1 : in std_logic_vector(23 downto 0);
    out1 : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of mux2x1_24 is
begin
  process (sel, in0, in1)
  begin
    if (sel = '0') then
      out1 <= in0;
    else
      out1 <= in1;
    end if;
  end process;
end architecture;	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_24_tb is
end entity;

architecture behavior of mux2x1_24_tb is
  signal sel : std_logic;
  signal in0 : std_logic_vector(23 downto 0) := (others => '0');
  signal in1 : std_logic_vector(23 downto 0) := (others => '0');
  signal out1 : std_logic_vector(23 downto 0);

begin
  dut: entity work.mux2x1_24
    port map (
      sel => sel,
      in0 => in0,
      in1 => in1,
      out1 => out1
    );

  -- Test case 1
   sel <= '0',
  	  '1' after 10 ns;
  in0 <= X"000001";
  in1 <= X"FFFFFF";
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3x1_24 is
  port (
    sel : in std_logic_vector(1 downto 0);
    in0 : in std_logic_vector(23 downto 0);
    in1 : in std_logic_vector(23 downto 0);
	in2 : in std_logic_vector(23 downto 0);
    out1 : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of mux3x1_24 is
begin
  process (sel, in0, in1, in2)
  begin
    if (sel = "00") then
      out1 <= in0;
    elsif (sel = "01") then
      out1 <= in1;
	elsif (sel = "10") then
		out1<=in2;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3x1_24_tb is
end entity;

architecture behavior of mux3x1_24_tb is
  signal sel : std_logic_vector(1 downto 0);
  signal in0 : std_logic_vector(23 downto 0) := (others => '0');
  signal in1 : std_logic_vector(23 downto 0) := (others => '0');
  signal in2 : std_logic_vector(23 downto 0) := (others => '0');
  signal out1 : std_logic_vector(23 downto 0);

begin
  dut: entity work.mux3x1_24
    port map (
      sel => sel,
      in0 => in0,
      in1 => in1,
	  in2 => in2,
      out1 => out1
    );

  -- Test case 1
   sel <= "00",
   "01" after 10 ns,
   "10" after 20 ns;
  in0 <= X"000001";
  in1 <= X"FFFFFF";
  in2 <= X"222222";
end architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_3 is
  port (
    sel : in std_logic_vector(1 downto 0);
    in0 : in std_logic_vector(2 downto 0);
    in1 : in std_logic_vector(2 downto 0);
	in2 : in std_logic_vector(2 downto 0);
	in3 : in std_logic_vector(2 downto 0);
    out1 : out std_logic_vector(2 downto 0)
  );
end entity;

architecture behavior of mux4x1_3 is
begin
  process (sel, in0, in1, in2)
  begin
    if (sel = "00") then
      out1 <= in0;
    elsif (sel = "01") then
      out1 <= in1;
	elsif (sel = "10") then
		out1<=in2;
    end if;
  end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_24 is
  port (
    sel : in std_logic_vector(1 downto 0);
    in0 : in std_logic_vector(23 downto 0);
    in1 : in std_logic_vector(23 downto 0);
	in2 : in std_logic_vector(23 downto 0);
	in3 : in std_logic_vector(23 downto 0);
    out1 : out std_logic_vector(23 downto 0)
  );
end entity;

architecture behavior of mux4x1_24 is
begin
  process (sel, in0, in1, in2)
  begin
    if (sel = "00") then
      out1 <= in0;
    elsif (sel = "01") then
      out1 <= in1;
	elsif (sel = "10") then
		out1<=in2;
	elsif (sel = "11") then
		out1<=in3;
    end if;
  end process;
end architecture;

