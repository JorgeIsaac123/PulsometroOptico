library ieee;  
use ieee.std_logic_1164.all;  
  
entity registro_d_i is  
    Generic(n: Integer := 8);
		Port(Resetn, Clock, En, Ld, L : in std_logic;
				DataIn : in std_logic_vector(n-1 downto 0);
				Q : buffer std_logic_vector(n-1 downto 0));
end registro_d_i;  
  
architecture comportamiento of registro_d_i is  
begin  
    process (Resetn, Clock)  
    begin  
        IF Resetn = '0' THEN Q <= (OTHERS =>'0');
		ELSIF Clock'EVENT AND Clock='1' THEN
			IF En='1' AND Ld='0' THEN
				Q<= Q(n-2 downto 0) & L;
			ELSIF En='1' AND Ld='1' THEN
				Q<= DataIn;
			END IF;
		END IF; 
    end Process;  
end comportamiento;


