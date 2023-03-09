-------------------------------------------------------------------------------
--
-- Title       : Simple Controller
-- Design      : simpleCont
-- Author      : ASUS
-- Company     : bzu
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\hp\Desktop\Architecture\simpleCont22\simpleCont\compile\DataPath.vhd
-- Generated   : Wed Feb 15 23:52:58 2023
-- From        : C:\Users\hp\Desktop\Architecture\simpleCont22\simpleCont\src\DataPath.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;

entity DataPath is
  port(
       n1 : in STD_LOGIC_VECTOR(2 downto 0) := "001";
       n7 : in STD_LOGIC_VECTOR(2 downto 0) := "111";
       Input3 : in STD_LOGIC_VECTOR(23 downto 0) := "000000000000000000000011"
  );
end DataPath;

architecture DataPath of DataPath is

---- Component declarations -----

component alu
  port(
       A : in STD_LOGIC_VECTOR(23 downto 0);
       B : in STD_LOGIC_VECTOR(23 downto 0);
       ctrl : in STD_LOGIC_VECTOR(2 downto 0);
       sign : in STD_LOGIC;
       zero : out STD_LOGIC;
       result : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component clock_generator
  port(
       clk_out : out STD_LOGIC
  );
end component;
component ContUnit
  port(
       state : in STD_LOGIC_VECTOR(3 downto 0) := "0000";
       opcode : in STD_LOGIC_VECTOR(4 downto 0);
       cond : in STD_LOGIC_VECTOR(1 downto 0);
       sf : in STD_LOGIC;
       zero : in STD_LOGIC;
       clk : in STD_LOGIC;
       nextstate : out STD_LOGIC_VECTOR(3 downto 0);
       flags : out STD_LOGIC_VECTOR(19 downto 0)
  );
end component;
component inst_decode
  port(
       inst : in STD_LOGIC_VECTOR(23 downto 0);
       instw : in STD_LOGIC := '0';
       cond : out STD_LOGIC_VECTOR(1 downto 0);
       op : out STD_LOGIC_VECTOR(4 downto 0);
       sf : out STD_LOGIC;
       rd : out STD_LOGIC_VECTOR(2 downto 0);
       rs : out STD_LOGIC_VECTOR(2 downto 0);
       rt : out STD_LOGIC_VECTOR(2 downto 0);
       imm : out STD_LOGIC_VECTOR(16 downto 0)
  );
end component;
component memory
  port(
       clk : in STD_LOGIC;
       address : in STD_LOGIC_VECTOR(23 downto 0);
       wflag : in STD_LOGIC;
       dataIn : in STD_LOGIC_VECTOR(23 downto 0);
       rflag : in STD_LOGIC;
       dataOut : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component mux2x1_24
  port(
       sel : in STD_LOGIC;
       in0 : in STD_LOGIC_VECTOR(23 downto 0);
       in1 : in STD_LOGIC_VECTOR(23 downto 0);
       out1 : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component mux3x1_24
  port(
       sel : in STD_LOGIC_VECTOR(1 downto 0);
       in0 : in STD_LOGIC_VECTOR(23 downto 0);
       in1 : in STD_LOGIC_VECTOR(23 downto 0);
       in2 : in STD_LOGIC_VECTOR(23 downto 0);
       out1 : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component mux4x1_24
  port(
       sel : in STD_LOGIC_VECTOR(1 downto 0);
       in0 : in STD_LOGIC_VECTOR(23 downto 0);
       in1 : in STD_LOGIC_VECTOR(23 downto 0);
       in2 : in STD_LOGIC_VECTOR(23 downto 0);
       in3 : in STD_LOGIC_VECTOR(23 downto 0);
       out1 : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component mux4x1_3
  port(
       sel : in STD_LOGIC_VECTOR(1 downto 0);
       in0 : in STD_LOGIC_VECTOR(2 downto 0);
       in1 : in STD_LOGIC_VECTOR(2 downto 0);
       in2 : in STD_LOGIC_VECTOR(2 downto 0);
       in3 : in STD_LOGIC_VECTOR(2 downto 0);
       out1 : out STD_LOGIC_VECTOR(2 downto 0)
  );
end component;
component pc
  port(
       enable : in STD_LOGIC := '0';
       pc_in : in STD_LOGIC_VECTOR(23 downto 0);
       pc_out : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component register_24bit
  port(
       din : in STD_LOGIC_VECTOR(23 downto 0);
       clk : in STD_LOGIC;
       dout : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component register_4bit
  port(
       din : in STD_LOGIC_VECTOR(3 downto 0) := "0000";
       clk : in STD_LOGIC;
       dout : out STD_LOGIC_VECTOR(3 downto 0) := "0000"
  );
end component;
component register_file
  port(
       wflag : in STD_LOGIC := '0';
       read_reg1 : in STD_LOGIC_VECTOR(2 downto 0);
       read_reg2 : in STD_LOGIC_VECTOR(2 downto 0);
       write_reg : in STD_LOGIC_VECTOR(2 downto 0);
       write_data : in STD_LOGIC_VECTOR(23 downto 0);
       read_data1 : out STD_LOGIC_VECTOR(23 downto 0);
       read_data2 : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component rotate
  port(
       in1 : in STD_LOGIC_VECTOR(16 downto 0);
       out1 : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component sign_extender
  port(
       in1 : in STD_LOGIC_VECTOR(16 downto 0);
       out1 : out STD_LOGIC_VECTOR(23 downto 0)
  );
end component;
component status_register_8bit
  port(
       din : in STD_LOGIC := '0';
       wflag : in STD_LOGIC := '0';
       dout : out STD_LOGIC
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Signal declarations used on the diagram ----

signal beq : STD_LOGIC;
signal clk : STD_LOGIC;
signal pcen : STD_LOGIC;
signal sf : STD_LOGIC;
signal zeroflag : STD_LOGIC;
signal zeroreg : STD_LOGIC;
signal a : STD_LOGIC_VECTOR(23 downto 0);
signal adress : STD_LOGIC_VECTOR(23 downto 0);
signal alu1 : STD_LOGIC_VECTOR(23 downto 0);
signal alu2 : STD_LOGIC_VECTOR(23 downto 0);
signal alubreg : STD_LOGIC_VECTOR(23 downto 0);
signal aluout : STD_LOGIC_VECTOR(23 downto 0);
signal b : STD_LOGIC_VECTOR(23 downto 0);
signal BUS1426 : STD_LOGIC_VECTOR(23 downto 0);
signal BUS3388 : STD_LOGIC_VECTOR(23 downto 0);
signal BUS4565 : STD_LOGIC_VECTOR(16 downto 0);
signal cond : STD_LOGIC_VECTOR(1 downto 0);
signal control : STD_LOGIC_VECTOR(19 downto 0);
signal luiimm : STD_LOGIC_VECTOR(23 downto 0);
signal memoryout : STD_LOGIC_VECTOR(23 downto 0);
signal memoutbreg : STD_LOGIC_VECTOR(23 downto 0);
signal nextstate : STD_LOGIC_VECTOR(3 downto 0) := "0000";
signal opcode : STD_LOGIC_VECTOR(4 downto 0);
signal pcbus : STD_LOGIC_VECTOR(23 downto 0);
signal pcsrc : STD_LOGIC_VECTOR(23 downto 0);
signal rd : STD_LOGIC_VECTOR(2 downto 0);
signal regw : STD_LOGIC_VECTOR(2 downto 0);
signal regwriteback : STD_LOGIC_VECTOR(23 downto 0);
signal rs : STD_LOGIC_VECTOR(2 downto 0);
signal rt : STD_LOGIC_VECTOR(2 downto 0);
signal signextimm : STD_LOGIC_VECTOR(23 downto 0);
signal state : STD_LOGIC_VECTOR(3 downto 0) := "0000";

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;

begin

----  Component instantiations  ----

U10 : mux2x1_24
  port map(
       sel => control(18),
       in0 => pcbus,
       in1 => aluout,
       out1 => adress
  );

U11 : register_4bit
  port map(
       din => nextstate,
       clk => clk,
       dout => state
  );

pcen <= beq or control(19);

U13 : inst_decode
  port map(
       inst => memoutbreg,
       instw => control(13),
       cond => cond,
       op => opcode,
       sf => sf,
       rd => rd,
       rs => rs,
       rt => rt,
       imm => BUS4565
  );

beq <= zeroflag and control(0);

U15 : clock_generator
  port map(
       clk_out => clk
  );

U16 : mux4x1_3
  port map(
       sel(1) => control(12),
       sel(0) => control(11),
       in0 => rd,
       in1 => rt,
       in2 => n1,
       in3 => n7,
       out1 => regw
  );

U17 : register_file
  port map(
       wflag => control(10),
       read_reg1 => rs,
       read_reg2 => rt,
       write_reg => regw,
       write_data => regwriteback,
       read_data1 => BUS3388,
       read_data2 => BUS1426
  );

U18 : mux2x1_24
  port map(
       sel => control(9),
       in0 => pcbus,
       in1 => a,
       out1 => alu1
  );

U19 : mux3x1_24
  port map(
       sel(1) => control(8),
       sel(0) => control(7),
       in0 => b,
       in1 => signextimm,
       in2 => Input3,
       out1 => alu2
  );

U2 : alu
  port map(
       A => alu1,
       B => alu2,
       ctrl(2) => control(6),
       ctrl(1) => control(5),
       ctrl(0) => control(4),
       sign => control(2),
       zero => zeroflag,
       result => alubreg
  );

U20 : mux2x1_24
  port map(
       sel => control(1),
       in0 => a,
       in1 => aluout,
       out1 => pcsrc
  );

U22 : register_24bit
  port map(
       din => alubreg,
       clk => clk,
       dout => aluout
  );

U23 : register_24bit
  port map(
       din => BUS3388,
       clk => clk,
       dout => a
  );

U24 : register_24bit
  port map(
       din => BUS1426,
       clk => clk,
       dout => b
  );

U25 : register_24bit
  port map(
       din => memoutbreg,
       clk => clk,
       dout => memoryout
  );

U3 : ContUnit
  port map(
       state => state,
       opcode => opcode,
       cond => cond,
       sf => sf,
       zero => zeroreg,
       clk => clk,
       nextstate => nextstate,
       flags => control
  );

U4 : mux4x1_24
  port map(
       sel(1) => control(15),
       sel(0) => control(14),
       in0 => memoryout,
       in1(23) => Dangling_Input_Signal,
       in1(22) => Dangling_Input_Signal,
       in1(21) => Dangling_Input_Signal,
       in1(20) => Dangling_Input_Signal,
       in1(19) => Dangling_Input_Signal,
       in1(18) => Dangling_Input_Signal,
       in1(17) => Dangling_Input_Signal,
       in1(16) => Dangling_Input_Signal,
       in1(15) => Dangling_Input_Signal,
       in1(14) => Dangling_Input_Signal,
       in1(13) => Dangling_Input_Signal,
       in1(12) => Dangling_Input_Signal,
       in1(11) => Dangling_Input_Signal,
       in1(10) => Dangling_Input_Signal,
       in1(9) => Dangling_Input_Signal,
       in1(8) => Dangling_Input_Signal,
       in1(7) => Dangling_Input_Signal,
       in1(6) => Dangling_Input_Signal,
       in1(5) => Dangling_Input_Signal,
       in1(4) => Dangling_Input_Signal,
       in1(3) => Dangling_Input_Signal,
       in1(2) => Dangling_Input_Signal,
       in1(1) => Dangling_Input_Signal,
       in1(0) => Dangling_Input_Signal,
       in2 => aluout,
       in3 => luiimm,
       out1 => regwriteback
  );

U5 : memory
  port map(
       clk => clk,
       address => adress,
       wflag => control(17),
       dataIn => aluout,
       rflag => control(16),
       dataOut => memoutbreg
  );

U6 : pc
  port map(
       enable => pcen,
       pc_in => pcsrc,
       pc_out => pcbus
  );

U7 : rotate
  port map(
       in1 => BUS4565,
       out1 => luiimm
  );

U8 : sign_extender
  port map(
       in1 => BUS4565,
       out1 => signextimm
  );

U9 : status_register_8bit
  port map(
       din => zeroflag,
       wflag => control(3),
       dout => zeroreg
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end DataPath;
