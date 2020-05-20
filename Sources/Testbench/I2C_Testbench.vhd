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
    signal t_SCL : STD_LOGIC := 'Z';
    signal t_DATA: STD_LOGIC_VECTOR (7 downto 0);
    signal t_ACTIONS: STD_LOGIC;
    signal t_RESET: STD_LOGIC := '1';
    signal t_START: STD_LOGIC := '0';
    signal t_SCL90: STD_LOGIC :='0';
  
--    component I2C is
--      Port ( SDA : INOUT STD_LOGIC;
--             SCL : OUT STD_LOGIC;
--             DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
--             ACTIONS: IN STD_LOGIC;
--             RESET: IN STD_LOGIC);
--    end component I2C;
  
    constant time_base : time := 25000ns;
  
  begin
-- Component instances
--    uut : I2C
--    Port map ( 
--        SDA => t_SDA,
--        SCL => t_SCL,
--        DATA => t_DATA,
--        ACTIONS => t_ACTIONS,
--        RESET => t_RESET
--    );
    
    times : process
    begin
    if(t_START = '1') then
        t_SCL <= not t_SCL after time_base/2;
    else
         t_SCL <= '1';
    end if;
    end process times;
    
    times90 : process
    begin
        wait for time_base/2;
        t_SCL90 <= t_SCL;
    end process times90;
-- test

  sim : process
  begin
  t_RESET <= '1';
  wait for 100ns;
  t_RESET <= '0';
  wait for 10ns;
  t_SDA <= '0';
  t_START <= '1';
  wait for 12500ns*9*2;
  wait until rising_edge(t_SCL);
  t_SDA <= '1';
  t_START <= '0';
  wait for 100ns;
  
  assert false report "Tests Complete" severity failure;
  
  end process sim;
  
end behave;
