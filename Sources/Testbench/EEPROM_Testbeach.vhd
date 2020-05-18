----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: EEPROM_Testbench
-- Desc: Testbench Testing MASTER and EEPROM components
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity EEPROM_Testbench is
end EEPROM_Testbench;
 
architecture behave of EEPROM_Testbench is
 
  signal t_CLK     : std_logic := '0';
  signal t_Button    : std_logic := '1';
  signal t_Reset : std_logic := '1';
  signal t_A  : std_logic_vector (2 downto 0) := (others => '0');
  signal t_SDA : std_logic := 'Z';
  signal t_SCL : std_logic := 'Z';
  signal t_WP : std_logic := '0';
  
    component EEPROM is
    port (
      e_Reset       : in  std_logic;
      e_A : in std_logic_vector (2 downto 0); -- BIty
      e_WP : in std_logic; -- ochrona wczytania WP = 1 zapis
      e_SDA   : inout std_logic; -- szyna danych
      e_SCL : in  std_logic --  szyna zegara
      );
    end component EEPROM;

    component MASTER is
    port (
      m_SDA : inout  std_logic;
      m_SCL : in std_logic;
      m_CLK : in std_logic; 
      m_Button   : inout std_logic; 
      m_Reset : in  std_logic 
      );
    end component MASTER;
  
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
    uut1 : EEPROM
    Port map (
      e_Reset => t_Reset,
      e_A => t_A,
      e_WP => t_WP,
      e_SDA => t_SDA,
      e_SCL => t_SCL
      );
      
    uut2 : MASTER
    Port map (
      m_Reset => t_Reset,
      m_CLK => t_CLK,
      m_Button => t_Button,
      m_SDA => t_SDA,
      m_SCL => t_SCL
      );

-- test

  sim : process
  begin
  end process sim;
  
end behave;
