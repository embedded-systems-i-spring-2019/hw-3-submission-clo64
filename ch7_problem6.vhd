-- Charles Owen
-- Embedded Systems
-- HW 3
-- Problem 6


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ch7_problem6 is
        Port(
            SEL1, SEL2, CLK     : in std_logic; -- select lines and clock
            A_IN, B_IN, C_IN    : in std_logic_vector(7 downto 0); -- input data lines
            RAP, RBP            : out std_logic_vector(7 downto 0) -- our register output singals
        
        );
end ch7_problem6;

architecture Behavioral of ch7_problem6 is

signal mux_int          : std_logic_vector(7 downto 0); -- intermediate signal for mux one
signal reg_A, reg_B     : std_logic_vector(7 downto 0); -- intermediate signals for registers

begin

-- build multiplexor
with SEL1 select

    mux_int <= A_IN when '1',
               B_IN when '0',
               (others => '0') when others;
               
-- signal register A to RAP
RAP <= reg_A;

-- signal register B to RBP
RBP <= reg_B;

-- Process for register A
register_A: process (CLK)
            begin
            
                if rising_edge(CLK) then
                
                    if (SEL2 = '1') then
                    
                        reg_A <= mux_int;
                        
                     end if;
                     
                end if;
                
             end process;
             
-- process for register B
register_B: process (CLK)
            begin
            
                if rising_edge(CLK) then
                
                    if (SEL2 = '0') then
                    
                        reg_B <= C_IN;
                        
                    end if;
                    
                end if;
                
            end process;

end Behavioral;
