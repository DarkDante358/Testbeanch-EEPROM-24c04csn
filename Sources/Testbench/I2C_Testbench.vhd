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
  
    signal t_SDA : STD_LOGIC := 'Z';
    signal t_SCL : STD_LOGIC := '1';
    signal t_DATA: STD_LOGIC_VECTOR (7 downto 0);
    signal t_ACTIONS: STD_LOGIC;
    signal t_RESET: STD_LOGIC := '1';
    signal t_START: STD_LOGIC := '0';
    signal t_SCL90: STD_LOGIC :='0';
    signal internal_SCL : STD_LOGIC := '1';
  
    component I2C is
      Port ( SDA : INOUT STD_LOGIC;
             SCL : IN STD_LOGIC;
             DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
             ACTIONS: IN STD_LOGIC;
             RESET: IN STD_LOGIC);
    end component I2C;
  
    constant time_base : time := 25000ns;
  
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
    
    times : process
    begin
        internal_SCL <= '0';
        wait for time_base/2;
        internal_SCL <= '1';
        wait for time_base/2;
    end process times;
-- test

  sym : process
  begin
  t_RESET <= '1';
  wait for time_base;
  t_RESET <= '0';
  t_SDA <= '1';
   wait for time_base;
  t_SDA <= '0';
  wait for time_base;
  t_START <= '1';
  wait for time_base*9;
  t_START <= '0';
  wait for time_base/2;
  t_SDA <= '1';
  wait for time_base*2;
  t_START <= '0';
  t_SDA <= 'Z';
  wait for time_base*4;
  
  assert false report "Tests Complete" severity failure;
  
  end process sym;
  
  t_SCL <= internal_SCL when t_START = '1' else '1';
    
end behave;
