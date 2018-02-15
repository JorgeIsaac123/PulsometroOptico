LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY contador_UP IS
	PORT(clock,enable,reset : IN STD_LOGIC;
		 Q : Buffer STD_LOGIC_VECTOR (7 downto 0));
END contador_UP;

ARCHITECTURE sol OF contador_UP IS
BEGIN

	PROCESS(clock,reset)
	BEGIN
		if reset='0' then Q<="00000000";
  		elsif (clock'event and clock='1') then
			if enable='1' then Q<=Q+1; end if;
		end if;
	END PROCESS;
END sol;