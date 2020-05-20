----------------------------------------------------------------------------------
-- Authors: Jakub Wójcik, Dominik Rudzik, Karolina Sroczyk
-- Name: I2C
-- Desc: I2C transciver
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity I2C is
  Port ( SDA : INOUT STD_LOGIC;
         SCL : IN STD_LOGIC;
         DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
         ACTIONS: IN STD_LOGIC;
         RESET: IN STD_LOGIC);
end I2C;

architecture Behavioral of I2C is
    constant WORD_SIZE : integer := 8;

    type  i2c_states IS (wait_for_start, start, recive_data, stop, send_ack, send_data);
	signal state, next_state : i2c_states := wait_for_start;
    
    signal SCL_counter : integer := 0;
    
    signal internal_SDA : STD_LOGIC := 'Z';
begin

    reg : process(next_state, RESET) -- process which switches states
    begin
        if (RESET='1') then
            state <= wait_for_start;
        else
            state <= next_state;
        end if;
    end process reg;
    
    machine: process(RESET, SCL, SDA) -- process which selects next state
    begin
         if(RESET = '1') then
            next_state <= wait_for_start;
        else      
            case state is
                when wait_for_start => 
                    if(SCL = '1' and falling_edge(SDA)) then
                        next_state <= start;
                    end if;
                    
                when start => 
                    if(falling_edge(SCL)) then
                        next_state <= recive_data;
                    end if;
                    
                when recive_data => 
                    if(SCL_counter = WORD_SIZE + 1) then
                        next_state <= stop;
                    end if;
                    
                when stop =>              
                    if(SCL = '1' and rising_edge(SDA)) then
                            next_state <= start;
                        end if;
            end case;
        end if;
    end process machine;
    
    scl_counter_proc : process (SCL, RESET, STATE)
    begin

        if (state = stop and RESET = '1') then
            scl_counter <= 0;
        elsif(state = recive_data and rising_edge(SCL) and scl_counter <= WORD_SIZE + 1) then
            scl_counter <= scl_counter + 1;
        end if;
            
    end process scl_counter_proc;
    

    SDA <= internal_SDA;

end Behavioral;
