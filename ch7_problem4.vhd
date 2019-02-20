--Charles Owen
-- Embedded Systems
-- HW 3
-- Problem 4

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ch7_problem4 is
        Port(
            LDB, S1, LDA    : in std_logic; 
            S0, CLK, RD     : in std_logic;
            X_IN, Y_in      : in std_logic_vector(7 downto 0);
            RB              : inout std_logic_vector(7 downto 0);
            RA              : out std_logic_vector(7 downto 0)
        
        );
end ch7_problem4;

architecture Behavioral of ch7_problem4 is

-- All of our intermediate signals declared here. Self commenting names. 
signal LDB_and_notRD    : std_logic;
signal mux_one_int      : std_logic_vector(7 downto 0);
signal mux_two_int      : std_logic_vector(7 downto 0);
signal RB_feedback      : std_logic_vector(7 downto 0);
signal LDA_and_RD       : std_logic;
signal reg_A, reg_B     : std_logic_vector(7 downto 0);

begin

-- And gate for LDB and not RD --
LDB_and_notRD <= (LDB and not(RD));

-- And gate for LDA and RD --
LDA_and_RD <= (LDA and RD);

-- Link RB feedback to RB signal
RB_feedback <= RB;

-- Establish RB output
RB <= reg_B;

-- establish RA output
RA <= reg_A;

-- Build Mux one --
with S1 select

    mux_one_int <= X_IN when '1',
                   Y_IN when '0',
                   (others => '0') when others;
                   
-- Build Mux two --
with S0 select

    mux_two_int <= RB_feedback when '1',
                   Y_IN when '0',
                   (others => '0') when others;
                   
register_a: process (CLK) 
                    begin
                    
                        if falling_edge(CLK) then 
                        
                            if (LDA_and_RD = '1') then
                            
                                reg_A <= mux_two_int; -- loads register A signal with mux two data
                                
                            end if;
                            
                        end if;
                        
                     end process; 
                     
register_b: process (CLK)
            begin
            
                    if falling_edge(CLK) then
                    
                        if (LDB_and_notRD = '1') then
                        
                            reg_B <= mux_one_int; -- loads register B signal with mux one data
                            
                        end if;
                        
                    end if;
                    
            end process;
                   
   

end Behavioral;
