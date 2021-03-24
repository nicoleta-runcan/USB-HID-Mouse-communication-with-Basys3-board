library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display is
 Port (
         Clk  : in  STD_LOGIC;
        
          Rst  : in  STD_LOGIC;
         
          Data : in  std_logic_vector(15 downto 0); 
          Anode_Activate   : out STD_LOGIC_VECTOR (3 downto 0); 
                 -- semnale pentru anozi (active in 0 logic)
          Led_out  : out STD_LOGIC_VECTOR (6 downto 0)
                 -- semnale pentru segmentele (catozii) cifrei active
          );
end display;

architecture Behavioral of display is
signal led_BCD:INTEGER;
signal refresh_counter:std_logic_vector(20 downto 0);
signal led_activating_counter:std_logic_vector(1 downto 0);
signal Data_sign:INTEGER;
begin

Data_sign<=conv_integer(Data);

process(Clk, Rst)
begin
if rising_edge(Clk) then 
 if(Rst='1') then 
   refresh_counter<="000000000000000000000";
else
  refresh_counter <= refresh_counter + 1;
 end if;
end if;
end process; 

led_activating_counter <= refresh_counter(20 downto 19);

process(led_activating_counter)
begin

    case led_activating_counter is
        when "00" => Anode_Activate <= "0111";
                    led_BCD <= (Data_sign / 1000);

        when "01" => Anode_Activate <= "1011";
                    led_BCD <= (Data_sign mod 1000)/100;

        when "10" => Anode_Activate <= "1101";
                    led_BCD <=((Data_sign mod 1000) mod 100)/10;

        when "11" => Anode_Activate <= "1110";
                    led_BCD <= ((Data_sign mod 1000)mod 100) mod 10;
    end case;

end process;
process(led_BCD)
begin
    case led_BCD is
        when 0 => Led_Out <= "0000001";
        when 1 => Led_Out <= "1001111";
        when 2  => Led_Out <="0010010";
        when 3 => Led_Out <= "0000110";
        when 4 => Led_Out <= "1001100";
        when 5  => Led_Out <="0100100";
        when 6 => Led_Out <= "0100000";
        when 7 => Led_Out <= "0001111";
        when 8  => Led_Out <="0000000";
        when 9  => Led_Out <="0000100";
        when others=>Led_Out<="0000001";
    end case;
end process;

end Behavioral;


