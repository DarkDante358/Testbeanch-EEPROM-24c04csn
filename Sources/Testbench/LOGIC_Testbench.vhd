----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: I2C_Testbench
-- Desc: Testbench testing LOGIC component
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity LOGIC_Testbench is
end LOGIC_Testbench;
 
architecture behave of LOGIC_Testbench is
  
    component LOGIC is
    port (
      );
    end component LOGIC;
  
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
    uut : LOGIC
    Port map (
      );
      
-- test

  sim : process
  begin
  end process sim;
  
end behave;
