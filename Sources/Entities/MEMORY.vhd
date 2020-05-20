----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: MEMORY
-- Desc: Collection of 512 WORDS ith simple logic
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MEMORY is
    Port ( CelAdd : IN STD_LOGIC_VECTOR (7 downto 0);
           WORD: INOUT STD_LOGIC_VECTOR (7 downto 0);
           RW: IN STD_LOGIC;
           RESET: IN STD_LOGIC);
end MEMORY;

architecture Behavioral of MEMORY is
    
    -- 4k memory structore (512 words)
    type cell_structure is array (0 to 511) of std_logic_vector(7 downto 0);
    signal memory : cell_structure := (others => (others => '0'));
    
begin

   mem : process (RESET, RW)
   begin
    
    if(RESET = '1') then
        memory <= (others => (others => '0')); -- memory cleared
    elsif(RW /= 'Z') then -- Waiting for CellAdd and WORD
        if(RW = '1') then -- Read mode
            WORD <= memory(to_integer(unsigned(CelAdd)));
        else -- Write mode
            memory(to_integer(unsigned(CelAdd))) <= WORD;
        end if;
    end if;
 
   end process mem;

end Behavioral;
