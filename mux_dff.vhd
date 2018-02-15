LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;

ENTITY mux_dff IS
	Port( I1, I0 : in std_logic;
			sel, Clock : in std_logic;
			Q : out std_logic);
END mux_dff;

ARCHITECTURE comportamiento OF mux_dff IS
	signal D : std_logic;
BEGIN
	with sel select
	D<=	I1 when '1',
			I0 when others;
	Process
	Begin
		wait until (Clock'event and Clock='1');
		Q<=D;
	End process;
END comportamiento;