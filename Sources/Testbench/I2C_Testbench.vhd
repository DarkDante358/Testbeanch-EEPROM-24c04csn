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
  
    signal t_SDA : STD_LOGIC;
    signal t_SCL : STD_LOGIC;
    signal t_DATA: STD_LOGIC_VECTOR (7 downto 0);
    signal t_ACTIONS: STD_LOGIC;
    signal t_RESET: STD_LOGIC;
  
    component I2C is
      Port ( SDA : INOUT STD_LOGIC;
             SCL : OUT STD_LOGIC;
             DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
             ACTIONS: IN STD_LOGIC;
             RESET: IN STD_LOGIC);
    end component I2C;
  
  begin
-- Component instances
    uut : I2C
    Port map ( 
        SDA => t_SDA,
        SCL => t_SCL,
        DATA => t_DATA,
        ACTIONS => t_ACTIONS,
        RESET => t_RESET
    );

-- test

  sim : process
  begin
  end process sim;
  
end behave;
