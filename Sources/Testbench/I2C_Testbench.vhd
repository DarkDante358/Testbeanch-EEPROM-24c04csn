----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: I2C_Testbench
-- Desc: Testbench testing I2C component
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity I2C_Testbench is
end I2C_Testbench;
 
architecture behave of I2C_Testbench is
  
    component I2C is
    port (
      );
    end component I2C;
  
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
    uut : I2C
    Port map (
      );
      
-- test

  sim : process
  begin
  end process sim;
  
end behave;
