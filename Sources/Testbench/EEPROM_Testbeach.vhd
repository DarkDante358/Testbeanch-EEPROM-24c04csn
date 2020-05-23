----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: EEPROM_Testbench - only I2C
-- Desc: Testbench Testing MASTER and EEPROM components
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity EEPROM_Testbench is
end EEPROM_Testbench;
 
architecture behave of EEPROM_Testbench is
 
  signal t_CLK     : std_logic := '0';
  signal t_Button    : std_logic := '0';
  signal t_Reset : std_logic := '1';
  signal t_A  : std_logic_vector (2 downto 0) := (others => '0');
  signal t_SDA : std_logic;
  signal t_SCL : std_logic;
  signal t_ACTIONS : std_logic_vector (1 downto 0) := (others => '0');
  
  signal first_loop : std_logic := '1';
  
   component I2C is
      Port ( SDA : INOUT STD_LOGIC;
             SCL : IN STD_LOGIC;
             DATA: INOUT STD_LOGIC_VECTOR (7 downto 0); -- Komunikacja z innym modu³em
             ACTIONS: IN STD_LOGIC_VECTOR (1 downto 0); -- Komunikacja z innym modu³em
             REG_SELECT: OUT STD_LOGIC_VECTOR (1 downto 0); -- Komunikacja z innym modu³em
             A: IN STD_LOGIC_VECTOR (2 downto 0); -- Jeszcze nie aktywne
             RESET: IN STD_LOGIC);
    end component I2C;

    component MASTER is
    port (
      SDA : inout  std_logic;
      SCL : out std_logic;
      CLK : in std_logic; 
      Button   : in std_logic; 
      Reset : in  std_logic 
      );
    end component MASTER;
  
    constant clk_period : time := 10 ns; -- 100 MHz (tyle co ma makieta)
  
  begin
    clk_proc : process
    begin
        t_CLK  <= '0';
        wait for clk_period/2;
        t_CLK <= '1';
        wait for clk_period/2;
    end process clk_proc;
    
-- Component instances
    uut1 : I2C
    Port map (
      ACTIONS => t_ACTIONS,
      RESET => t_RESET,
      SDA => t_SDA,
      SCL => t_SCL,
      A => t_A
      );
      
    uut2 : MASTER
    Port map (
      Reset => t_Reset,
      CLK => t_CLK,
      Button => t_Button,
      SDA => t_SDA,
      SCL => t_SCL
      );

-- test

  sim : process
  begin
    if(first_loop = '1') then
        t_RESET <= '1';
        wait for clk_period*2;
        t_RESET <= '0';
        
        first_loop <= '0';
    end if;
   
    
    t_BUTTON <= '1';
    wait for clk_period*2;
    t_BUTTON <= '0';
    
    wait for 1ms;    
  end process sim;
  
end behave;
