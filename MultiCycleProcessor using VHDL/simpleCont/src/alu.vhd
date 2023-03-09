LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.ALL;
use ieee.numeric_std.all;

entity alu is
	port (
	A: in std_logic_vector(23 downto 0);
	B: in std_logic_vector(23 downto 0);
	ctrl: in std_logic_vector(2 downto 0);
	sign: std_logic;
	zero: out std_logic;
	result: out std_logic_vector(23 downto 0)	
		);
end alu;

architecture behavioral of alu is
begin
	process(A, B, ctrl)
	variable max : std_logic_vector(23 downto 0);
    begin
	if A > B then
		max := A;
	else
		max := B;
	end if;		
        case ctrl is
            when "000" => result <= A + B; -- ADD instruction
            when "001" => result <= A - B; -- SUBTRACT instruction
            when "010" => result <= A and B; -- BITWISE AND instruction
            when "011" => result <= max; -- MAX instruction
            when "100" => 
                if A >= B then
                    zero <= '0';
                else
                    zero <= '1';
                end if; -- COMPARE instruction
            when "101" => 
                result <= A - B;
                if (A - B) = 0 then
                    zero <= '1';
                else
                    zero <= '0';
                end if; -- SUBSF instruction
            when others => null;
        end case;
    end process;		
end behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is

component alu is
port (
A: in std_logic_vector(23 downto 0);
B: in std_logic_vector(23 downto 0);
ctrl: in std_logic_vector(2 downto 0);
sign: std_logic;
zero: out std_logic;
result: out std_logic_vector(23 downto 0)
);
end component;

signal A, B: std_logic_vector(23 downto 0);
signal sign: std_logic;
signal ctrl: std_logic_vector(2 downto 0);
signal zero: std_logic;
signal result: std_logic_vector(23 downto 0);

begin

dut: alu port map (A => A, B => B, sign => sign, ctrl => ctrl, zero => zero, result => result);

test: process
begin
A <= X"F00001";
B <= X"FF0002";
ctrl <= "000";
wait for 15 ns;
A <= X"F00001";
B <= X"FF0002";
ctrl <= "000";
wait for 15 ns;
A <= X"000011";
B <= X"000010";
ctrl <= "010";
wait for 10 ns;
A <= X"000011";
B <= X"000010";
ctrl <= "011";
wait for 10 ns;
A <= X"000011";
B <= X"000010";
ctrl <= "100";
wait for 10 ns;
assert (zero = '0') report "COMPARE failed";

A <= X"000011";
B <= X"000011";
ctrl <= "101";
wait for 10 ns;
assert (zero = '1') report "SUBTRACT/COMPARE failed";

wait;
end process;
end testbench;