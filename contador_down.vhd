library ieee;
use ieee.std_logic_1164.all;

Entity contador_down is
	Generic(m: Integer := 16);
	Port(Resetn, Clock, En, Ld: in std_logic;
			Q : buffer integer range 0 to m-1);
end contador_down;

Architecture comportamiento of contador_down is
Begin
	Process(Resetn, Clock)
	Begin
		if Resetn='0' then Q<=0;
		elsif (Clock'event and Clock='1') then
			if En='1' then
				if Ld='1' then Q<= m-1;
				else Q<=Q-1; end if;
			end if;
		end if;
	end process;
end comportamiento;