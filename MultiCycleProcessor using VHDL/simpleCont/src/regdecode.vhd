library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_decode is
	port (
		inst : in std_logic_vector(23 downto 0);
		instw: in std_logic := '0';
		cond : out std_logic_vector(1 downto 0);
		op : out std_logic_vector(4 downto 0);
		sf: out std_logic;
		rd: out std_logic_vector(2 downto 0);
		rs: out std_logic_vector(2 downto 0);
		rt: out std_logic_vector(2 downto 0);
		imm: out std_logic_vector(16 downto 0)
		);
end inst_decode;

architecture decoder of inst_decode is
signal pos : std_logic_vector(6 downto 0) := (others => '0');
signal neg : std_logic_vector(6 downto 0) := (others => '1');
begin
	process(instw,inst) 	
	begin
	if ( instw = '1' ) then
		cond <= inst(23 downto 22);
		op <= inst(21 downto 17);
		if ( inst(21 downto 17) < "00110" ) then
			sf <= inst(16);
			rd <= inst(15 downto 13);
			rs <= inst(12 downto 10);
			rt <= inst(9 downto 7);
		elsif ( inst(21 downto 17) < "01100") then
			if ( inst(9) = '1' ) then
				sf <= inst(16);
				rt <= inst(15 downto 13);
				rs <= inst(12 downto 10);
				imm <= neg & inst(9 downto 0);
			else
				sf <= inst(16);
				rt <= inst(15 downto 13);
				rs <= inst(12 downto 10);
				imm <= pos & inst(9 downto 0);
			end if; 
		elsif (inst(21 downto 17) < "01111") then
			imm <= inst(16 downto 0);
		end if;	
	end if;	
	end process;	
	
end decoder;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity inst_decode_tb is
end entity;

architecture tb of inst_decode_tb is

signal inst : std_logic_vector(23 downto 0);
signal instw : std_logic;
signal cond : std_logic_vector(1 downto 0);
signal op : std_logic_vector(4 downto 0);
signal sf: std_logic;
signal rd: std_logic_vector(2 downto 0);
signal rs: std_logic_vector(2 downto 0);
signal rt: std_logic_vector(2 downto 0);
signal imm: std_logic_vector(16 downto 0);

begin

dut : entity work.inst_decode(decoder)
port map (
	inst => inst,
	instw => instw,
	cond => cond,
	op => op,
	sf => sf,
	rd => rd,
	rs => rs,
	rt => rt,
	imm => imm
);

inst 	<= "000000000010100110000000",	
		 "010100101101000110000000" after 	20ns,
		 "100100101101001110000000"after 	40ns,
		 "110110010110010110011000"after 	60ns,
		 "000110110010110010010000"after 	80ns; 
instw 	<= '1';

end;
