-------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : simpleCont
-- Author      : ASUS
-- Company     : bzu
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\simpleCont\simpleCont\compile\fff.vhd
-- Generated   : Wed Feb 15 16:20:49 2023
-- From        : c:\My_Designs\simpleCont\simpleCont\src\fff.bde
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

-- Included from components --
use ieee.NUMERIC_STD.all;

entity fff is 
end fff;

architecture fff of fff is

---- Component declarations -----

component mux2x1_24
  port(
       sel : in STD_LOGIC;
       in0 : in UNSIGNED(23 downto 0);
       in1 : in UNSIGNED(23 downto 0);
       out1 : out UNSIGNED(23 downto 0)
  );
end component;

----     Constants     -----
constant DANGLING_INPUT_CONSTANT : STD_LOGIC := 'Z';

---- Declaration for Dangling input ----
signal Dangling_Input_Signal : STD_LOGIC;
signal Dangling_Input_Signal_UNSIGNED : UNSIGNED(0 downto 0);

begin

----  Component instantiations  ----

U1 : mux2x1_24
  port map(
       sel => Dangling_Input_Signal,
       in0(23) => Dangling_Input_Signal_UNSIGNED(0),
       in0(22) => Dangling_Input_Signal_UNSIGNED(0),
       in0(21) => Dangling_Input_Signal_UNSIGNED(0),
       in0(20) => Dangling_Input_Signal_UNSIGNED(0),
       in0(19) => Dangling_Input_Signal_UNSIGNED(0),
       in0(18) => Dangling_Input_Signal_UNSIGNED(0),
       in0(17) => Dangling_Input_Signal_UNSIGNED(0),
       in0(16) => Dangling_Input_Signal_UNSIGNED(0),
       in0(15) => Dangling_Input_Signal_UNSIGNED(0),
       in0(14) => Dangling_Input_Signal_UNSIGNED(0),
       in0(13) => Dangling_Input_Signal_UNSIGNED(0),
       in0(12) => Dangling_Input_Signal_UNSIGNED(0),
       in0(11) => Dangling_Input_Signal_UNSIGNED(0),
       in0(10) => Dangling_Input_Signal_UNSIGNED(0),
       in0(9) => Dangling_Input_Signal_UNSIGNED(0),
       in0(8) => Dangling_Input_Signal_UNSIGNED(0),
       in0(7) => Dangling_Input_Signal_UNSIGNED(0),
       in0(6) => Dangling_Input_Signal_UNSIGNED(0),
       in0(5) => Dangling_Input_Signal_UNSIGNED(0),
       in0(4) => Dangling_Input_Signal_UNSIGNED(0),
       in0(3) => Dangling_Input_Signal_UNSIGNED(0),
       in0(2) => Dangling_Input_Signal_UNSIGNED(0),
       in0(1) => Dangling_Input_Signal_UNSIGNED(0),
       in0(0) => Dangling_Input_Signal_UNSIGNED(0),
       in1(23) => Dangling_Input_Signal_UNSIGNED(0),
       in1(22) => Dangling_Input_Signal_UNSIGNED(0),
       in1(21) => Dangling_Input_Signal_UNSIGNED(0),
       in1(20) => Dangling_Input_Signal_UNSIGNED(0),
       in1(19) => Dangling_Input_Signal_UNSIGNED(0),
       in1(18) => Dangling_Input_Signal_UNSIGNED(0),
       in1(17) => Dangling_Input_Signal_UNSIGNED(0),
       in1(16) => Dangling_Input_Signal_UNSIGNED(0),
       in1(15) => Dangling_Input_Signal_UNSIGNED(0),
       in1(14) => Dangling_Input_Signal_UNSIGNED(0),
       in1(13) => Dangling_Input_Signal_UNSIGNED(0),
       in1(12) => Dangling_Input_Signal_UNSIGNED(0),
       in1(11) => Dangling_Input_Signal_UNSIGNED(0),
       in1(10) => Dangling_Input_Signal_UNSIGNED(0),
       in1(9) => Dangling_Input_Signal_UNSIGNED(0),
       in1(8) => Dangling_Input_Signal_UNSIGNED(0),
       in1(7) => Dangling_Input_Signal_UNSIGNED(0),
       in1(6) => Dangling_Input_Signal_UNSIGNED(0),
       in1(5) => Dangling_Input_Signal_UNSIGNED(0),
       in1(4) => Dangling_Input_Signal_UNSIGNED(0),
       in1(3) => Dangling_Input_Signal_UNSIGNED(0),
       in1(2) => Dangling_Input_Signal_UNSIGNED(0),
       in1(1) => Dangling_Input_Signal_UNSIGNED(0),
       in1(0) => Dangling_Input_Signal_UNSIGNED(0)
  );


---- Dangling input signal assignment ----

Dangling_Input_Signal <= DANGLING_INPUT_CONSTANT;

end fff;
