-- Charles Owen
-- Embedded Systems
-- HW 3
-- Problem 2

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HW_main is
   Port(             
        DS, CLK             : in std_logic;     -- Our load selec, and clock signals
        MS                  : in std_logic_vector(2 downto 0);  -- musx select lines
        X_IN, Y_IN, Z_IN    : in std_logic_vector(7 downto 0);  -- mux data input lines
        RA                  : out std_logic_vector(7 downto 0); -- Register A output line
        RB                  : inout std_logic_vector(7 downto 0) -- Register B output line
           
   );
end HW_main;

architecture Behavioral of HW_main is

signal mux_int                  : std_logic_vector(7 downto 0); -- intermediate signal to carry mux data to reg A
signal zero_mux_feedback        : std_logic_vector(7 downto 0); -- feedback signal to carry Reg B data back to Mux data input
signal RA_to_RB                 : std_logic_vector(7 downto 0); -- intermediate signal to carry data from register A to reg B
signal RB_feedback              : std_logic_vector(7 downto 0); -- feedback signal from register B
signal reg_A                    : std_logic_vector(7 downto 0);
signal reg_B                    : std_logic_vector(7 downto 0);

begin

-- RA output set to reg_A
RA <= reg_A;

-- RB output set to reg_B
RB <= reg_B;

-- set RB feedback
RB_feedback <= RB;

Register_A:     process (CLK)   -- process for the first register in sequence
        begin
        
            if falling_edge(CLK) then
            
                if (DS = '0') then -- if DS selection is 0, then register A will load
                
                     reg_A <= mux_int;
                     
                 end if;
                 
            end if;                   
            
        end process;
        
Resister_B:     process(CLK)
        begin
        
            if falling_edge(CLK) then
            
                if (DS = '1') then  -- if DS selection is 1 on rising edge, then register B will load
                
                    reg_B <= reg_A;
                    
                end if;
                
           end if;
           
        end process;
        



with MS select -- simple mux to select which data is expressed into register A, and signal line RA_to_RB

    mux_int <=  X_IN when "00",
                Y_IN when "01",
                Z_IN when "10",
                RB_feedback when "11",
                (others => '0') when others;
                
   
end Behavioral;
