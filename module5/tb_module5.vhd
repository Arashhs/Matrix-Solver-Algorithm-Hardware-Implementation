--  Student ID  : 9631019
--  Student Name: Arash Hajisafi
--  Student Mail: hajisafiarash@gmail.com
--  *******************************************************
--  Module: PDS Project : tb_module5
--  *******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.pds_utils.ALL;

entity tb_module5 is
--  Port ( );
end tb_module5;

architecture Behavioral of tb_module5 is

component module5 is
    generic (n: integer := 4;
            m: integer := 3);
  Port (A12: in mem(1 to n, 1 to m);
        X: in mem(1 to n+m, 1 to 1);
        B: in mem(1 to n+m, 1 to 1);
        clk: in std_logic;
        Xnext: out mem(1 to n+m, 1 to 1);
        G_out: out mem(1 to n+m, 1 to n+m)
        );
end component;

signal n: integer := 4;
signal m: integer := 3;

signal A12: mem(1 to n, 1 to m);
signal X: mem(1 to n+m, 1 to 1);
signal B: mem(1 to n+m, 1 to 1);
signal Xnext: mem(1 to n+m, 1 to 1);
signal G_out: mem(1 to n+m, 1 to n+m);

signal clk: std_logic := '0';

begin
final_module: module5 generic map(n, m) port map(A12, X, B, CLK, Xnext, G_out);

clk <= not clk after 10ns;

-- Read matrix A12
A12 <= readMat("A12.csv", n, m);
-- Read matrix X
X <= readMat("X.csv", n+m, 1);
-- Read matrix B
B <= readMat("B.csv", n+m, 1);


end Behavioral;
