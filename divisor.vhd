library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.componentes.all;

Entity divisor is
	generic (n: integer := 13);
	Port( Clock, Resetn, Start, LdA	: in std_logic;
			DataA, DataB					: in std_logic_vector ( n-1 downto 0);
			R, Q								: buffer std_logic_vector ( n-1 downto 0);
			Done								: out std_logic);
end divisor;

Architecture comportamiento of divisor is

	type estado is (S1, S2, S3);
	signal y : estado;
	signal Zero, Cout, Cig0, EnA, EnB, Rsel, LdR, EnR, ER0, LdC, EnC, r0 : std_logic;
	signal A, B, DataR : std_logic_vector (n-1 downto 0);
	signal Sum : std_logic_vector (n downto 0); --Era n downto 0
	signal Count : integer range 0 to n-1;

Begin

	--MSS: Transiciones
	Process (Resetn, Clock)
	Begin
		If Resetn='0' then y<= S1;
		Elsif (Clock'event and Clock='1') then
			Case y is
				when S1=> if Start='0' then y<= S1; else y<= S2; end if;
				when S2=> if Cig0='0' then y<= S2; else y<= S3; end if;
				when S3=> if Start='1' then y<= S3; else y<= S1; end if;
			end case;
		end if;
	end process;
	
	--MSS: Salidas
	Process(Start, y, Cout, Cig0)
	Begin
		LdR<='0'; EnR<='0'; ER0<='0'; LdC<='0'; EnC<='0'; EnA<='0'; Done<='0'; Rsel<='0'; EnB<=EnA;
		Case y is
			when S1=> LdC<='1'; EnC<='1'; EnR<='1';
						 If start='0' then LdR<='1';
							if LdA='1' then EnA<='1'; else EnA<='0'; end if;
						 else EnA<='1'; ER0<='1'; end if;
			when S2=> Rsel<='1'; EnR<='1'; ER0<='1'; EnA<='1';
						 If Cout='1' then LdR<='1'; else LdR<='0';  end if;
						 If Cig0='0' then EnC<='1'; else EnC<='0';  end if;
			when S3=> Done<='1';
		end case;
	end process;
	
	--Procesador de Datos
	Zero<='0';
	
	RestoR: registro_d_i generic map (n => n)
		port map (Resetn, Clock, EnR, LdR, r0, DataR, R);
		
	DivisorB: registro_sost generic map (n => n)
		port map (Resetn, Clock, EnB, DataB, B);
		
	Mux_FFD: mux_dff port map (A(n-1), Zero, ER0, Clock, r0);
	
	DividiendoA: registro_d_i generic map (n => n)
		port map (Resetn, Clock, EnA, LdA, Cout, DataA, A);
	Q<=A;

	ContadorDown: contador_down generic map (m => n)
		port map (Resetn, Clock, EnC, LdC, Count);
		
	Puerta_NOR: Cig0 <='1' when Count = 0 else '0';
	
	Sum <= R & r0 + not B + 1;
	Cout<= Sum(n);
	DataR <= (OTHERS => '0') when Rsel ='0' else Sum;
	
end comportamiento;