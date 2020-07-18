--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : module2
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;


entity module2 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        DA: out mem(1 to n+m, 1 to n+m));
end module2;

architecture Behavioral of module2 is

begin

    process(A, X)
    variable tmp1, tmp3, tmp5: signed (2*w - 1 downto 0);
    variable tmp2, tmp4, tmp6: signed(w-1 downto 0);
    variable res: mem(1 to n+m, 1 to n+m);
    begin
        res := copyMat(A);
        for i in 1 to n loop
            tmp1 := to_signed(L_const, w) * to_signed(R_const, w);
            tmp2 := tmp1(w-1 downto 0);
            tmp3 := tmp2 * signed(X(i, 1));
            tmp4 := tmp3(w-1 downto 0);
            tmp5 := tmp4 * signed(X(i, 1));
            tmp6 := tmp5(w-1 downto 0);
            res(i, i) := std_logic_vector(tmp6);
        end loop;
        DA <= res;        
    end process;

end Behavioral;
