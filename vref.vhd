LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY vref IS
	generic ( B: std_logic_vector(7 downto 0):="10110010");--178
	Port(Bref : out std_logic_vector(7 downto 0));
END vref;

ARCHITECTURE sol OF vref IS
BEGIN
	Bref<=B;
END sol;
