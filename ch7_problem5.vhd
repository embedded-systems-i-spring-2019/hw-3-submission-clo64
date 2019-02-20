-- Charles Owen
-- Embedded Systems
-- HW 3
-- Problem 5

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ch7_problem5 is
        Port(
            SL1, SL2, CLK       : in std_logic; -- selects and clock signal
            A_IN, B_IN, C_IN    : in std_logic_vector(7 downto 0); -- input A for reg A, B and C for mux one
            RAX, RBX            : out std_logic_vector(7 downto 0) -- register outputs
        
        );
end ch7_problem5;

architecture Behavioral of ch7_problem5 is

signal mux_one_int  : std_logic_vector(7 downto 0); -- mux intermediate signal
signal reg_A, reg_B : std_logic_vector( 7 downto 0); -- register bundles

begin

-- set RA output
RAX <= reg_A;

-- set RB output;
RBX <= reg_B;

-- build mux one
with SL2 select

    mux_one_int <= B_in when '1',
                   C_in when '0',
                   (others => '0') when others;
                   
register_A: process (CLK)
            begin
            
                if rising_edge(CLK) then
                
                    if (SL1 = '1') then
                    
                        reg_A <= A_IN;
                    
                    end if;
                   
                end if;
                
            end process;
            
register_B: process (CLK)
            begin
            
                if rising_edge(CLK) then
                
                    if (SL1 = '0') then
                    
                        reg_B <= mux_one_int;
                        
                    end if;
                    
               end if;
               
             end process;


end Behavioral;
