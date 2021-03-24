library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use ieee.numeric_std.all;


entity mouse_info is
Port (Clock: in std_logic;
      Rst:in std_logic;
      Mouse_Data: inout  std_logic;
      Mouse_Clock: inout std_logic;
  
      Number : out std_logic_vector(15 downto 0));
end mouse_info;

architecture Behavioral of mouse_info is
signal Mouse_bits:std_logic_vector(5 downto 0);
signal one_second_counter:std_logic_vector(26 downto 0);
signal one_second_enable:std_logic;
signal displayed_number:std_logic_vector(15 downto 0);


begin
process(Mouse_Clock, Rst)
begin
if rising_edge(Mouse_Clock) then 
  if(Rst='1') then
            Mouse_bits <= "000000";
        elsif(Mouse_bits <="011111") then
            Mouse_bits <= Mouse_bits + 1;
        else 
             Mouse_bits <= "000000";
    end if;
end if;
end process; 


process(Mouse_Clock, Rst) 
begin
if falling_edge(Mouse_Clock) then
  if(Rst='1') then 
         displayed_number <= x"0000";
  elsif(Mouse_bits ="000001") then 
          if(Mouse_Data='1') then 
                displayed_number <= displayed_number + 1;
            end if;
  elsif(Mouse_bits="000010") then 
          if(Mouse_Data='1' and displayed_number>0) then 
               displayed_number <= displayed_number - 1;
           end if;
  end if;
end if;
end process;

Number <= displayed_number;


end Behavioral;
