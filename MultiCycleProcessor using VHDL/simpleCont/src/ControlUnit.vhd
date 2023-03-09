library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ContUnit is
    Port (
        state : in std_logic_vector(3 downto 0) := "0000";
        opcode : in std_logic_vector(4 downto 0);
        cond : in std_logic_vector(1 downto 0);
        sf : in std_logic;
		zero: in std_logic;
		clk: in std_logic;
        nextstate : out std_logic_vector(3 downto 0);
        flags : out std_logic_vector(19 downto 0)
    );
end ContUnit;

architecture static of ContUnit is
type arr1 is array (0 to 14) of std_logic_vector(19 downto 0);
type arr2 is array (0 to 14) of std_logic_vector(3 downto 0);
type arr3 is array (0 to 15) of arr2;
type arr4 is array (0 to 14) of std_logic_vector(4 downto 0);
signal flagArr:arr1 := (
    "1001XX1XX00100000010",
    "0X00XX0XX000100000X0",
    "0X00XX0XX0100XXX0XX0",
    "0X00100001XXXXXX0XX0",
    "1X00XX0XX0XXXXXX0X00",
    "0101XX0XX0XXXXXX0XX0",
    "0X00000001XXXXXX0XX0",
    "0X00XX0XX0101XXX0XX0",
    "0X00100011XXXXXX0XX0",
    "0X00000011XXXXXX0XX0",
    "0110XX0XX0XXXXXX0XX0",
    "0X00XX0XX11001000111",
    "0X00110101XXXXXX0XX0",
    "0X00100111XXXXXX0XX0",
    "1X00XX0XX0XXXXXX0X10"
);

signal nextS: arr3 := (
("0001","0010","0011","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),	   
("0001","0010","0011","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0010","0101","XXXX","XXXX","0110","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0010","0011","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0010","0011","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0010","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0100","XXXX","XXXX","XXXX","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0111","XXXX","XXXX","XXXX","XXXX","XXXX","1000","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0111","XXXX","XXXX","XXXX","XXXX","XXXX","1000","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0111","XXXX","XXXX","XXXX","1001","XXXX","0101","XXXX","0000","XXXX","XXXX","XXXX","XXXX","XXXX"),
("0001","0111","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","1010","XXXX","XXXX","0000","XXXX","XXXX","XXXX"),
("0001","1011","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","0000","XXXX","XXXX","XXXX"),
("0001","1110","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","0000"),
("0001","1101","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","1110","0000"),
("0001","1100","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX","0000","XXXX","XXXX"),
("0001","0111","XXXX","XXXX","XXXX","XXXX","XXXX","1000","0000","XXXX","XXXX","XXXX","XXXX","XXXX","XXXX")
);


begin
process( clk ) 
variable nstate: std_logic_vector(3 downto 0);	
begin
if rising_edge(clk) then	
if(state = "0000") then
	nextstate <= "0001";
else	
	nextstate <= nextS(to_integer(unsigned(opcode)))(to_integer(unsigned(state)));
end if;
flags <= flagArr(to_integer(unsigned(state)));
if ( state = "0010" or state = "0111" ) then	
	case opcode is
		when "00000" =>
		flags(6 downto 2) <= "01001";
		when "00001" =>
		flags(6 downto 2) <= "01101";
		when "00011" =>
		flags(6 downto 2) <= "00001";
		when "00100" =>
		if ( sf = '0' ) then
			flags(6 downto 2) <= "00101";
		else
			flags(6 downto 2) <= "10111";
		end if;		
		when "00101" =>
		flags(6 downto 2) <= "10011";
		when "00111" =>
		flags(6 downto 2) <= "01001";
		when "01000" =>
		flags(6 downto 2) <= "00001";
		when "01111" =>
		if ( sf = '0' ) then
			flags(6 downto 2) <= "00101";
		else
			flags(6 downto 2) <= "10111";
		end if;
		when others => 
		flags(6 downto 2) <= "00001";		
	end case;	
end if;

if ( state = "0001" ) then
	if ( cond = "01" and zero = '0' ) then
		flags <= flagArr(0);
		nextstate <= "0000";
	elsif ( cond = "10" and zero = '1' ) then
		flags <= flagArr(0);
		nextstate <= "0000";
	elsif(cond = "11") then
		 flags <= flagArr(0);
		nextstate <= "0000";
	end if;
end if;
end if;
end process;	
	
end static;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ContUnit is
end entity tb_ContUnit;

architecture tb of tb_ContUnit is
  signal state     : std_logic_vector(3 downto 0) := (others => '0');
  signal opcode    : std_logic_vector(4 downto 0) := (others => '0');
  signal cond      : std_logic_vector(1 downto 0) := (others => '0');
  signal sf        : std_logic                 := '0';
  signal zero	   :std_logic 				   := '0';
  signal clk       : std_logic                 := '0';
  signal nextstate : std_logic_vector(3 downto 0);
  signal flags     : std_logic_vector(19 downto 0);

  constant CLK_PERIOD : time := 10 ns;

  component ContUnit is
    Port (
      state     : in  std_logic_vector(3 downto 0);
      opcode    : in  std_logic_vector(4 downto 0);
      cond      : in  std_logic_vector(1 downto 0);
      sf        : in  std_logic;
	  zero      : in  std_logic;
      clk       : in  std_logic;
      nextstate : out std_logic_vector(3 downto 0);
      flags     : out std_logic_vector(19 downto 0)
    );
  end component;

begin
  uut : ContUnit
    port map (
      state     => state,
      opcode    => opcode,
      cond      => cond,
      sf        => sf,
      clk       => clk,
	  zero      =>  zero,
      nextstate => nextstate,
      flags     => flags
    );

  clk_process : process
  begin
    while now < 10000 ns loop
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
    wait;
  end process;

  stimulus : process
  begin
    state <= "0000";
    opcode <= "00000";
    cond   <= "00";
    sf     <= '0';
    wait for CLK_PERIOD * 5;
    state <= "0010";
    opcode <= "00011";
    cond   <= "01";
    sf     <= '1';
    wait for CLK_PERIOD * 5;
    state <= "0111";
    opcode <= "00110";
    cond   <= "10";
    sf     <= '0';
    wait for CLK_PERIOD * 5;
    state <= "1000"; -- an invalid state
    wait for CLK_PERIOD * 5;
    state <= "0001";
    opcode <= "00101";
    cond   <= "11";
    sf     <= '1';
    wait for CLK_PERIOD * 5;
    state <= "1100";
    opcode <= "01011";
    cond   <= "00";
    sf     <= '0';
    wait for CLK_PERIOD * 5;
    state <= "0010";
    opcode <= "01111";
    cond   <= "01";
    sf     <= '1';
    wait;
  end process;

end architecture tb;