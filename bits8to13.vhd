LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY bits8to13 IS
	Port(	Ent		: in std_logic_vector(7 downto 0);
			Q : out std_logic_vector(12 downto 0));
END bits8to13;

ARCHITECTURE sol OF bits8to13 IS
BEGIN
	Q<="00000" & Ent;
END sol;

