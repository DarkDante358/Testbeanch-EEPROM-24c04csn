----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: I2C
-- Desc: I2C transciver
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity I2C is
  Port ( SDA : INOUT STD_LOGIC;
         SCL : OUT STD_LOGIC;
         DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
         ACTIONS: IN STD_LOGIC;
         RESET: IN STD_LOGIC);
end I2C;

architecture Behavioral of I2C is

begin


end Behavioral;
