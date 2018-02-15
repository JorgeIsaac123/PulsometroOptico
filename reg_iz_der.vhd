library ieee;
use ieee.std_logic_1164.all;

ENTITY reg_iz_der IS
	GENERIC (n: integer:= 8);
	PORT(	enable, ld			: IN	STD_LOGIC;
			resetn,clk	: IN	STD_LOGIC;
			R			: IN 	STD_LOGIC;
			P			: IN 	STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Q			: BUFFER STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END reg_iz_der;

ARCHITECTURE comportamiento OF reg_iz_der IS
BEGIN
	PROCESS (resetn,clk)
	BEGIN
		IF resetn = '0' THEN Q <= (OTHERS =>'0');
		ELSIF clk'EVENT AND clk='1' THEN
			IF enable='1' AND ld='0' THEN
				desplazamiento: for i in 0 to n-2 loop
					Q(i)<= Q(i+1);
				end loop;
				Q(n-1)<= R;
			ELSIF enable='1' AND ld='1' THEN
				Q<= P;
			END IF;
		END IF;
	END PROCESS;
END comportamiento;