LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY seismil_bin IS
	Port(seis_mil : out std_logic_vector(12 downto 0));
END seismil_bin;

ARCHITECTURE sol OF seismil_bin IS
BEGIN
	seis_mil<="1011101110000";--"1011101110000"
END sol;

