----------------------------------------------------------------------------------
-- Authors: Jakub Wo³jcik, Dominik Rudzik, Karolina Sroczyk
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
         A: IN STD_LOGIC_VECTOR (2 downto 0);
         DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
         ACTIONS: IN STD_LOGIC;
         RESET: IN STD_LOGIC);
end I2C;

architecture Behavioral of I2C is
    constant WORD_SIZE : integer := 8;
    constant tHIGH : time := 0.6 us; -- Datasheet Table 5, used for delay of data sampling, to not hit SCL state change
    constant tAA : time := 0.1 us; -- Clock Low to Data Out Valid 
    constant minimalTimeStep : time := 0.1 us; -- Minimal time needed for delay in data sampling
    
    signal device_address: STD_LOGIC_VECTOR (6 downto 0) := "1010000"; -- Holds device address
    
    signal time_steps : integer := 0; -- Count of minimal time steps since last start of the transmition
    signal shot_time_steps : integer := 0; -- How many time steps since state change
    signal delta_time_steps : integer := 0; -- How many steps form shot to current

    type  i2c_states IS (wait_for_start, start, recive_data, stop, send_ack, send_data, reset_scl_counter);
	signal state, next_state, temp_state : i2c_states := wait_for_start;
    
    signal SCL_counter : integer := 0; -- holds count of SCL cycles since last restart
    
    signal internal_SDA : STD_LOGIC := 'Z';
    signal is_reciver : STD_LOGIC := '0';
    
begin
    
    device_address(1) <= A(1);
    device_address(2) <= A(2);
   
    reg : process(next_state, RESET) -- process which switches states
    begin
        if (RESET='1') then
            state <= wait_for_start;
        else
            state <= next_state;
        end if;
    end process reg;
    
    time_steps_proc : process -- process witch counts time steps
    begin
    
        if(state = start) then -- time steps are so much denser than SCL frequency, that this solution is enough
            time_steps <= 0;
        end if;
        
        wait for minimalTimeStep;
        time_steps <= time_steps+1;
        
        if(time_steps > shot_time_steps) then
            delta_time_steps <= time_steps - shot_time_steps;
        else 
            delta_time_steps <= 0;
        end if;
    end process time_steps_proc;
    
    time_step_proc2 : process (state) -- determines state change
    begin 
        shot_time_steps <= time_steps;    
    end process time_step_proc2;
    
    machine: process(RESET, SCL, SDA) -- process which selects next state
    begin
         if(RESET = '1') then
            next_state <= wait_for_start;
            temp_state <= wait_for_start;
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
                    if(SCL_counter = WORD_SIZE) then
                        temp_state <= send_ack;
                        next_state <= reset_scl_counter;
                    end if;
                 
                when send_ack =>
                    if(SCL_counter = 1) then
                        next_state <= stop;
                    end if;
                
                when send_data =>
                    -- TODO
                
                when reset_scl_counter =>
                    if(SCL_counter = 0) then
                        next_state <= temp_state;
                    end if;
                    
                when stop =>              
                    if(SCL = '1' and rising_edge(SDA)) then
                        next_state <= start;
                    end if;
            end case;
        end if;
    end process machine;
    
    scl_counter_proc : process (SCL, RESET, STATE)  -- counts SCL rising pulses since last restart
    begin

        if (state = reset_scl_counter or state = start or state = stop or RESET = '1') then
            scl_counter <= 0;
        elsif(rising_edge(SCL)) then
            scl_counter <= scl_counter + 1;
        end if;
            
    end process scl_counter_proc;
    
    send_ack_proc : process (state, delta_time_steps)   -- sneds ACK bit
    begin
        if(state = send_ack and delta_time_steps = 1) then
            internal_SDA <= '0';
        end if;
    end process send_ack_proc;
    
    role_changer_proc : process (state) -- determines whether module is a receiving or transmitting information
    begin 
    
        if(state = send_ack or state = send_data) then
            is_reciver <= '0';
        else
            is_reciver <= '1';
        end if;
    
    end process role_changer_proc;    
   
    SDA <= internal_SDA when is_reciver = '1' else 'Z';

end Behavioral;
