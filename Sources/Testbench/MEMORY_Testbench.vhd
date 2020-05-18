----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: MEMORY_Testbench
-- Desc: Testbench testing MEMORY component
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity MEMORY_Testbench is
end MEMORY_Testbench;
 
architecture behave of MEMORY_Testbench is
  
    component MEMORY is
    port (
      );
    end component MEMORY;
  
    constant clk_period : time := 10 ns; -- 100 MHz (tyle co ma makieta)
  
  begin
    clk_proc : process
    begin
        t_CLK  <= '0';
        wait for clk_period;
        t_CLK <= '1';
        wait for clk_period;
    end process clk_proc;
    
-- Component instances
    uut : MEMORY
    Port map (
      );
      
-- test

  sim : process
  begin
  end process sim;
  
end behave;
