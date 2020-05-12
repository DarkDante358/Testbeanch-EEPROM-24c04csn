----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2020 18:53:36
-- Design Name: 
-- Module Name: EEPROM_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity EEPROM_tb is
end EEPROM_tb;
 
architecture behave of EEPROM_tb is
 
  component EEPROM_WRITE is
    port (
      clk       : in  std_logic;
      Bits_A : out std_logic_vector (2 downto 0); -- BIty
      WP : out std_logic; -- ochrona wczytania WP = 1 zapis
      SDA   : out std_logic; -- szyna danych
      SDL : out  std_logic --  szyna zegara
      );
  end component EEPROM_WRITE;

 

 

  signal w_CLOCK     : std_logic := '0';
  signal w_WP     : std_logic := '1';
  signal w_SDA : std_logic := '1';
  signal w_Bits_A  : std_logic_vector (2 downto 0) := (others => '0');
  signal w_SDL : std_logic := '0';

  EEPROM_INST : EEPROM_WRITE
    port map (
      clk       => w_CLOCK,
      WP    => w_WP,
      SDA => w_SDA,
      SDL   => w_SDL,
      Bits_A => w_Bits_A
      );

 
  r_CLOCK <= not r_CLOCK after 50 ns; -- czas dla 20MHz
  

  sim : process
  begin

    --assert false report "Tests Complete" severity failure;
     
  end process sim;


end Behavioral;
