--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : tb_module1
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_module1 is
--  Port ( );
end tb_module1;

architecture Behavioral of tb_module1 is

component module1 is
    generic (n: integer := 7;
            m: integer := 5);
  Port (A: in mem(1 to n+m, 1 to n+m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        F: out mem(1 to n+m, 1 to 1));
end component;

signal n: integer := 7;
signal m: integer := 5;

signal A: mem(1 to n+m, 1 to n+m) := getMem(n+m, n+m);
signal X: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal B: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);
signal F: mem(1 to n+m, 1 to 1) := getMem(n+m, 1);

begin
m1: module1 generic map(n, m) port map(A, X, B, F);

-- Read matrix A
A <= readMat("A.input.dat", n+m, n+m);
--Read matrix X   
X <= readMat("X.input.dat", n+m, 1);
--Read matrix B  
B <= readMat("B.input.dat", n+m, 1);
--Write matrix F to file 
process
begin
    wait for 5ns;
    writeMat(F, "F.output.dat");
end process;


end Behavioral;
