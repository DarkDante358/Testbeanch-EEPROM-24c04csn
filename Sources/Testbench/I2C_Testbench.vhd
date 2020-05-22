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
  
    signal t_SDA : STD_LOGIC := 'Z';
    signal t_SCL : STD_LOGIC := '1';
    signal t_tDATA: STD_LOGIC_VECTOR (7 downto 0);
    signal t_ACTIONS: STD_LOGIC;
    signal t_RESET: STD_LOGIC := '1';
    signal t_START: STD_LOGIC := '0';
    signal t_SCL90: STD_LOGIC :='0';
    signal internal_SCL : STD_LOGIC := '1';
    signal flag : STD_LOGIC := '0';
    signal f_awaiting : STD_LOGIC := '0';
  
    component I2C is
      Port ( SDA : INOUT STD_LOGIC;
             SCL : IN STD_LOGIC;
             DATA: INOUT STD_LOGIC_VECTOR (7 downto 0);
             ACTIONS: IN STD_LOGIC;
             RESET: IN STD_LOGIC);
    end component I2C;
  
    constant time_base : time := 25000ns;
  
  begin
 -- Component instances
    uut : I2C
    Port map ( 
        SDA => t_SDA,
        SCL => t_SCL,
        ACTIONS => t_ACTIONS,
        RESET => t_RESET
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
    
    
-- test
--    data_send : process(t_SCL90)
--    begin
--        if(t_SCL90'event and t_SCL90 = '1' and flag = '1') then
--            t_SDA <= t_tDATA(0);
--                    t_tDATA <= 'Z' & t_tDATA (7 downto 1);
--        end if;  
--     end process data_send;


  sym : process
  begin
  t_RESET <= '1'; -- reset uk³adu
  wait for time_base;
  t_RESET <= '0';
  
  t_SDA <= '1'; ---- Start bit
   wait for time_base;
  t_SDA <= '0';
  wait for time_base; -- Konice bitu startu
  t_START <= '1';
  t_tDATA <= "00001100";
  -- Wys³anie 8 bitów, np liczba 12
  t_SDA <= '1';
  wait for time_base*8;
  t_SDA <= 'Z';
  --wait until rising_edge (t_SCL);
  wait for time_base/2;
  wait until t_SDA = '0';
  f_awaiting <= '0';
  -- Czekanie na ACK z modu³u I2C
  
  t_START <= '0';
  
  wait for time_base/2; -- bit stopu
  t_SDA <= '1';
  wait for time_base*2;
  t_START <= '0';
  t_SDA <= 'Z'; -- koniec transmisji
  wait for time_base*4;
  
  assert false report "Tests Complete" severity failure;
  
  end process sym;
  
  t_SCL <= internal_SCL when t_START = '1' else '1';
    
end behave;