LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY contador_3seg IS
	PORT(clock,enable,reset : IN STD_LOGIC;
		 tres_seg : OUT STD_LOGIC;
		 Q : Buffer STD_LOGIC_VECTOR (1 downto 0));
END contador_3seg;

ARCHITECTURE sol OF contador_3seg IS
BEGIN

	PROCESS(clock,reset)
	BEGIN
		if reset='0' then Q<="00";tres_seg<='0';
  		elsif (clock'event and clock='1') then
			if enable='1' then
				if (Q="11") then Q<="00";tres_seg<='1';
				else Q<=Q+1;tres_seg<='0';
				end if;
			end if;
		end if;
	END PROCESS;
END sol;