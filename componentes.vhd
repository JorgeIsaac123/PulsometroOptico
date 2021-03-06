library ieee;
use ieee.std_logic_1164.all;

package componentes is
	
	component registro_d_i
		Generic(n: Integer := 8);
		Port(Resetn, Clock, En, Ld, L : in std_logic;
				DataIn : in std_logic_vector(n-1 downto 0);
				Q : buffer std_logic_vector(n-1 downto 0));
	end component;
	
	component registro_sost
		Generic(n: Integer := 8);
		Port(Resetn, Clock, En : in std_logic;
				DataIn : in std_logic_vector(n-1 downto 0);
				Q : out std_logic_vector(n-1 downto 0));
	end component;
	
	component contador_down
		Generic(m: Integer := 16);
		Port(Resetn, Clock, En, Ld: in std_logic;
				Q : buffer integer range 0 to m-1);
	end component;
	
	component mux_dff
	Port( I1, I0 : in std_logic;
			sel, Clock : in std_logic;
			Q : out std_logic);
	END component;
	
end package componentes;