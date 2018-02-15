library ieee;
use ieee.std_logic_1164.all;

Entity controlador is
	Port( start, stop, Min, Max, Resetn, Clock : in std_logic;
			DoneDivision, pendiente, mayor_BPMmax, menor_BPMmin, ok3s, cntStart, primera, pendienteN, pico : in std_logic;
			LedVerde, enStart, resetn3s, en3s, s1, s0, resetnStart, enPrim, resetnPrim, LdProm, resetnProm : out std_logic;
			enProm, resetnReg, enCNT, resetnCNT, resetnDivisor, StartDivisor, enRegMax, enRegMin, inMin : out std_logic);
end controlador;

Architecture comportamiento of controlador is
	type estado is (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Tp, Q, R, S, T, U, V, Tv, W, X);
	signal y : estado;

Begin
	--MSS: Transiciones
	Process (Resetn, Stop, Start, Clock)
	Begin
		if Resetn = '0' then y<=A;
		elsif Stop = '1' and (y=D or y=E or y=F or y=G or y=H or y=M or y=N or y=O or y=P) then y<=Q;
		elsif Start='1' and (y=D or y=E or y=F or y=G or y=H or y=M) then y<=N;
		elsif (Clock'event and Clock='1') then
			Case y is
				when A => if start='1' then y<=B; else y<=A; end if;
				when B => if start='0' then y<=C; end if;
				when C => y<=D;
				when D => if stop='1' then y<=Q;
							 elsif start='1' then y<=N;
							 elsif pendiente='1' then y<=F;
							 else y<=E; end if;
				when E => if pendienteN='0' then y<=F; end if;
				when F => if pendiente='1' then y<=F;
							 elsif pico='1' then y<=G; else y<=E; end if;
				when G => if pendienteN='0' then y<=H; end if;
				when H => if pendiente='1' then y<=H;
							 elsif pico='1' then y<=I; else y<=G; end if;
				when I => if primera='0' then y<=K; else y<=J; end if;
				when J => y<=L;
				when K => y<=L;
				when L => y<=M;
				when M => if DoneDivision='1' then y<=D; end if;
				when N => if start='1' then y<=N; elsif cntStart='0' then y<=O;
							 elsif ok3s='1' then y<=P; else y<=A; end if;
				when O => y<=D;
				when P => y<=Tp;
				when Tp => y<=D;
				when Q => if stop='0' then y<=R; end if;
				when R => if stop='1' then y<=S; elsif start='1' then y<=T;
							 elsif Max='1' then y<=W; elsif Min='1' then y<=X;
							 else y<=R; end if;
				when S => if stop='0' then y<=C; end if;
				when T => if start='1' then y<=T; elsif cntStart='0' then y<=U;
							 elsif ok3s='1' then y<=V; else y<=A; end if;
				when U => y<=R;
				when V => y<=Tv;
				when Tv => y<=R;
				when W => if Max='0' then y<=R; end if;
				when X => if Min='0' then y<=R; end if;
			end case;
		end if;
	end process;
	
	--MSS: Salidas
	Process(y, pendiente, mayor_BPMmax, menor_BPMmin)
	Begin
		LedVerde<='0'; enStart<='0'; resetn3s<='0'; en3s<='0'; s1<='0'; s0<='0'; resetnStart<='0'; enPrim<='0'; resetnPrim<='0'; LdProm<='0'; resetnProm<='0';
		enProm<='0'; resetnReg<='0'; enCNT<='0'; resetnCNT<='0'; resetnDivisor<='0'; StartDivisor<='0'; enRegMax<='0'; enRegMin<='0'; inMin<='0';
		Case y is
			when A => resetn3s<='1'; resetnStart<='1'; resetnDivisor<='1';
			when B => 
			when C => enRegMin<='1'; inMin<='1'; resetnReg<='1'; LedVerde<='1'; resetnProm<='1'; enPrim<='1';
			when D => LedVerde<='1';
			when E => LedVerde<='1';
			when F => LedVerde<='1'; if (pendiente='0' and pico='1') then resetnCNT<='1'; end if;
			when G => LedVerde<='1'; enCNT<='1';
			when H => LedVerde<='1'; enCNT<='1';
			when I => LedVerde<='1'; enProm<='1'; LdProm<='1';
			when J => resetnPrim<='1';
			when K => LedVerde<='1'; enProm<='1';
			when L => LedVerde<='1'; StartDivisor<='1';
			when M => LedVerde<='1'; StartDivisor<='1';
						 if (DoneDivision='1' and menor_BPMmin='1') then enRegMin<='1'; end if;
						 if (DoneDivision='1' and mayor_BPMmax='1') then enRegMax<='1'; end if;
			when N => 
			when O => enStart<='1'; en3s<='1';
			when P => resetn3s<='1';
			when Tp => en3s<='1';
			when Q =>
			when R =>
			when S =>
			when T =>
			when U => enStart<='1'; en3s<='1';
			when V => resetn3s<='1';
			when Tv => en3s<='1';
			when W => s1<='1';
			when X => s0<='1';
		end case;
	end process;
end comportamiento;