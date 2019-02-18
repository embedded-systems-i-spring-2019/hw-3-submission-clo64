-- Charles Owen
-- Embedded Systems
-- HW 3
-- Problem 1

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HW_main is
   Port(
        A_in, B_in      : in std_logic_vector(7 downto 0); -- mux inputs
        sel, ld, clk    : in std_logic;                    -- sel, load, and clock input
        reg_a           : out std_logic_vector(7 downto 0) -- output of our register
                    
           
   );
end HW_main;

architecture Behavioral of HW_main is

signal mux_intermediate    : std_logic_vector(7 downto 0); -- signal to store input, later fed to register
                                                           -- populated with select statement below process

begin

register_process: process (clk) -- our action process

    begin
        
            if (rising_edge(clk)) then
            
                if (ld = '1') then -- looks to see if load is one, if yes, loads register with data
                                   -- from the select statement below process statement here
                    reg_a <= mux_intermediate;
                    
                end if;
                
            end if;
    
    end process;
    
with sel select -- This uses out select lines to choose which data is expressed during the register loads

    mux_intermediate <= A_in when '1',
                        B_in when '0',
                        (others => '0') when others;


end Behavioral;
