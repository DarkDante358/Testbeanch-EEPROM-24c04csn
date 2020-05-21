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
    signal t_WORD:  STD_LOGIC_VECTOR (7 downto 0) := (others => 'Z');
    signal t_RW:  STD_LOGIC := 'Z';
    signal t_RESET:  STD_LOGIC ;
    --signal t_GET_RESPONSE: STD_LOGIC := '0';
    
    component MEMORY is
        Port ( CelAdd : IN STD_LOGIC_VECTOR (7 downto 0);
           WORD: INOUT STD_LOGIC_VECTOR (7 downto 0);
           RW: IN STD_LOGIC;
           --GET_RESPONSE : IN STD_LOGIC;
           RESET: IN STD_LOGIC);
    end component MEMORY;
 
  begin
-- Component instances
    uut : MEMORY
     Port map ( CelAdd => t_CelAdd,
           WORD => t_WORD,
           RW => t_RW,
           --GET_RESPONSE => t_GET_RESPONSE,
           RESET => t_RESET); 
      

  sim : process
  begin
  -- Reset 
  t_RESET <= '1';
  wait for 10ns;
  t_RESET <= '0';
  wait for 10ns;
  
  t_celAdd <= "00000000"; -- selecting word cell 0
  t_WORD <= "00001010"; -- DEC 10 to data lines
  wait for 10ns;
  t_RW <= '1'; -- write mode
  wait for 10ns;
  t_RW <= 'Z'; -- disconnect
  wait for 10ns;
  
  t_celAdd <= "00000001"; -- selecting word cell 1
  t_WORD <= "00010100"; -- DEC 20 to data lines
  wait for 10ns;
  t_RW <= '1'; -- write mode
  wait for 10ns;
  t_RW <= 'Z'; -- disconnect
  wait for 10ns;
  
  t_WORD <= (others => 'Z'); -- t_WORD to "IN" mode
  
  wait for 10ns;
  t_celAdd <= "00000000"; -- selecting word cell 0
  t_RW <= '0';  -- read mode
  wait for 10ns;
  t_RW <= 'Z'; -- disconnect
  wait for 10ns;
  
  t_celAdd <= "00000001"; -- selecting word cell 1
  t_RW <= '0'; -- read mode
  wait for 10ns;
  t_RW <= 'Z'; -- disconnect
  wait for 10ns;
  
  assert false report "Tests Complete" severity failure;
  end process sim;
  
end behave;
