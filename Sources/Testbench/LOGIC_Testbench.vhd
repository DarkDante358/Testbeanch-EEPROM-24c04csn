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
  
   signal t_CLK: STD_LOGIC;
   signal t_CellAdd: STD_LOGIC_VECTOR(7 downto 0);
   signal t_WORD: STD_LOGIC_VECTOR(7 downto 0);
   signal t_DATA: STD_LOGIC_VECTOR(7 downto 0);
   signal t_ACTIONS: STD_LOGIC_VECTOR(1 downto 0);
   signal t_RW: STD_LOGIC;
   signal t_RESET: STD_LOGIC;

component LOGIC is
      Port ( CellAdd: OUT STD_LOGIC_VECTOR(7 downto 0);
             WORD: OUT STD_LOGIC_VECTOR(7 downto 0);
             DATA: OUT STD_LOGIC_VECTOR(7 downto 0);
             ACTIONS: OUT STD_LOGIC_VECTOR(1 downto 0);
             CLK: IN STD_LOGIC;
             RW: OUT STD_LOGIC;
             RESET: IN STD_LOGIC);
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
        CellAdd => t_CellAdd,
        WORD => t_WORD,
        DATA => t_DATA,
        ACTIONS => t_ACTIONS,
        CLK => t_CLK,
        RW => t_RW,
        RESET => t_RESET);

-- test
sim : process
  begin
  end process sim;
  
end behave;
