----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: EEPROM
-- Desc: Collection of components designed to mimic 24C04 EEPROM
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EEPROM is
    Port ( RESET : in STD_LOGIC;
           WP : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (2 downto 0);
           SCL : in STD_LOGIC;
           SDA : inout STD_LOGIC);
end EEPROM;

architecture Behavioral of EEPROM is

begin


end Behavioral;
