library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;  
use IEEE.STD_LOGIC_ARITH.all; 
 
entity division is  
    generic(SIZE: INTEGER := 13); 
    port(resetn: in STD_LOGIC; 
        en: in STD_LOGIC; 
        clk: in STD_LOGIC; 
         
        num: in STD_LOGIC_VECTOR((SIZE - 1) downto 0); 
        den: in STD_LOGIC_VECTOR((SIZE - 1) downto 0); 
        res: out STD_LOGIC_VECTOR((SIZE - 1) downto 0); 
        rm: out STD_LOGIC_VECTOR((SIZE - 1) downto 0);
		  DoneDivision : out std_logic
        ); 
end division; 
 
architecture behav of division is 
    signal buf: STD_LOGIC_VECTOR((2 * SIZE - 1) downto 0); 
    signal dbuf: STD_LOGIC_VECTOR((SIZE - 1) downto 0); 
    signal sm: INTEGER range 0 to SIZE; 
	 
	 signal done : std_logic;
	 signal fin : std_logic;
     
    alias buf1 is buf((2 * SIZE - 1) downto SIZE); 
    alias buf2 is buf((SIZE - 1) downto 0); 
begin 
    p_001: process(resetn, en, clk) 
    begin 
        if resetn = '0' then 
            res <= (others => '0'); 
            rm <= (others => '0'); 
            sm <= 0; Done<= '0'; fin<= '0';buf2 <= (others => '0'); 
        elsif rising_edge(clk) then 
            if en = '1' and fin='0' then 
                case sm is 
                when 0 => 
                    buf1 <= (others => '0'); 
                    buf2 <= num; 
                    dbuf <= den;
                    sm <= sm + 1; 
						  if Done='1' then
								DoneDivision <= '1'; 
                    res <= buf2; 
                    rm <= buf1; 
								fin <= '1'; end if;
                when others => 
                    if buf((2 * SIZE - 2) downto (SIZE - 1)) >= dbuf then 
                        buf1 <= '0' & (buf((2 * SIZE - 3) downto (SIZE - 1)) - dbuf((SIZE - 2) downto 0)); 
                        buf2 <= buf2((SIZE - 2) downto 0) & '1'; 
                    else 
                        buf <= buf((2 * SIZE - 2) downto 0) & '0'; 
                    end if; 
                    if sm /= SIZE then 
                        sm <= sm + 1;
								DoneDivision <= '0';
                    else 
                        sm <= 0;
								Done<= '1';
                    end if; 
                end case; 
				elsif en='0' then DoneDivision <= '0';sm <= 0; Done<= '0'; fin<= '0';buf2 <= (others => '0'); 
            end if; 
        end if; 
    end process; 
end behav;