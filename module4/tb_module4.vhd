--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : tb_module4
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity tb_module4 is
--  Port ( );
end tb_module4;

architecture Behavioral of tb_module4 is

component module4 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m)
        );
end component;

signal n: integer := 7;
signal m: integer := 5;

signal A: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);
signal X: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal B: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal Xnext: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal G_out: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);

begin
m4: module4 generic map(n, m) port map(A, X, B, Xnext, G_out);

-- Read matrix A
A <= readMat("A.input.dat", n+m, n+m);
-- Read matrix X
X <= readMat("X.input.dat", n+m, 1);
-- Read matrix B
B <= readMat("B.input.dat", n+m, 1);
--Write matrix X to file 
process
begin
    wait for 5ns;
    writeMat(Xnext, "X_next.output.dat");
end process;
--Write matrix G to file 
process
begin
    wait for 7ns;
    writeMat(G_out, "G.output.dat");
end process;


end Behavioral;
