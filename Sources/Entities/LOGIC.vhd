----------------------------------------------------------------------------------
-- Authors: Jakub Wo³jcik, Dominik Rudzik, Karolina Sroczyk
-- Name: LOGIC
-- Desc: Logic responible for encoding and decoding data from/to I2C, MEMORY modules
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

entity LOGIC is
  Port ( CellAdd: OUT STD_LOGIC_VECTOR(7 downto 0);
         WORD: OUT STD_LOGIC_VECTOR(7 downto 0);
         DATA: OUT STD_LOGIC_VECTOR(7 downto 0);
         ACTIONS: OUT STD_LOGIC_VECTOR(1 downto 0);
         CLK: IN STD_LOGIC;
         RW: OUT STD_LOGIC;
         RESET: IN STD_LOGIC);
end LOGIC;

architecture Behavioral of LOGIC is

begin


end Behavioral;
