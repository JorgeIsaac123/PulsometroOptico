LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY reg_sost1bit IS
	PORT(clock,reset,enable: IN STD_LOGIC;
		 Ent : IN STD_LOGIC;
		 Q : OUT STD_LOGIC);
END reg_sost1bit;

ARCHITECTURE sol OF reg_sost1bit IS
SIGNAL temp: STD_LOGIC;
BEGIN
	PROCESS(clock,reset)
	BEGIN
		if reset='0' then temp<='0';
		elsif (clock'event and clock='1') then
			if(enable='1') then 
				temp<=Ent;
			end if;
		end if;
	end process;
	Q<=temp;
END sol;