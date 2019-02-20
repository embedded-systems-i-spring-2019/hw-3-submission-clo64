-- Charles Owen
-- Embedded Systems
-- HW 3
-- Problem 3
-- My best one yet!! --


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ch7_problem4 is
       Port(
            LDB, LDA, S1    : in std_logic; -- Load for A and B, select 1 for first mux
            S0, CLK         : in std_logic; -- select 0 for second mux, clock signal 
            X_in, Y_in      : in std_logic_vector(7 downto 0); -- x input bundle for first mux
            RB              : inout std_logic_vector(7 downto 0) -- Register B output bundle
       
       );
end ch7_problem4;

architecture Behavioral of ch7_problem4 is

signal mux_one_int      : std_logic_vector(7 downto 0); -- intermediate signal to carry mux data to reg A
signal reg_a_to_mux     : std_logic_vector(7 downto 0); -- intermediate signal to carry register A data to mux 2
signal mux_two_to_regb  : std_logic_vector(7 downto 0); -- intermediate signal to carry mux 2 data to register B
signal rb_feedback      : std_logic_vector(7 downto 0); -- feedback signal from reg b to mux 1

begin

-- Register B feedback --

rb_feedback <= RB;

-- build first mux -- This one takes X bundle input, and Register B feedback as data
with S1 select

    mux_one_int <= X_in when '1',
                   rb_feedback when '0',
                   (others => '0') when others; 
                   
-- build second mux -- This one takes Register A and Y bundle input as data
with S0 select

    mux_two_to_regb <= reg_a_to_mux when '1',
                       Y_in         when '0',
                       (others => '0') when others;   
                
-- process register A
   process_register_A: process (CLK) 
                       begin
                            
                        if rising_edge(CLK) then
                            
                           if (LDA = '1') then -- if load a input is one...
                           
                              reg_a_to_mux <= mux_one_int; -- we set register a to mux signal equal to first mux input.
                              
                           end if;
                           
                        end if; 
                        end process;   
                        
-- process register B
   process_register_B: process (CLK)
                       begin
                       
                        if rising_edge(CLK) then
                        
                            if (LDB = '1') then -- if load B is 1...
                            
                               RB <= mux_two_to_regb; -- we set register B to the second mux active data line
                               
                            end if;
                            
                        end if;
                        
                        end process;       


end Behavioral;
