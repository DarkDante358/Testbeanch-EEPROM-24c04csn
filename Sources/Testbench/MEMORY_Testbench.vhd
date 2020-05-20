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
    
    signal t_CelAdd :  STD_LOGIC_VECTOR (7 downto 0);
    signal t_WORD:  STD_LOGIC_VECTOR (7 downto 0);
    signal t_RW:  STD_LOGIC := 'Z';
    signal t_RESET:  STD_LOGIC ;
    
    component MEMORY is
        Port ( CelAdd : IN STD_LOGIC_VECTOR (7 downto 0);
           WORD: INOUT STD_LOGIC_VECTOR (7 downto 0);
           RW: IN STD_LOGIC;
           RESET: IN STD_LOGIC);
    end component MEMORY;
 
  begin
-- Component instances
    uut : MEMORY
     Port map ( CelAdd => t_CelAdd,
           WORD => t_WORD,
           RW => t_RW,
           RESET => t_RESET); 
      

  sim : process
  begin
  t_RESET <= '1';
  wait for 10ns;
  t_RESET <= '0';
  wait for 10ns;
  t_celAdd <= "01000000";
  t_WORD <= X"4c"; 
  wait for 10ns;
  t_RW <= '0';
  wait for 10ns;
  t_RW <= 'Z';
  wait for 10ns;
  t_celAdd <= "00100000";
  t_WORD <= X"4e"; 
  wait for 10ns;
  t_RW <= '0';
  wait for 10ns;
  t_RW <= 'Z';
  wait for 10ns;
  t_celAdd <= "00100000";
  wait for 10ns;
  t_RW <= '1';
  wait for 10ns;
  t_RW <= 'Z';
  wait for 10ns;
  t_celAdd <= "01000000";
  wait for 10ns;
  t_RW <= '1';
  wait for 100ns;
  
  
  assert false report "Tests Complete" severity failure;
  end process sim;
  
end behave;
