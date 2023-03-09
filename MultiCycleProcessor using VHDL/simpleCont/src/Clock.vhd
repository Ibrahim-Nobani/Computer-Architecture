library ieee;
use ieee.std_logic_1164.all;

entity clock_generator is
    port (
        clk_out : out std_logic
    );
end entity;

architecture behavior of clock_generator is
begin
    process
    begin
        while true loop
            clk_out <= '0';
            wait for 30 ns;
            clk_out <= '1';
            wait for 30 ns;
        end loop;
    end process;
end architecture;