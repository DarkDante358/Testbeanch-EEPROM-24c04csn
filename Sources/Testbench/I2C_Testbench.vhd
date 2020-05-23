----------------------------------------------------------------------------------
-- Authors: Jakub Wo³jcik, Dominik Rudzik, Karolina Sroczyk
-- Name: I2C_Testbench
-- Desc: Testbench testing I2C component
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
 
entity I2C_Testbench is
end I2C_Testbench;
 
architecture behave of I2C_Testbench is
  
    signal t_SDA : STD_LOGIC := 'H';
    signal t_SCL : STD_LOGIC := '1';
    signal t_tDATA: STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal internal_SDA1: STD_LOGIC := 'Z';
    signal internal_SDA2: STD_LOGIC := 'Z';
    signal t_ACTIONS: STD_LOGIC_VECTOR (1 downto 0) := "00";
    signal t_RESET: STD_LOGIC := '1';
    signal t_START: STD_LOGIC := '0';
    signal t_SCL90: STD_LOGIC :='0';
    signal internal_SCL : STD_LOGIC := '1';
    signal flag : STD_LOGIC := '0';
    signal flag_send : STD_LOGIC := '0';
    signal t_a : STD_LOGIC_VECTOR (2 downto 0) := "000";
    
    signal counter : integer := 0;
    
    component I2C is
      Port ( SDA : INOUT STD_LOGIC;
             SCL : IN STD_LOGIC;
             DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
             ACTIONS: IN STD_LOGIC_VECTOR (1 downto 0);
             REG_SELECT: OUT STD_LOGIC_VECTOR (1 downto 0);
             RESET: IN STD_LOGIC;
             A: IN STD_LOGIC_VECTOR (2 downto 0));
    end component I2C;
  
    constant time_base : time := 25000ns;
  
  begin
 -- Component instances
    uut : I2C
    Port map ( 
        SDA => t_SDA,
        SCL => t_SCL,
        ACTIONS => t_ACTIONS,
        RESET => t_RESET,
        A => t_a
    );
    
    times : process
    begin
        internal_SCL <= '0';
        wait for time_base/2;
        internal_SCL <= '1';
        wait for time_base/2;
    end process times;
    
     times2 : process
    begin
        wait for time_base/4;
        t_SCL90 <= '0';
        wait for time_base/2;
        t_SCL90 <= '1';
        wait for time_base/4;
    end process times2;
    
    data_send : process(t_SCL90, flag, counter, t_SCL)
    begin
        if(falling_edge(t_SCL90) and flag = '1' and counter > 0) then
            if(t_tDATA(8-counter)='1') then
                internal_SDA1 <= 'H';
            else
                internal_SDA1 <= '0';
            end if;
        end if;  
        
        if( falling_edge(t_SCL)) then
            if(counter < 8) then
               counter <= counter +1;
            elsif(counter >= 8) then
                flag_send <= '1';
            end if;
        end if;
         
        if (flag = '0') then
            counter <= 0;
            flag_send <= '0';
            internal_SDA1 <= 'H';   
        end if;
     end process data_send;


  sym : process
  begin
  --Reset
  t_RESET <= '1'; 
  wait for time_base;
  t_RESET <= '0';
  
  --Start
   internal_SDA2 <= 'H'; 
   wait for time_base;
  internal_SDA2 <= '0';
  wait for time_base; 
  t_START <= '1';
  
  --Adress of device
  t_tData <= "00111001";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');

 --Cell Aderess
  t_tData <= "00111111";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');
  
  --Word
  t_tData <= "10000001";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');
  wait for time_base;
  
  --Stop
  t_START <= '0';
  internal_SDA2 <= '0';
  wait for time_base/2; 
  internal_SDA2 <= 'H';
  wait for time_base*2;
  internal_SDA2 <= 'H'; -- koniec transmisji
  wait for time_base*4;
  
  
  -- transmisja 2
  
    --Start
   internal_SDA2 <= 'H'; 
   wait for time_base;
  internal_SDA2 <= '0';
  wait for time_base; 
  t_START <= '1';
  
  --Adress of device
  t_tData <= "00000001";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');

 --Cell Aderess
  t_tData <= "11000000";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');
  
  --Word
  t_tData <= "01111110";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');
  wait for time_base;
  
  --Stop
  t_START <= '0';
  internal_SDA2 <= '0';
  wait for time_base/2; 
  internal_SDA2 <= 'H';
  wait for time_base*2;
  internal_SDA2 <= 'H'; -- koniec transmisji
  wait for time_base*4;
  
  -- transmisja 3
  
 --Start
   internal_SDA2 <= 'H'; 
   wait for time_base;
  internal_SDA2 <= '0';
  wait for time_base; 
  t_START <= '1';
  
  --Adress of device
  t_tData <= "00000000";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');

 --Cell Aderess
  t_tData <= "01010000";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');
  
  --Word
  t_tData <= "01010101";
  flag <= '1';
  wait until flag_send = '1';
  flag <= '0';
  
  --Waiting for ack
  wait until (t_SDA = '0' and t_SCL = '1');
  wait for time_base;
  
  --Stop
  t_START <= '0';
  internal_SDA2 <= '0';
  wait for time_base/2; 
  internal_SDA2 <= 'H';
  wait for time_base*2;
  internal_SDA2 <= 'H'; -- koniec transmisji
  wait for time_base*4;
  
  assert false report "Tests Complete" severity failure;
  
  end process sym;
  
  t_SCL <= internal_SCL when t_START = '1' else '1';
  t_SDA <= internal_SDA1 when flag ='1' else internal_SDA2;
  
end behave;