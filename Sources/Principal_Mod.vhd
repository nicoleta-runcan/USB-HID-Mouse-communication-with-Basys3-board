library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Principal_Mod is
  Port ( Clock: in std_logic;
         Rst:in std_logic;
         Rst_Dysp : in std_logic;
         Mouse_Data: inout  std_logic;
         Mouse_Clock: inout std_logic; 
         Anode_Activate:out std_logic_vector(3 downto 0);
         Led_out: out std_logic_vector(6 downto 0));
end Principal_Mod;

architecture Behavioral of Principal_Mod is
signal number_todisplay:std_logic_vector(15 downto 0);
begin
ps2_mouse: entity work.mouse_info port map
    (Clock=>Clock,
     Rst=>Rst, 
     Mouse_Data=>Mouse_Data,
     Mouse_Clock=>Mouse_Clock,
     Number => number_todisplay
     );
disp_number: entity work.display port map
    (Clk=>Clock,
     Rst=>Rst_Dysp,
     Data=>number_todisplay,
     Anode_Activate=>Anode_Activate,
     Led_out=>Led_out);    
end Behavioral;
