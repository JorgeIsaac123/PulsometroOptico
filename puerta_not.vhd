Library ieee;
Use ieee.std_logic_1164.all;

Entity puerta_not is
	Generic (k: integer:= 4);
	Port (A : in std_logic_vector (k-1 downto 0);
			F : out std_logic_vector (k-1 downto 0));
End puerta_not ;

Architecture Comportamiento of puerta_not is
Begin	
	F<=NOT(A);	
End Comportamiento;
