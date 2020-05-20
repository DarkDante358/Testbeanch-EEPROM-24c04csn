----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: MEMORY
-- Desc: Collection of 512 WORDS ith simple logic
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

entity MEMORY is
    Port ( CelAdd : IN STD_LOGIC_VECTOR (7 downto 0);
           WORD: INOUT STD_LOGIC_VECTOR (7 downto 0);
           RW: IN STD_LOGIC;
           RESET: IN STD_LOGIC);
end MEMORY;

architecture Behavioral of MEMORY is

begin


end Behavioral;
