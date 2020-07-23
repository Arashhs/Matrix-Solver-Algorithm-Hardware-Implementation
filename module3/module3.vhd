--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : module3
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity module3 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (DA: in mem(1 to n+m, 1 to n+m);
        G: out mem(1 to n+m, 1 to n+m)
        );
end module3;

architecture Behavioral of module3 is
signal S: signed(w-1 downto 0) := (others => '0');
begin

    
    process(DA)
    variable diam1, diam2: signed(w-1 downto 0);
    variable s_var, neg_svar, temp: signed(w-1 downto 0);
    variable tmp_term: signed(2*w-1 downto 0);
    variable res: mem(1 to n+m, 1 to n+m);
    begin
        diam1 := to_signed(1, w);
        diam2 := to_signed(1, w);
        for i in 1 to n+m loop
            tmp_term := diam1 * signed(DA(i, i));
            diam1 := tmp_term(w-1 downto 0);
        end loop;
        
        for i in 1 to n+m loop
            tmp_term := diam2 * signed(DA(i, m+n-i+1));
            diam2 := tmp_term(w-1 downto 0);        
        end loop;
        temp := diam1 - diam2;
        s_var := shift_right(temp, z);  
        neg_svar := -s_var; 
        res := dotMul(neg_svar, transpose(DA));
        S <= s_var;
        G <= res;
    end process;



end Behavioral;
