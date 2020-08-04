--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : module4
--  *******************************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity module5 is
    generic (n: integer := 4;
            m: integer := 3);
  Port (A12: in mem(1 to n, 1 to m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m)
        );
end module5;

architecture Behavioral of module5 is

component module4 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m);
        Anext: out mem(1 to n+m, 1 to n+m)
        );
end component;
signal A_reg: mem(1 to n+m, 1 to n+m);
signal X_reg: mem(1 to n+m, 1 to 1);
signal Xnext_reg: mem(1 to n+m, 1 to 1);
signal G_reg: mem(1 to n+m, 1 to n+m);
signal Anext_reg: mem(1 to n+m, 1 to n+m);

begin
data_path: module4 generic map (7, 5) port map(A_reg, X_reg, B, Xnext_reg, G_reg, Anext_reg);
    process(A12)
    begin
        A_reg <= initA_with_A12 (A12);  
    end process;

end Behavioral;
